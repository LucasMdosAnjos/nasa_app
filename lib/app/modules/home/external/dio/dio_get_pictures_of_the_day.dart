import 'package:dio/dio.dart';
import 'package:nasa_app/app/constants/http_constants.dart';
import 'package:nasa_app/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_app/app/modules/home/domain/repositories/get_pictures_of_the_day_repository.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/external/mapper/mapper.dart';
import 'package:nasa_app/app/modules/home/infra/datasources/get_pictures_of_the%20day_datasource.dart';

class DioGetPicturesOfTheDay implements GetPicturesOfTheDayDatasource {
  final Dio dio = Dio();
  @override
  Future<List<NasaApod>> getPicturesOfTheDay(ParamsGetPicturesOfTheDay params) async{
    try{
      final response = await dio.get('https://api.nasa.gov/planetary/apod?${params.toUrlParams()}');
      if(response.statusCode == HttpConstants.REQUEST_SUCCESS){
      return MapperGetPicturesOfTheDay.toListNasaApod(response.data);
      }else{
        throw GetPicturesOfTheDayException('API Error ${response.statusCode}');
      }
    }catch(e){
       throw GetPicturesOfTheDayException('Internal Error');
    }
  }
}
