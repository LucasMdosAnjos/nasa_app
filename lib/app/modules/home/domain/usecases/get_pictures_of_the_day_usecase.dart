// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';

import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_app/app/modules/home/domain/repositories/get_pictures_of_the_day_repository.dart';
import 'package:nasa_app/app/utils/utils.dart';

class ParamsGetPicturesOfTheDay {
  final String api_key;
  final String? date;
  ParamsGetPicturesOfTheDay({required this.api_key, this.date});

  String toUrlParams() {
    if (date != null) {
      return "api_key=$api_key&start_date=$date&end_date=$date";
    }
    return "api_key=$api_key&start_date=${Utils.formattedDate(DateTime.now().add(const Duration(days: -9)), format: 'yyyy-MM-dd')}";
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
    if (params.api_key.isEmpty) {
      return Left(GetPicturesOfTheDayException('API_KEY is empty'));
    }
    return await repository.getPicturesOfTheDay(params);
  }
}
