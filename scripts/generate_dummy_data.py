#!/usr/bin/env python3
"""
generate_dummy_data.py
======================
Fetches meal data from TheMealDB (free tier, no API key required) and writes
a valid lib/data/dummy_data.dart file for the sfrigola Flutter app.

Usage
-----
    # From the sfrigola-app root:
    pip install -r scripts/requirements.txt
    python scripts/generate_dummy_data.py

    # Optional flags:
    python scripts/generate_dummy_data.py --meals-per-category 8
    python scripts/generate_dummy_data.py --clear-cache

The script caches every HTTP response under scripts/cache/ so subsequent runs
are fast and offline-friendly.  Use --clear-cache to force fresh data.

Output
------
Overwrites lib/data/dummy_data.dart entirely.  The file is valid Dart with no
manual edits required.  Commit it like any other generated file.
"""

from __future__ import annotations

import argparse
import hashlib
import html
import json
import random
import re
import shutil
import sys
import time
from pathlib import Path
from typing import Optional

try:
    import requests
except ImportError:
    sys.exit("Missing dependency.  Run:  pip install -r scripts/requirements.txt")

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------

SCRIPT_DIR = Path(__file__).parent
REPO_ROOT   = SCRIPT_DIR.parent
CACHE_DIR   = SCRIPT_DIR / "cache"
OUTPUT_FILE = REPO_ROOT / "lib" / "data" / "dummy_data.dart"

# ---------------------------------------------------------------------------
# TheMealDB API
# ---------------------------------------------------------------------------

API_BASE = "https://www.themealdb.com/api/json/v1/1"

# ---------------------------------------------------------------------------
# Category mapping: TheMealDB strCategory → sfrigola category ID list
# The first ID in the list is the "primary" category for quota counting.
# ---------------------------------------------------------------------------

CATEGORY_MAP: dict[str, list[str]] = {
    "Pasta":         ["c1"],
    "Breakfast":     ["c7"],
    "Dessert":       ["c11"],
    "Seafood":       ["c12", "c10"],
    "Vegan":         ["c5"],
    "Vegetarian":    ["c5"],
    "Beef":          ["c4"],
    "Pork":          ["c4", "c3"],
    "Chicken":       ["c2"],
    "Lamb":          ["c6"],
    "Goat":          ["c6"],
    "Starter":       ["c3"],
    "Miscellaneous": ["c2"],
    "Side":          ["c12"],
}

# Override the primary category when a meal's strArea matches these areas.
AREA_CATEGORY_OVERRIDE: dict[str, list[str]] = {
    "Italian":     ["c1"],
    "French":      ["c9"],
    "Japanese":    ["c8"],
    "Chinese":     ["c8"],
    "Korean":      ["c8"],
    "Thai":        ["c8"],
    "Vietnamese":  ["c8"],
    "Indian":      ["c6"],
    "Moroccan":    ["c6"],
    "Tunisian":    ["c6"],
    "Mexican":     ["c3", "c6"],
    "American":    ["c2", "c3"],
    "Greek":       ["c12"],
    "Spanish":     ["c12", "c10"],
    "Turkish":     ["c6", "c12"],
    "Jamaican":    ["c6"],
    "German":      ["c4"],
}

# ---------------------------------------------------------------------------
# Dietary-flag inference keywords
# ---------------------------------------------------------------------------

