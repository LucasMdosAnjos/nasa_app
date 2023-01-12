// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/app/constants/config_constants.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_event.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_state.dart';

class GetPicturesOfTheDayBloc
    extends Bloc<GetPicturesOfTheDayEvent, GetPicturesOfTheDayState> {
  final GetPicturesOfTheDayUsecase getPicturesOfTheDayUsecase;
  List<NasaApod> full_list = [];
  List<NasaApod> paginated_list = [];
  GetPicturesOfTheDayBloc(this.getPicturesOfTheDayUsecase)
      : super(GetPicturesOfTheDayInitialState()) {
    on<LoadPicturesEvent>(loadPicturesEvent);
    on<FilterPicturesByTitleEvent>(filterPicturesByTitleEvent);
    on<FilterPicturesByDateEvent>(filterPicturesByDateEvent);
    on<AddMorePaginatedItensEvent>(addMorePaginatedItensEvent);
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
      full_list = r;
      makePagination();
      emit(GetPicturesOfTheDaySuccessState(list: paginated_list));
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
      full_list = r;
      //filter the list directly
      full_list = full_list
          .where((element) => element.title
              .toLowerCase()
              .trim()
              .contains(event.filter.toLowerCase().trim()))
          .toList();
      makePagination();
      emit(GetPicturesOfTheDaySuccessState(list: paginated_list));
    });
  }

  filterPicturesByDateEvent(FilterPicturesByDateEvent event,
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
      full_list = r;
      makePagination();
      emit(GetPicturesOfTheDaySuccessState(list: paginated_list));
    });
  }

  //Start pagination with 10 itens by default
  makePagination() {
    if (full_list.length <= 10) {
      paginated_list = full_list;
    } else {
      paginated_list = full_list.sublist(0, 10);
    }
  }

  //Event to add more 10 itens if possible to paginated list
  addMorePaginatedItensEvent(AddMorePaginatedItensEvent event,
      Emitter<GetPicturesOfTheDayState> emit) {
    //Logic to add itens to paginated list
    if (paginated_list.length < full_list.length) {
      int start_index = paginated_list.length;
      if ((full_list.length) <= (start_index + 10)) {
        paginated_list.addAll(full_list.sublist(start_index, full_list.length));
      } else {
        paginated_list.addAll(full_list.sublist(start_index, start_index + 10));
      }
      //emit success
      emit(GetPicturesOfTheDaySuccessState(list: paginated_list));
    }
  }
}
