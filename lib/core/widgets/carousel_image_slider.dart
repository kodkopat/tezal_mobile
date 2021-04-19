import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../styles/txt_styles.dart';
import 'carousel_image_slider_modal.dart';

class CarouselImageSlider extends StatefulWidget {
  const CarouselImageSlider({required this.images});

  final List<String> images;

  @override
  _CarouselImageSliderState createState() => _CarouselImageSliderState();
}

class _CarouselImageSliderState extends State<CarouselImageSlider> {
  int selectedImage = 0;
  final double boxHeight = 160;

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
                itemCount: widget.images.length,
                onPageChanged: (value) {
                  setState(() {
                    selectedImage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Parent(
                    gesture: Gestures()
                      ..onTap(() {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black,
                          builder: (context) {
                            return ModalCarouselImageSlider(
                              imagePathList: widget.images,
                              selectedIndex: selectedImage,
                            );
                          },
                        );
                      }),
                    style: ParentStyle()
                      ..width(MediaQuery.of(context).size.width)
                      ..height(boxHeight)
                      ..background.image(
                        alignment: Alignment.center,
                        path: "assets/images/img_placeholder.jpg",
                        fit: BoxFit.fill,
                      ),
                    child: Image.memory(
                      base64Decode(widget.images[index]),
                      fit: BoxFit.fill,
                    ),
                  );
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
              itemCount: widget.images.length,
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
