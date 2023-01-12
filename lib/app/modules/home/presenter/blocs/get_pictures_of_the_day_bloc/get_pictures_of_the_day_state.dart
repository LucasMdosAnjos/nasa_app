import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';

abstract class GetPicturesOfTheDayState{}

class GetPicturesOfTheDayInitialState extends GetPicturesOfTheDayState{
  GetPicturesOfTheDayInitialState();
}

class GetPicturesOfTheDayLoadingState extends GetPicturesOfTheDayState{
GetPicturesOfTheDayLoadingState();
}


class GetPicturesOfTheDaySuccessState extends GetPicturesOfTheDayState{
  List<NasaApod> list;
  GetPicturesOfTheDaySuccessState({required this.list});
}

class GetPicturesOfTheDayFailState extends GetPicturesOfTheDayState{
  String error;
  GetPicturesOfTheDayFailState({required this.error});
}