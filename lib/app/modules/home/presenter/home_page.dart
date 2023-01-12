// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app/app/constants/config_constants.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/modules/home/domain/usecases/get_pictures_of_the_day_usecase.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_bloc.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_event.dart';
import 'package:nasa_app/app/modules/home/presenter/blocs/get_pictures_of_the_day_bloc/get_pictures_of_the_day_state.dart';
import 'package:nasa_app/app/modules/home/presenter/widgets/item_nasa_apod.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetPicturesOfTheDayBloc getPicturesOfTheDayBloc = Modular.get();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    reloadPictures();
  }

  reloadPictures() {
    textEditingController.clear();
    getPicturesOfTheDayBloc.add(LoadPicturesEvent(
        params: ParamsGetPicturesOfTheDay(api_key: ConfigConstants.API_KEY)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nasa Images"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: reloadPictures,
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: textEditingController,
                onSubmitted: (value) {
                  getPicturesOfTheDayBloc
                      .add(FilterPicturesByTitleEvent(filter: value));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<GetPicturesOfTheDayBloc,
                  GetPicturesOfTheDayState>(
                builder: (_, state) {
                  if (state is GetPicturesOfTheDayInitialState) {
                    return Container();
                  }
                  if (state is GetPicturesOfTheDayLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is GetPicturesOfTheDayFailState) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  }
                  if (state is GetPicturesOfTheDaySuccessState) {
                    return ListView.builder(
                        itemCount: state.list.length,
                        itemBuilder: ((context, index) {
                          final NasaApod nasaApod = state.list[index];
                          return ItemNasaApod(nasaApod);
                        }));
                  }
                  return Container();
                },
                bloc: getPicturesOfTheDayBloc,
              ),
            )
          ],
        ));
  }
}
