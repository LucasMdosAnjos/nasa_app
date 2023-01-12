// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';
import 'package:nasa_app/app/utils/utils.dart';

class ItemNasaApod extends StatelessWidget {
  final NasaApod nasaApod;
  ItemNasaApod(this.nasaApod);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          nasaApod.title,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          Utils.formattedDate(Utils.dateTimeFromString(nasaApod.date)),
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Modular.to.pushNamed('/detail_picture/', arguments: nasaApod);
                },
                child: Hero(
                  tag: nasaApod,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                        image: nasaApod.image_path != null
                            ? DecorationImage(
                                image: MemoryImage(File(nasaApod.image_path!)
                                    .readAsBytesSync()))
                            : DecorationImage(
                                image: NetworkImage(nasaApod.url))),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
