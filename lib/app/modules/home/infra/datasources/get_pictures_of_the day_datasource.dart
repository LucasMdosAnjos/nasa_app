import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';

abstract class GetPicturesOfTheDayDatasource{
  Future<List<NasaApod>> getPicturesOfTheDay(ParamsGetPicturesOfTheDay params);
}