import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/app/constants/config_constants.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_event.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_state.dart';

class GetPicturesOfTheDayBloc
    extends Bloc<GetPicturesOfTheDayEvent, GetPicturesOfTheDayState> {
  final GetPicturesOfTheDayUsecase getPicturesOfTheDayUsecase;
  List<NasaApod> list = [];
  GetPicturesOfTheDayBloc(this.getPicturesOfTheDayUsecase)
      : super(GetPicturesOfTheDayInitialState()) {
    on<LoadPicturesEvent>(loadPicturesEvent);
    on<FilterPicturesByTitleEvent>(filterPicturesByTitleEvent);
  }

  loadPicturesEvent(
      LoadPicturesEvent event, Emitter<GetPicturesOfTheDayState> emit) async {
    emit(GetPicturesOfTheDayLoadingState());
    final result = await getPicturesOfTheDayUsecase(event.params);
    result.fold((l) {
      //case something goes wrong emit fail
      //l = instance of GetPicturesOfTheDayException (left)
      emit(GetPicturesOfTheDayFailState(error: l.message));
    }, (r) {
      //emit success
      // r = instance of list of NasaApod (right)
      list = r;
      emit(GetPicturesOfTheDaySuccessState(list: list));
    });
  }

  filterPicturesByTitleEvent(FilterPicturesByTitleEvent event,
      Emitter<GetPicturesOfTheDayState> emit) async {
    emit(GetPicturesOfTheDayLoadingState());
    final result = await getPicturesOfTheDayUsecase(
        ParamsGetPicturesOfTheDay(api_key: ConfigConstants.API_KEY));
    result.fold((l) {
      //case something goes wrong emit fail
      //l = instance of GetPicturesOfTheDayException (left)
      emit(GetPicturesOfTheDayFailState(error: l.message));
    }, (r) {
      //emit success
      // r = instance of list of NasaApod (right)
      list = r;
      //filter the list directly
      list = list
          .where((element) => element.title
              .toLowerCase()
              .trim()
              .contains(event.filter.toLowerCase().trim()))
          .toList();
      emit(GetPicturesOfTheDaySuccessState(list: list));
    });
  }
}
