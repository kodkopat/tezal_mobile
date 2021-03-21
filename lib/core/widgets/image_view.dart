// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';

import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../styles/txt_styles.dart';

class ProductImageView extends StatefulWidget {
  final List<String> images;

  const ProductImageView({@required this.images})
      : assert(images != null && images is List<String>);

  @override
  _ProductImageViewState createState() => _ProductImageViewState();
}

class _ProductImageViewState extends State<ProductImageView> {
  int selectedImage = 0;
  final double boxHeight = 224;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: boxHeight,
          child: PageView.builder(
            pageSnapping: true,
            itemCount: widget.images.length,
            onPageChanged: (value) {
              setState(() {
                selectedImage = value;
              });
            },
            itemBuilder: (context, index) {
              // return CachedNetworkImage(
              //   imageUrl: "",
              //   width: MediaQuery.of(context).size.width,
              //   height: boxHeight,
              //   fit: BoxFit.cover,
              // );

              // return Image.asset(
              //   widget.images[index],
              //   width: MediaQuery.of(context).size.width,
              //   height: boxHeight,
              //   fit: BoxFit.cover,
              // );

              return Parent(
                style: ParentStyle()
                  ..width(MediaQuery.of(context).size.width)
                  ..height(boxHeight)
                  ..background.image(
                    alignment: Alignment.center,
                    path: "assets/images/placeholder.jpg",
                    fit: BoxFit.fill,
                  ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.all(
                  //   Radius.circular(8),
                  // ),
                  child: Image.memory(
                    base64Decode(widget.images[index]),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 8,
          right: 0,
          left: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
                          selectedImage == index
                              ? Colors.black54
                              : Colors.white,
                        ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
