import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../lang/Lang.dart';
import '../../services/FlatColors.dart';
import 'AboutUsPage.dart';
import 'Addresses.dart';
import 'PreviousOrdersPage.dart';
import 'PrivateInfoPage.dart';
import 'widgets/AppBarNew.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNew(
        title: Lang(context).profile,
      ),
      backgroundColor: FlatColors.white_light,
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          privateinfo(context),
          address(context),
          previousOrders(context),
          aboutUs(context),
          exit(context),
        ],
      ),
    );
  }

  Widget privateinfo(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PrivateInfoPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: FlatColors.green_light,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                Lang(context).privateInfo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget address(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addresses()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: FlatColors.green_light,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                Lang(context).address,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget previousOrders(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PreviousOrdersPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: FlatColors.green_light,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                Lang(context).previousOrders,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget aboutUs(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutUsPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: FlatColors.green_light,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                Lang(context).aboutUs,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget exit(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: () async {
          await storage.write(key: 'token', value: '');
          storage.delete(key: 'toke').then((value) {
            storage.delete(key: 'userinfo').then((value) {
              Navigator.of(context).pop();
            });
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.exit_to_app,
                color: FlatColors.orange_light,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                Lang(context).exit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
