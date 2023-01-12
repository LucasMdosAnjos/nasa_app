// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';

class NasaApod {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String media_type;
  final String service_version;
  final String title;
  final String url;
  final String? image_path;
  NasaApod(
      {required this.copyright,
      required this.date,
      required this.explanation,
      required this.hdurl,
      required this.media_type,
      required this.service_version,
      required this.title,
      required this.url,
      this.image_path});
}
