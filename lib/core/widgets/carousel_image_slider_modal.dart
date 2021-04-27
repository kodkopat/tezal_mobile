import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tezal/core/page_routes/base_routes.dart';

import '../styles/txt_styles.dart';

class ModalCarouselImageSlider extends StatefulWidget {
  const ModalCarouselImageSlider({
    required this.imagePathList,
    required this.selectedIndex,
  });

  final List<String> imagePathList;
  final int selectedIndex;

  @override
  _ModalCarouselImageSliderState createState() =>
      _ModalCarouselImageSliderState();
}

class _ModalCarouselImageSliderState extends State<ModalCarouselImageSlider> {
  late int selectedIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
    pageController = PageController(
      keepPage: true,
      initialPage: selectedIndex,
      viewportFraction: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.imagePathList.length,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.memory(
                base64Decode(widget.imagePathList[index]),
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: _buildCarouselSliderIndicators(),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: _buildCloseBtn(),
        ),
      ],
    );
  }

  Widget _buildCarouselSliderIndicators() {
    return Container(
      height: 16,
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.imagePathList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Txt(
            "\u2B24",
            style: AppTxtStyles().footNote
              ..clone()
              ..padding(horizontal: 2)
              ..textColor(
                selectedIndex == index
                    ? Colors.white
                    : Colors.grey.withOpacity(0.75),
              ),
          );
        },
      ),
    );
  }

  Widget _buildCloseBtn() {
    return Parent(
      gesture: Gestures()..onTap(() => Routes.sailor.pop()),
      style: ParentStyle()
        ..width(48)
        ..height(48)
        ..borderRadius(all: 24)
        ..ripple(true),
      child: Icon(
        Feather.x,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
