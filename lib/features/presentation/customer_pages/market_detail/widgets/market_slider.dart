// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/map_box.dart';

class MarketSlider extends StatefulWidget {
  MarketSlider({
    required this.images,
    this.marketLatitude,
    this.marketLongitude,
  });

  final List<String> images;
  final String? marketLatitude;
  final String? marketLongitude;

  @override
  _MarketSliderState createState() => _MarketSliderState();
}

class _MarketSliderState extends State<MarketSlider> {
  int selectedImage = 0;
  double boxHeight = 188;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Parent(
          style: ParentStyle()
            ..background.color(Colors.white)
            ..borderRadius(all: 8)
            ..boxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 4.0),
              blur: 8,
              spread: 0,
            ),
          child: SizedBox(
            height: boxHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              child: PageView.builder(
                pageSnapping: true,
                itemCount: widget.images.length + 1,
                onPageChanged: (value) {
                  setState(() {
                    selectedImage = value;
                  });
                },
                itemBuilder: (context, index) {
                  if (index == widget.images.length) {
                    return MapBox(
                      height: boxHeight,
                      latitude: widget.marketLatitude,
                      longitude: widget.marketLongitude,
                    );
                  } else {
                    return Image.memory(
                      base64Decode(widget.images[index]),
                      fit: BoxFit.fill,
                    );
                  }
                },
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 8,
          child: Container(
            height: 16,
            alignment: Alignment.center,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.images.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Txt(
                  "\u2B24",
                  style: AppTxtStyles().footNote
                    ..clone()
                    ..padding(horizontal: 2)
                    ..textColor(
                      selectedImage == index ? Colors.yellow : Colors.grey,
                    ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
