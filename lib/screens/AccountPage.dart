import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/AuthService.dart';
import '../services/FlatColors.dart';
import 'Customer/ProfilePage.dart';
import 'LoginPage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    Key key,
  }) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            AuthService.isLoggedIn() != null ? AuthService.isLoggedIn() : null,
        builder: (context, AsyncSnapshot<bool> res) {
          if (res.connectionState == ConnectionState.done) {
            return res.data == true ? ProfilePage() : LoginPagePage();
            //return res.data == true ? MarketMainPage() : LoginPagePage();
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
