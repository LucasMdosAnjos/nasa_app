// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';

import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_app/app/modules/home/domain/repositories/get_pictures_of_the_day_repository.dart';

class ParamsGetPicturesOfTheDay {
  final String api_key;
  ParamsGetPicturesOfTheDay({
    required this.api_key
  });

  String toUrlParams() {
    return "api_key=$api_key&count=10";
  }
}

abstract class IGetPicturesOfTheDayUsecase {
  Future<Either<GetPicturesOfTheDayException, List<NasaApod>>> call(
      ParamsGetPicturesOfTheDay params);
}

class GetPicturesOfTheDayUsecase implements IGetPicturesOfTheDayUsecase {
  final GetPicturesOfTheDayRepository repository;

  GetPicturesOfTheDayUsecase(this.repository);
  @override
  Future<Either<GetPicturesOfTheDayException, List<NasaApod>>> call(
      ParamsGetPicturesOfTheDay params) async {
    /*
            Data Validation Before returning repository result
        */
    if(params.api_key.isEmpty){
      return Left(GetPicturesOfTheDayException('API_KEY is empty'));
    }
    return await repository.getPicturesOfTheDay(params);
  }
}
