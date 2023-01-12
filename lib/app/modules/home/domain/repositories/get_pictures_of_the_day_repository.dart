import 'package:dartz/dartz.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/domain/errors/errors.dart';

import '../usecases/get_pictures_of_the_day_usecase.dart';

abstract class GetPicturesOfTheDayRepository{
  Future<Either<GetPicturesOfTheDayException,List<NasaApod>>> getPicturesOfTheDay(ParamsGetPicturesOfTheDay params);
}