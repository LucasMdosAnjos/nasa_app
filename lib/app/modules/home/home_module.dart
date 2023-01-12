import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/external/dio/dio_get_pictures_of_the_day.dart';
import 'package:nasa_app/app/modules/home/infra/repositories/get_pictures_of_the_day_repository_impl.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_bloc.dart';

import 'presenter/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DioGetPicturesOfTheDay()),
    Bind.lazySingleton((i) => GetPicturesOfTheDayRepositoryImpl(i())),
    Bind.lazySingleton((i) => GetPicturesOfTheDayUsecase(i())),

    //blocs
    Bind.lazySingleton((i) => GetPicturesOfTheDayBloc(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const HomePage()),
  ];
}
