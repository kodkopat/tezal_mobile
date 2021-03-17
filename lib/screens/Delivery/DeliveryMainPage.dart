import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../lang/lang.dart';
import '../../main.dart';
import '../../services/LocationService.dart';
import '../../services/RouteBuilderService.dart';
import '../AccountPage.dart';
import 'DeliveryHomePage.dart';

class DeliveryMainPage extends StatefulWidget {
  DeliveryMainPage({Key key}) : super(key: key);

  @override
  _DeliveryMainPageState createState() => _DeliveryMainPageState();
}

class _DeliveryMainPageState extends State<DeliveryMainPage> {
  var pages;
  int pageindex = 0;

  @override
  void initState() {
    pages = [DeliveryHomePage(), AccountPage()];

    LocationService.determinePosition().then((p) {
      var prefs = SharedPreferences.getInstance();
      prefs.then((value) {
        value.setString('longitude', p.longitude.toString());
        value.setString('latitude', p.latitude.toString());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homepageAppBar(),
      body: IndexedStack(
        index: pageindex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining), label: Lang(context).jobs),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: Lang(context).account),
        ],
        currentIndex: pageindex,
        onTap: (index) {
          setState(() {
            if (index != 1) pageindex = index;
            if (index == 1) {
              Navigator.push(context, RouteBuilderService.goto(AccountPage()));
            }
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  AppBar homepageAppBar() {
    return AppBar(
      elevation: 10,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Lang(context).programName,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Row(
            children: [
              Text(
                Lang(context).programName,
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              App.restart(context);
            })
      ],
    );
  }
}
