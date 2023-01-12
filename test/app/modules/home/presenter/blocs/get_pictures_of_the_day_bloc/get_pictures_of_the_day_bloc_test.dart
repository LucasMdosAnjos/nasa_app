import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_app/app/constants/config_constants.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/external/dio/dio_get_pictures_of_the_day.dart';
import 'package:nasa_app/app/modules/home/infra/repositories/get_pictures_of_the_day_repository_impl.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_bloc.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_event.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_state.dart';

void main() {
  final datasource = DioGetPicturesOfTheDay();
  final repository = GetPicturesOfTheDayRepositoryImpl(datasource);
  final usecase = GetPicturesOfTheDayUsecase(repository);
  group('GetPicturesOfTheDayBloc', () {
    blocTest('emits a list of NasaApod when called with the right params',
        build: () => GetPicturesOfTheDayBloc(usecase),
        act: (bloc) => bloc.add(LoadPicturesEvent(
            params:
                ParamsGetPicturesOfTheDay(api_key: ConfigConstants.API_KEY))),
        wait: const Duration(milliseconds: 2000),
        expect: () => [
              isA<GetPicturesOfTheDayLoadingState>(),
              isA<GetPicturesOfTheDaySuccessState>(),
            ]);

    blocTest(
        'emits a instance of GetPicturesOfTheDayException when called with wrong params',
        build: () => GetPicturesOfTheDayBloc(usecase),
        act: (bloc) => bloc.add(
            LoadPicturesEvent(params: ParamsGetPicturesOfTheDay(api_key: ''))),
        wait: const Duration(milliseconds: 2000),
        expect: () => [
              isA<GetPicturesOfTheDayLoadingState>(),
              isA<GetPicturesOfTheDayFailState>(),
            ]);
  });
}
