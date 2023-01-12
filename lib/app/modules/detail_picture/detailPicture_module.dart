import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app/app/modules/detail_picture/presenter/detailPicture_page.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';

class DetailPictureModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => DetailPicturePage(args.data as NasaApod)),
  ];
}
