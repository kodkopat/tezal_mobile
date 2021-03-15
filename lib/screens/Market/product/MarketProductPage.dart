import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tezal/lang/Lang.dart';
import 'package:tezal/screens/Market/product/MarketDetailPage.dart';
import 'package:tezal/screens/Market/widgets/AppBarNew.dart';
import 'package:tezal/services/FlatColors.dart';

class MarketProductPage extends StatefulWidget {
  final String marketId;

  const MarketProductPage(this.marketId);

  @override
  _MarketProductPageState createState() => _MarketProductPageState(marketId);
}

class _MarketProductPageState extends State<MarketProductPage> {
  var storage = new FlutterSecureStorage();
  String marketId;

  _MarketProductPageState(this.marketId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNew(
        title: Lang(context).products,
      ),
      backgroundColor: FlatColors.white_light,
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          marketProducts(context),
          marketAddProducts(context),
          aboutUs(context),
          exit(context),
        ],
      ),
    );
  }

  Widget marketProducts(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MarketDetailPage(id: marketId)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.border_all_rounded,
                color: FlatColors.green_light,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                Lang(context).marketProducts,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget marketAddProducts(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => PrivateInfoPage()),
        //   );
        // },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.open_in_new_rounded,
                color: FlatColors.green_light,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                Lang(context).marketAddProducts,
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
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => PrivateInfoPage()),
        //   );
        // },
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
