import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_locale.dart';

enum SortOrder {
  alphabeticalAscending,
  alphabeticalDescending,
  rateAscending,
  rateDescending,
  complexityAscending,
  complexityDescending,
  affordabilityAscending,
  affordabilityDescending,
}

extension SortOrderExtension on SortOrder {
  String label(BuildContext context) => switch (this) {
    SortOrder.alphabeticalAscending => AppLocale.getLabels(
      context,
    ).sortOrderAlphabeticalAscending,
    SortOrder.alphabeticalDescending => AppLocale.getLabels(
      context,
    ).sortOrderAlphabeticalDescending,
    SortOrder.rateAscending => AppLocale.getLabels(
      context,
    ).sortOrderRateAscending,
    SortOrder.rateDescending => AppLocale.getLabels(
      context,
    ).sortOrderRateDescending,
    SortOrder.complexityAscending => AppLocale.getLabels(
      context,
    ).sortOrderComplexityAscending,
    SortOrder.complexityDescending => AppLocale.getLabels(
      context,
    ).sortOrderComplexityDescending,
    SortOrder.affordabilityAscending => AppLocale.getLabels(
      context,
    ).sortOrderAffordabilityAscending,
    SortOrder.affordabilityDescending => AppLocale.getLabels(
      context,
    ).sortOrderAffordabilityDescending,
  };
}