_MEAT = {
    "chicken", "beef", "pork", "lamb", "bacon", "ham", "turkey", "veal",
    "duck", "tuna", "salmon", "shrimp", "prawn", "fish", "crab", "lobster",
    "anchov", "sardine", "cod", "halibut", "tilapia", "mince", "sausage",
    "salami", "chorizo", "pepperoni", "steak", "ribs", "mutton", "venison",
    "quail", "squid", "octopus", "clam", "mussel", "oyster", "scallop",
    "snapper", "trout", "mackerel", "herring", "anchovy", "pancetta",
    "lardons", "bresaola", "prosciutto",
}
_DAIRY = {
    "milk", "cream", "butter", "cheese", "yogurt", "yoghurt", "mozzarella",
    "parmesan", "cheddar", "brie", "feta", "mascarpone", "ricotta",
    "sour cream", "whipping cream", "double cream", "creme fraiche",
    "creme fraîche", "fromage frais", "ghee",
}
_GLUTEN = {
    "flour", "bread", "pasta", "spaghetti", "linguine", "fettuccine",
    "penne", "rigatoni", "tagliatelle", "wheat", "barley", "rye",
    "breadcrumb", "crouton", "tortilla", "couscous", "pita", "baguette",
    "bagel", "croissant", "noodle", "dumpling", "wonton", "gyoza",
    "semolina", "bulgur",
}
_LUXURIOUS = {"lobster", "truffle", "saffron", "foie gras", "wagyu", "kobe", "caviar"}
_PRICEY    = {
    "salmon", "tuna", "shrimp", "lamb rack", "duck breast",
    "scallop", "prawn", "crab", "veal",
}

# ---------------------------------------------------------------------------
# HTTP + cache helpers
# ---------------------------------------------------------------------------


def _cache_path(url: str) -> Path:
    digest = hashlib.md5(url.encode()).hexdigest()
    return CACHE_DIR / f"{digest}.json"


def fetch_json(url: str, delay: float = 0.25) -> dict:
    """GET *url* and return parsed JSON.  Response is cached to disk."""
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cp = _cache_path(url)
    if cp.exists():
        with cp.open(encoding="utf-8") as fh:
            return json.load(fh)

    time.sleep(delay)
    resp = requests.get(url, timeout=20)
    resp.raise_for_status()
    data = resp.json()
    with cp.open("w", encoding="utf-8") as fh:
        json.dump(data, fh)
    return data


def get_mealdb_categories() -> list[str]:
    data = fetch_json(f"{API_BASE}/categories.php")
    return [c["strCategory"] for c in (data.get("categories") or [])]


def list_meals_in_category(category: str) -> list[dict]:
    from urllib.parse import quote
    data = fetch_json(f"{API_BASE}/filter.php?c={quote(category)}")
    return data.get("meals") or []


def get_meal_detail(meal_id: str) -> Optional[dict]:
    data = fetch_json(f"{API_BASE}/lookup.php?i={meal_id}")
    meals = data.get("meals")
    return meals[0] if meals else None


# ---------------------------------------------------------------------------
# Data extraction helpers
# ---------------------------------------------------------------------------


def _has(text: str, keywords: set[str]) -> bool:
    t = text.lower()
    return any(kw in t for kw in keywords)


def extract_ingredients(meal: dict) -> list[str]:
    """Build ingredient strings from the TheMealDB strIngredientN / strMeasureN pairs."""
    result = []
    for i in range(1, 21):
        ing  = (meal.get(f"strIngredient{i}") or "").strip()
        meas = (meal.get(f"strMeasure{i}")    or "").strip()
        if ing:
            result.append(f"{meas} {ing}".strip() if meas else ing)
    return result


