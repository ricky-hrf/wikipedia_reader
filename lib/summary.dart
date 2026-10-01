class Summary {
  final int pageId;
  final String title;
  final String extract;
  final String? description;
  final String? thumbnailUrl;
  final String? pageUrl;

  const Summary({
    required this.pageId,
    required this.title,
    required this.extract,
    this.description,
    this.thumbnailUrl,
    this.pageUrl,
  });

  factory Summary.fromJson(Map<String, Object?> json) {
    final thumbnail = json['thumbnail'] as Map<String, Object?>?;
    final contentUrls = json['content_urls'] as Map<String, Object?>?;
    final desktop = contentUrls?['desktop'] as Map<String, Object?>?;

    return Summary(
      pageId: (json['pageid'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      extract: json['extract'] as String? ?? '',
      description: json['description'] as String?,
      thumbnailUrl: thumbnail?['source'] as String?,
      pageUrl: desktop?['page'] as String?,
    );
  }
}