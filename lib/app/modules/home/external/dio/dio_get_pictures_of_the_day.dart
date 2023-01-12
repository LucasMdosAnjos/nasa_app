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

import '../../../../utils/utils.dart';

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
      return getListFromCache(params);
    }
  }

  saveInCache(dynamic data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var cachedList = [];
      if (prefs.containsKey('pictures_data')) {
        //get cached list
        cachedList = jsonDecode(prefs.getString('pictures_data')!);
      }
      if (data is List) {
        for (int i = 0; i < data.length; i++) {
          if (cachedList
              .where((element) =>
                  element['date'].toString() == data[i]['date'].toString())
              .isEmpty) {
            //Case cache does not contain this picture saved
            cachedList.add(await saveSinglePictureInCache(data[i]));
          }
        }
        prefs.setString('pictures_data', jsonEncode(cachedList));
      }
      if (data is Map) {
        if (cachedList
            .where((element) =>
                element['date'].toString() == data['date'].toString())
            .isEmpty) {
          //Case cache does not contain this picture saved
          cachedList.add(await saveSinglePictureInCache(data));
        }
        prefs.setString('pictures_data', jsonEncode(cachedList));
      }
    } catch (e) {}
  }

  Future<Map> saveSinglePictureInCache(Map data) async {
    var dir = await getApplicationDocumentsDirectory();
    var imageDownloadPath = '${dir.path}/${data['date']}.jpg';
    await dio.download(data['url'], imageDownloadPath);
    data['image_path'] = imageDownloadPath;
    return data;
  }

  Future<List<NasaApod>> getListFromCache(
      ParamsGetPicturesOfTheDay params) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('pictures_data')) {
        //Case contains cache
        final data = MapperGetPicturesOfTheDay.toListNasaApod(
            jsonDecode(prefs.getString('pictures_data')!));
        if (params.date != null) {
          //filter by date
          return data
              .where((element) => Utils.dateTimeFromString(element.date)
                  .isAtSameMomentAs(Utils.dateTimeFromString(params.date!)))
              .toList();
        }
        //Sort the cached data by date
        data.sort((a, b) => Utils.dateTimeFromString(a.date)
            .compareTo(Utils.dateTimeFromString(b.date)));
        return data;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
