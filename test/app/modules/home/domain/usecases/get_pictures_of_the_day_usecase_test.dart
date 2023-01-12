import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/domain/errors/errors.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/infra/repositories/get_pictures_of_the_day_repository.dart';

class MockGetPicturesOfTheDayRepositoryImpl extends Mock
    implements GetPicturesOfTheDayRepository {}

void main() {
  const api_key = 'ALhQW2dErZ4vb77uGQDxmUflmKKrtVPuFoo6kCiZ';
  final repository = MockGetPicturesOfTheDayRepositoryImpl();
  final usecase = GetPicturesOfTheDayUsecase(repository);
  test('get pictures of the day usecase (success) with mock', () async {
    final params = ParamsGetPicturesOfTheDay(api_key: api_key);
    when(() => repository.getPicturesOfTheDay(params))
        .thenAnswer((_) async => Right(<NasaApod>[
              NasaApod(
                  copyright: "Stefano Pellegrini",
                  date: "2023-01-11",
                  explanation:
                      "The scene may look like a fantasy, but it's really Iceland. The rock arch is named Gatklettur and located on the island's northwest coast. Some of the larger rocks in the foreground span a meter across. The fog over the rocks is really moving waves averaged over long exposures.  The featured image is a composite of several foreground and background shots taken with the same camera and from the same location on the same night last November.  The location was picked for its picturesque foreground, but the timing was planned for its colorful background: aurora. The spiral aurora, far behind the arch, was one of the brightest seen in the astrophotographer's life.  The coiled pattern was fleeting, though, as auroral patterns waved and danced for hours during the cold night.  Far in the background were the unchanging stars, with Earth's rotation causing them to appear to slowly circle the sky's northernmost point near Polaris.    Your Sky Surprise: What picture did APOD feature on your birthday? (post 1995)",
                  hdurl:
                      "https://apod.nasa.gov/apod/image/2301/RockyArchAurora_Pellegrini_1330.jpg",
                  media_type: "image",
                  service_version: "v1",
                  title: "Spiral Aurora over Iceland",
                  url:
                      "https://apod.nasa.gov/apod/image/2301/RockyArchAurora_Pellegrini_960.jpg")
            ]));
    final result = await usecase(params);
    expect(result.isRight(), true);
    expect(result.fold(id, id), isA<List<NasaApod>>());
  });

  test('get pictures of the day usecase (error) with mock', () async {
    final params = ParamsGetPicturesOfTheDay(api_key: api_key);
    when(() => repository.getPicturesOfTheDay(params))
        .thenAnswer((_) async => Left(GetPicturesOfTheDayException('API_KEY_INVALID')));
    final result = await usecase(params);
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<GetPicturesOfTheDayException>());
  });
}
