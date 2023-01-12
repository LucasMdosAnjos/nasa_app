import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app/app/modules/detail_picture/detailPicture_module.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/detail_picture', module: DetailPictureModule())
  ];
}
