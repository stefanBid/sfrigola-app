bool hasMore(int totalCount, int skip, int take) {
  return skip + take < totalCount;
}
