// ignore_for_file: avoid_print

import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/domain/errors/errors.dart';

class MapperGetPicturesOfTheDay {
  static List<NasaApod> toListNasaApod(result) {
    if (result is List) {
      //return a list of NasaApod objects
      return result
          .map((e) => NasaApod(
              copyright: e['copyright'] ?? 'No author',
              date: e['date'],
              explanation: e['explanation'],
              hdurl: e['hdurl'] ?? e['url'],
              media_type: e['media_type'],
              service_version: e['service_version'],
              title: e['title'],
              url: e['url'],
              image_path: e['image_path']))
          .toList();
    }
    if (result is Map) {
      //return a list with just a single NasaApod element
      return [
        NasaApod(
            copyright: result['copyright'] ?? 'No author',
            date: result['date'],
            explanation: result['explanation'],
            hdurl: result['hdurl'] ?? result['url'],
            media_type: result['media_type'],
            service_version: result['service_version'],
            title: result['title'],
            url: result['url'],
            image_path: result['image_path'])
      ];
    }
    throw GetPicturesOfTheDayException('Internal Error');
  }
}
