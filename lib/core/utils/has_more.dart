/// A utility function to determine if there are more items to load based on the total count, skip, and take values.
/// [totalCount] The total number of items available.
/// [skip] The number of items that have already been loaded or skipped.
/// [take] The number of items to load in the current batch.
/// Returns true if there are more items to load, false otherwise.
bool hasMore(int totalCount, int skip, int take) {
  return skip + take < totalCount;
}
