import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/AuthService.dart';
import '../../services/FlatColors.dart';
import '../LoginPage.dart';
import 'MarketMainPage.dart';

class MarketAccountPage extends StatefulWidget {
  const MarketAccountPage({
    Key key,
  }) : super(key: key);

  @override
  _MarketAccountPageState createState() => _MarketAccountPageState();
}

class _MarketAccountPageState extends State<MarketAccountPage> {
  var storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.isLoggedIn(),
        builder: (context, AsyncSnapshot<bool> res) {
          if (res.connectionState == ConnectionState.done) {
            return res.data ? MarketMainPage() : LoginPagePage();
          } else {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: FlatColors.white_light,
                  elevation: 0,
                ),
                backgroundColor: FlatColors.white_light,
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
