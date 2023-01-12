import 'package:nasa_app/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_app/app/modules/home/domain/repositories/get_pictures_of_the_day_repository.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/infra/datasources/get_pictures_of_the%20day_datasource.dart';

class GetPicturesOfTheDayRepositoryImpl
    implements GetPicturesOfTheDayRepository {
  final GetPicturesOfTheDayDatasource datasource;

  GetPicturesOfTheDayRepositoryImpl(this.datasource);
  @override
  Future<Either<GetPicturesOfTheDayException, List<NasaApod>>>
      getPicturesOfTheDay(ParamsGetPicturesOfTheDay params) async {
    /*
        Handling Exceptions 
         */
    //try {
      return Right(await datasource.getPicturesOfTheDay(params));
    // } on GetPicturesOfTheDayException catch (e) {
    //   return Left(e);
    // } catch (e) {
    //   return Left(GetPicturesOfTheDayException(e.toString()));
    // }
  }
}
