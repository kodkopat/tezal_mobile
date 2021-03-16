import 'package:flutter/material.dart';

import '../../../services/FlatColors.dart';

class AppbarBasketIcon extends StatelessWidget {
  final int count;
  final BuildContext context;
  final VoidCallback onTap;
  AppbarBasketIcon({this.context, @required this.count, this.onTap});

  @override
  Widget build(context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            Icons.shopping_basket,
            color: Colors.white,
          ),
          onPressed: () => onTap.call(),
        ),
        if (count > 0)
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: FlatColors.orange_light),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                count.toString(),
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          )
      ],
    );
  }
}
