import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';

abstract class GetPicturesOfTheDayEvent {}

class LoadPicturesEvent extends GetPicturesOfTheDayEvent {
  ParamsGetPicturesOfTheDay params;
  LoadPicturesEvent({required this.params});
}
