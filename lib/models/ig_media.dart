class IgMedia {
  final String id;
  final String caption;
  final int likeCount;
  final bool isCommentEnabled;
  final int commentsCount;
  final String mediaType;
  final String mediaUrl;
  final bool? isSharedToFeed;
  final String? thumbnailUrl;

  IgMedia({
    required this.id,
    required this.caption,
    required this.likeCount,
    required this.isCommentEnabled,
    required this.commentsCount,
    required this.mediaType,
    required this.mediaUrl,
    required this.isSharedToFeed,
    required this.thumbnailUrl,
  });

  factory IgMedia.fromJson(Map<String, dynamic> json) {
    return IgMedia(
      id: json['id'],
      caption: json['caption'],
      likeCount: json['like_count'],
      isCommentEnabled: json['is_comment_enabled'],
      commentsCount: json['comments_count'],
      mediaType: json['media_type'],
      mediaUrl: json['media_url'],
      isSharedToFeed: json['is_shared_to_feed'],
      thumbnailUrl: json['thumbnail_url'],
    );
  }
}
