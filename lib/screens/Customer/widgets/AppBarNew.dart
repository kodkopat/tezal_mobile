import 'package:flutter/material.dart';

class AppBarNew extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  const AppBarNew({Key key, this.actions, @required this.title})
      : super(key: key);
  @override
  _AppBarNewState createState() =>
      _AppBarNewState(title: title, actions: actions);

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _AppBarNewState extends State<AppBarNew> {
  final String title;
  final List<Widget> actions;
  _AppBarNewState({this.title, this.actions});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
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
