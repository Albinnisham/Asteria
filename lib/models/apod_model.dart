class ApodModel {
  const ApodModel({
    this.date,
    this.explanation,
    this.hdUrl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
  });

  final String? date;
  final String? explanation;
  final String? hdUrl;
  final String? mediaType;
  final String? serviceVersion;
  final String? title;
  final String? url;

  bool get isImage => mediaType?.toLowerCase() == 'image';

  bool get isVideo => mediaType?.toLowerCase() == 'video';

  bool get hasImageUrl {
    return isImage && url != null && url!.isNotEmpty;
  }

  bool get hasHdImage {
    return isImage && hdUrl != null && hdUrl!.isNotEmpty;
  }

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    String? readString(String key) {
      final value = json[key];

      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }

      return null;
    }

    return ApodModel(
      date: readString('date'),
      explanation: readString('explanation'),
      hdUrl: readString('hdurl'),
      mediaType: readString('media_type'),
      serviceVersion: readString('service_version'),
      title: readString('title'),
      url: readString('url'),
    );
  }
}
