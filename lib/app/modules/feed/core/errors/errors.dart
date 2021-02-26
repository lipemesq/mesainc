abstract class FeedError implements Exception {}

class ErrorOnToggleFavorite extends FeedError {}

class ErrorLoadingFavorites extends FeedError {}

class ErrorLoadingHighlights extends FeedError {}

class ErrorLoadingNews extends FeedError {}
