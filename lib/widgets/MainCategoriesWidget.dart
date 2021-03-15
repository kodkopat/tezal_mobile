import 'package:flutter/material.dart';
import 'package:tezal/screens/Customer/CategoryDetailPage.dart';

import 'package:tezal/services/FlatColors.dart';
import 'package:tezal/services/RouteBuilderService.dart';

class MainCategoriesWidget extends StatefulWidget {
  MainCategoriesWidget({Key key}) : super(key: key);
  @override
  _MainCategoriesWidgetState createState() => _MainCategoriesWidgetState();
}

class _MainCategoriesWidgetState extends State<MainCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(5),
        crossAxisCount: 4,
        children: [
          item('assets/dairy.jpg', 'لبنیات', ''),
          item('assets/fruit.jpg', 'میوه‌جات', '')
        ]);
  }

  Padding item(String image, String lable, String tag) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                )),
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: FlatColors.grey_dark,
                    blurRadius: 2,
                  )
                ]),
          ),
          Align(
            child: Text(
              lable,
              style: TextStyle(backgroundColor: Colors.white),
            ),
            alignment: Alignment.bottomCenter,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
