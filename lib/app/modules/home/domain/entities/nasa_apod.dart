// ignore_for_file: non_constant_identifier_names

class NasaApod {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String media_type;
  final String service_version;
  final String title;
  final String url;
  NasaApod({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.media_type,
    required this.service_version,
    required this.title,
    required this.url,
  });

  @override
  String toString() {
    return 'NasaApod(copyright: $copyright, date: $date, explanation: $explanation, hdurl: $hdurl, media_type: $media_type, service_version: $service_version, title: $title, url: $url)';
  }
}