def parse_steps(raw: str) -> list[str]:
    """Split a TheMealDB instructions blob into discrete step strings."""
    if not raw or not raw.strip():
        return [
            "Prepare all the ingredients as described.",
            "Cook following the standard technique for this dish.",
            "Adjust seasoning to taste and serve.",
        ]

    # Normalise: HTML entities, carriage returns, excessive whitespace
    raw = html.unescape(raw)
    raw = raw.replace("\r\n", "\n").replace("\r", "\n")
    raw = re.sub(r"\n{3,}", "\n\n", raw).strip()

    # Strategy 1 — numbered steps  "1. ...\n2. ..."
    if re.search(r"^\d+[\.\)]\s", raw, re.MULTILINE):
        parts = re.split(r"\n(?=\d+[\.\)]\s)", raw)
        steps = [re.sub(r"^\d+[\.\)]\s*", "", p).replace("\n", " ").strip() for p in parts]
        steps = [s for s in steps if len(s) > 15]
        if len(steps) >= 2:
            return _normalise_steps(steps[:8])

    # Strategy 2 — double newline paragraphs
    paras = re.split(r"\n\n+", raw)
    if len(paras) >= 3:
        steps = [p.replace("\n", " ").strip() for p in paras if len(p.strip()) > 15]
        if len(steps) >= 2:
            return _normalise_steps(steps[:8])

    # Strategy 3 — single newlines
    lines = [l.strip() for l in raw.split("\n") if len(l.strip()) > 15]
    if len(lines) >= 3:
        return _normalise_steps(lines[:8])

    # Strategy 4 — sentence grouping (fallback)
    sentences = re.split(r"(?<=[.!?])\s+", raw)
    sentences = [s.strip() for s in sentences if len(s.strip()) > 15]
    if not sentences:
        return [raw[:300].strip()]

    chunk = max(1, len(sentences) // 5)
    groups: list[str] = []
    for i in range(0, len(sentences), chunk):
        g = " ".join(sentences[i : i + chunk]).strip()
        if g:
            groups.append(g)
    return _normalise_steps(groups[:8]) if groups else [raw[:300].strip()]


def _normalise_steps(steps: list[str]) -> list[str]:
    """Strip leading step numbers, tidy whitespace, ensure sentence ends with period."""
    out = []
    for s in steps:
        s = re.sub(r"^\d+[\.\)]\s*", "", s).strip()
        s = re.sub(r"\s{2,}", " ", s)
        if s and s[-1] not in ".!?":
            s += "."
        if s:
            out.append(s)
    return out


def infer_complexity(steps: list[str]) -> str:
    n = len(steps)
    if n <= 4:
        return "Complexity.simple"
    if n <= 6:
        return "Complexity.challenging"
    return "Complexity.hard"


def infer_affordability(ing_text: str) -> str:
    if _has(ing_text, _LUXURIOUS):
        return "Affordability.luxurious"
    if _has(ing_text, _PRICEY):
        return "Affordability.pricey"
    return "Affordability.affordable"


def _rng(sfr_id: str) -> random.Random:
    """Deterministic RNG keyed to the sfrigola meal ID (reproducible across runs)."""
    seed = int(hashlib.md5(sfr_id.encode()).hexdigest(), 16) & 0xFFFFFFFF
    r = random.Random(seed ^ 0xC0FFEE)
    return r


# ---------------------------------------------------------------------------
# Dart code generation helpers
# ---------------------------------------------------------------------------

_MAX_LINE = 76  # chars inside a Dart string literal before wrapping


def _esc(s: str) -> str:
    """Escape for a Dart single-quoted string.

    Single-quoted Dart strings cannot span multiple lines, so we must also
    replace any embedded newline/carriage-return characters with a space.
    """
    return (
        s.replace("\\", "\\\\")
         .replace("'", "\\'")
         .replace("\r\n", " ")
         .replace("\r", " ")
         .replace("\n", " ")
    )


def _dart_str(s: str, indent: int = 0) -> str:
    """
    Return a Dart string value (including surrounding quotes).
    Strings longer than _MAX_LINE are split using ' '\n 'continuation' concatenation.
    *indent* is the indentation of the opening quote in the output line.
    """
    s = _esc(s)
    if len(s) <= _MAX_LINE:
        return f"'{s}'"

    # Word-wrap
    pad  = " " * (indent + 4)
    words = s.split(" ")
    lines: list[str] = []
    cur   = ""
    for word in words:
        if cur and len(cur) + 1 + len(word) > _MAX_LINE:
            lines.append(cur)
            cur = word
        else:
            cur = f"{cur} {word}".strip() if cur else word
    if cur:
        lines.append(cur)

    # Each intermediate line needs a trailing space so that adjacent Dart
    # string literals concatenate correctly (e.g. 'foo ' 'bar' → 'foo bar').
    spaced = [line + " " for line in lines[:-1]] + [lines[-1]]
    return ("'\n" + pad + "'").join(spaced).join(["'", "'"])


def _dart_str_list(items: list[str], indent: int = 4) -> str:
    """Return the body of a Dart list literal (without the outer brackets)."""
    pad = " " * indent
    return "\n".join(f"{pad}{_dart_str(i, indent=indent)}," for i in items)


def meal_to_dart(sfr_id: str, meal: dict, category_ids: list[str]) -> str:
    rng = _rng(sfr_id)

    name      = (meal.get("strMeal")       or "Unknown").strip()
    image_url = (meal.get("strMealThumb")  or "").strip()
    mdb_cat   = (meal.get("strCategory")   or "Miscellaneous").strip()
    mdb_area  = (meal.get("strArea")       or "").strip()

    ingredients  = extract_ingredients(meal)[:10]
    ing_text     = " ".join(ingredients).lower()
    steps        = parse_steps(meal.get("strInstructions") or "")

    complexity    = infer_complexity(steps)
    affordability = infer_affordability(ing_text)

    _dur_range = {
        "Complexity.simple":      (15, 35),
        "Complexity.challenging": (35, 70),
        "Complexity.hard":        (70, 150),
    }
    lo, hi   = _dur_range[complexity]
    duration = rng.randint(lo, hi)
    servings = rng.randint(2, 6)
    rate     = round(rng.uniform(3.8, 5.0), 1)

    is_vegan        = not _has(ing_text, _MEAT) and not _has(ing_text, _DAIRY)
    is_vegetarian   = not _has(ing_text, _MEAT)
    is_lactose_free = not _has(ing_text, _DAIRY)
    is_gluten_free  = not _has(ing_text, _GLUTEN)

    origin      = f"di {mdb_area}" if mdb_area else f"di cucina {mdb_cat.lower()}"
    subtitle    = f"Ricetta {origin} — autentica e collaudata"
    description = (
        f"Un piatto {origin} dalla tradizione {mdb_cat.lower()}: {name} "
        f"preparato con ingredienti genuini e tecnica consolidata."
    )

    cats_dart   = ", ".join(f"'{c}'" for c in category_ids)
    ing_block   = _dart_str_list(ingredients, indent=6)
    steps_block = _dart_str_list(steps, indent=6)

    def _b(val: bool) -> str:
        return "true" if val else "false"

    return (
        f"  // ── {sfr_id}: {name}\n"
        f"  Meal(\n"
        f"    id: '{sfr_id}',\n"
        f"    categories: [{cats_dart}],\n"
        f"    title: {_dart_str(name, indent=4)},\n"
        f"    subtitle: {_dart_str(subtitle, indent=4)},\n"
        f"    description:\n"
        f"        {_dart_str(description, indent=8)},\n"
        f"    imageUrl:\n"
        f"        '{image_url}',\n"
        f"    duration: {duration},\n"
        f"    servings: {servings},\n"
        f"    complexity: {complexity},\n"
        f"    affordability: {affordability},\n"
        f"    ingredients: [\n"
        f"{ing_block}\n"
        f"    ],\n"
        f"    steps: [\n"
        f"{steps_block}\n"
        f"    ],\n"
        f"    isGlutenFree: {_b(is_gluten_free)},\n"
        f"    isVegan: {_b(is_vegan)},\n"
        f"    isVegetarian: {_b(is_vegetarian)},\n"
        f"    isLactoseFree: {_b(is_lactose_free)},\n"
        f"    rate: {rate},\n"
        f"  ),"
    )


# ---------------------------------------------------------------------------
# File header / footer
# ---------------------------------------------------------------------------

_DART_HEADER = """\
// AUTO-GENERATED — do not edit manually.
// Run:  python scripts/generate_dummy_data.py

// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// ---------------------------------------------------------------------------
// Categories  (12 total)
// ---------------------------------------------------------------------------

const availableCategories = [
  Category(id: 'c1',  title: 'Italian',         icon: '🍕'),
  Category(id: 'c2',  title: 'Quick & Easy',    icon: '⚡'),
  Category(id: 'c3',  title: 'Street Food',     icon: '🍔'),
  Category(id: 'c4',  title: 'German',          icon: '🥨'),
  Category(id: 'c5',  title: 'Light & Healthy', icon: '🥗'),
  Category(id: 'c6',  title: 'Exotic',          icon: '🌴'),
  Category(id: 'c7',  title: 'Breakfast',       icon: '🥞'),
  Category(id: 'c8',  title: 'Asian',           icon: '🍜'),
  Category(id: 'c9',  title: 'French',          icon: '🥐'),
  Category(id: 'c10', title: 'Summer',          icon: '☀️'),
  Category(id: 'c11', title: 'Desserts',        icon: '🎂'),
  Category(id: 'c12', title: 'Mediterranean',   icon: '🫒'),
];

// ---------------------------------------------------------------------------
// Meals  (auto-generated from TheMealDB — www.themealdb.com)
// ---------------------------------------------------------------------------

const availableMeals = [
"""

_DART_FOOTER = "\n];\n"


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------


def _parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Generate dummy_data.dart from TheMealDB")
    p.add_argument(
        "--meals-per-category",
        type=int,
        default=6,
        metavar="N",
        help="Target number of meals per sfrigola category (default: 6)",
    )
    p.add_argument(
        "--clear-cache",
        action="store_true",
        help="Delete the cache directory before fetching",
    )
    return p.parse_args()


def main() -> None:
    args = _parse_args()

    if args.clear_cache and CACHE_DIR.exists():
        shutil.rmtree(CACHE_DIR)
        print("Cache cleared.")

    print("Fetching TheMealDB category list…")
    available_mdb_cats = set(get_mealdb_categories())
    needed = {
        cat: ids
        for cat, ids in CATEGORY_MAP.items()
        if cat in available_mdb_cats
    }
    print(f"Found {len(needed)} matching TheMealDB categories.\n")

    # quota[sfr_id] = meals collected so far for that sfrigola category
    quota: dict[str, int]        = {}
    # Avoid pulling the same TheMealDB meal twice
    seen_mdb_ids: set[str]       = set()
    collected: list[tuple[str, dict, list[str]]] = []  # (sfr_id, detail, cat_ids)
    sfr_counter = 1

    for mdb_cat, sfr_ids in needed.items():
        primary = sfr_ids[0]
        if quota.get(primary, 0) >= args.meals_per_category:
            continue

        print(f"  [{mdb_cat}] → {sfr_ids}")
        slim_list = list_meals_in_category(mdb_cat)

        for slim in slim_list:
            if quota.get(primary, 0) >= args.meals_per_category:
                break

            mdb_id = slim["idMeal"]
            if mdb_id in seen_mdb_ids:
                continue

            detail = get_meal_detail(mdb_id)
            if not detail:
                continue

            # Refine category IDs using the meal's strArea when available
            area = (detail.get("strArea") or "").strip()
            effective_ids = AREA_CATEGORY_OVERRIDE.get(area, sfr_ids)

            seen_mdb_ids.add(mdb_id)
            sfr_id = f"m{sfr_counter}"
            sfr_counter += 1
            collected.append((sfr_id, detail, effective_ids))
            quota[primary] = quota.get(primary, 0) + 1

    print(f"\nGenerating Dart for {len(collected)} meals…")

    blocks = [meal_to_dart(sfr_id, detail, cat_ids) for sfr_id, detail, cat_ids in collected]
    output = _DART_HEADER + "\n\n".join(blocks) + _DART_FOOTER

    OUTPUT_FILE.write_text(output, encoding="utf-8")

    print(f"\nDone!  {len(collected)} meals written to:\n  {OUTPUT_FILE}")
    print("\nNext step:  run `flutter analyze` to verify the generated Dart file.")


if __name__ == "__main__":
    main()
