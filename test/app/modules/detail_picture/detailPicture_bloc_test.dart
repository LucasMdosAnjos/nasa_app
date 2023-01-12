import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:nasa_app/app/modules/detail_picture/detailPicture_bloc.dart';
 
void main() {

  blocTest<DetailPictureBloc, int>('emits [1] when increment is added',
    build: () => DetailPictureBloc(),
    act: (bloc) => bloc.add(DetailPictureEvent.increment),
    expect: () => [1],
  );
}