import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/app/modules/home/domain/entities/nasa_apod.dart';

import '../../../utils/utils.dart';

class DetailPicturePage extends StatefulWidget {
  final NasaApod nasaApod;

  const DetailPicturePage(this.nasaApod);
  @override
  DetailPicturePageState createState() => DetailPicturePageState();
}

class DetailPicturePageState extends State<DetailPicturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nasaApod.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 8,
            ),
            Text(
              Utils.formattedDate(
                  Utils.dateTimeFromString(widget.nasaApod.date)),
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Hero(
                    tag: widget.nasaApod,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                          image: widget.nasaApod.image_path != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(
                                      File(widget.nasaApod.image_path!)
                                          .readAsBytesSync()))
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.nasaApod.url))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Text(
                widget.nasaApod.explanation,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
