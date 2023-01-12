import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_event.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_state.dart';

class GetPicturesOfTheDayBloc
    extends Bloc<GetPicturesOfTheDayEvent, GetPicturesOfTheDayState> {
  final GetPicturesOfTheDayUsecase getPicturesOfTheDayUsecase;

  GetPicturesOfTheDayBloc(this.getPicturesOfTheDayUsecase)
      : super(GetPicturesOfTheDayInitialState()) {
    on<LoadPicturesEvent>((event, emit) async {
      emit(GetPicturesOfTheDayLoadingState());
      final result = await getPicturesOfTheDayUsecase(event.params);
      result.fold((l) {
        //case something goes wrong emit fail
        //l = instance of GetPicturesOfTheDayException (left)
        emit(GetPicturesOfTheDayFailState(error: l.message));
      }, (r) {
        //emit success
        // r = instance of list of NasaApod (right)
        emit(GetPicturesOfTheDaySuccessState(list: r));
      });
    });
  }
}
