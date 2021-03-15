import 'package:flutter/material.dart';

class AppBarNew extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppBarNew({Key key, @required this.title}) : super(key: key);
  @override
  _AppBarNewState createState() => _AppBarNewState(title);

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _AppBarNewState extends State<AppBarNew> {
  final String title;

  _AppBarNewState(this.title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
