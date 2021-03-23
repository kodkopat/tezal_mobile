import 'dart:convert';

import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../styles/txt_styles.dart';

class ProductImageView extends StatefulWidget {
  const ProductImageView({
    @required this.images,
  });

  final List<String> images;

  @override
  _ProductImageViewState createState() => _ProductImageViewState();
}

class _ProductImageViewState extends State<ProductImageView> {
  int selectedImage = 0;
  final double boxHeight = 224;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    style: ParentStyle()
                      ..width(MediaQuery.of(context).size.width)
                      ..height(boxHeight)
                      ..background.image(
                        alignment: Alignment.center,
                        path: "assets/images/placeholder.jpg",
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
        const SizedBox(height: 8),
        SizedBox(
          height: 16,
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
                    selectedImage == index ? Colors.black54 : Colors.grey[300],
                  ),
              );
            },
          ),
        ),
      ],
    );
  }
}
