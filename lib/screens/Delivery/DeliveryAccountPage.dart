import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tezal/screens/Customer/ProfilePage.dart';
import 'package:tezal/services/AuthService.dart';
import 'package:tezal/services/FlatColors.dart';

import '../LoginPage.dart';

class DeliveryAccountPage extends StatefulWidget {
  const DeliveryAccountPage({
    Key key,
  }) : super(key: key);

  @override
  _DeliveryAccountPageState createState() => _DeliveryAccountPageState();
}

class _DeliveryAccountPageState extends State<DeliveryAccountPage> {
  var storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.isLoggedIn(),
        builder: (context, AsyncSnapshot<bool> res) {
          if (res.connectionState == ConnectionState.done) {
            return res.data ? ProfilePage() : LoginPagePage();
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
