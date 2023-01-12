import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nasa_app/app/constants/http_constants.dart';
import 'package:nasa_app/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/external/mapper/mapper.dart';
import 'package:nasa_app/app/modules/home/infra/datasources/get_pictures_of_the%20day_datasource.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioGetPicturesOfTheDay implements GetPicturesOfTheDayDatasource {
  final Dio dio = Dio();
  @override
  Future<List<NasaApod>> getPicturesOfTheDay(
      ParamsGetPicturesOfTheDay params) async {
    try {
      final response = await dio
          .get('https://api.nasa.gov/planetary/apod?${params.toUrlParams()}');
      if (response.statusCode == HttpConstants.REQUEST_SUCCESS) {
        final data = MapperGetPicturesOfTheDay.toListNasaApod(response.data);
        saveInCache(response.data);
        return data;
      } else {
        throw GetPicturesOfTheDayException('API Error ${response.statusCode}');
      }
    } catch (e) {
      //retrieve from cache
      return getListFromCache();
      //throw GetPicturesOfTheDayException('Internal Error');
    }
  }

  saveInCache(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    var dir = await getApplicationDocumentsDirectory();

    if (data is List) {
      for (int i = 0; i < data.length; i++) {
        var imageDownloadPath = '${dir.path}/${data[i]['date']}.jpg';
        await dio.download(data[i]['url'], imageDownloadPath);
        data[i]['image_path'] = imageDownloadPath;
        print(data[i]['image_path']);
      }
      prefs.setString('pictures_data', jsonEncode(data));
    }
    if (data is Map) {
      var imageDownloadPath = '${dir.path}/${data['date']}.jpg';
      await dio.download(data['url'], imageDownloadPath);
      data['image_path'] = imageDownloadPath;
      print(data['image_path']);
      prefs.setString('pictures_data', jsonEncode(data));
    }
  }

  Future<List<NasaApod>> getListFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('pictures_data')) {
      return MapperGetPicturesOfTheDay.toListNasaApod(
          jsonDecode(prefs.getString('pictures_data')!));
    }
    return [];
  }
}
