import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tezal/lang/Lang.dart';
import 'package:tezal/models/Customer/NearByMarketsModel.dart';
import 'package:http/http.dart' as http;
import 'package:tezal/screens/Customer/MarketDetailPage.dart';
import 'package:tezal/services/AuthService.dart';
import 'package:tezal/services/DataService.dart';
import 'package:tezal/services/FlatColors.dart';

class NearbyMarketsWidget extends StatefulWidget {
  NearbyMarketsWidget({Key key}) : super(key: key);
  @override
  _NearbyMarketsWidgetState createState() => _NearbyMarketsWidgetState();
}

class _NearbyMarketsWidgetState extends State<NearbyMarketsWidget> {
  List<Widget> items = [];
  GlobalKey<AnimatedListState> _keys = new GlobalKey<AnimatedListState>();
  var storage = new FlutterSecureStorage();
  Future<NearByMarketsModel> getNearByMarkets() async {
    var headers = await AuthService.getDefaultHeaders();
    var adres = DataService.customerBaseaddress + 'Market/GetNearByMarkets';
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);

    if (res.statusCode == 200) {
      return nearByMarketsModelFromJson(res.body);
    }
    return null;
  }

  void add(NearByMarketsModel data) async {
    Future ft = Future(() {});
    data.data.markets.forEach((Market element) {
      ft = ft.then((value) {
        return Future.delayed(Duration(milliseconds: 100), () {
          items.add(marketItem(element));
          _keys.currentState.insertItem(items.length - 1);
        });
      });
    });
  }

  var ass = Tween(begin: Offset(1, 0), end: Offset(0, 0));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getNearByMarkets(),
        builder: (context, AsyncSnapshot<NearByMarketsModel> res) {
          if (res.connectionState == ConnectionState.done) {
            if (res.data != null) {
              _keys = new GlobalKey<AnimatedListState>();
              items = [];
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                add(res.data);
              });

              return AnimatedList(
                key: _keys,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                      child: items[index], position: animation.drive(ass));
                },
              );
            } else {
              return Center(child: Text("data"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget marketItem(Market market) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(
              new MaterialPageRoute(
                  builder: (_) => MarketDetailPage(
                        id: market.id,
                      )),
            )
            .then((val) => setState(() {}));
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      DataService.prefix +
                          DataService.authority +
                          DataService.customerBaseaddress +
                          'market/getphoto?Id=' +
                          market.id,
                      height: 75,
                      width: 75,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(market.name, style: TextStyle(fontSize: 20)),
                        Text(
                          market.address ?? '',
                          style: TextStyle(color: FlatColors.grey_dark),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.store,
                          color: FlatColors.green_light,
                        ),
                        Text(
                          market.distance.toString() +
                              " " +
                              Lang(context).kiloMeter,
                          style: TextStyle(
                              color: FlatColors.green_light, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          color: FlatColors.green_light,
                        ),
                        Text(
                          market.deliveryCost.toString() +
                              " " +
                              Lang(context).moneyUnit,
                          style: TextStyle(
                              color: FlatColors.green_light, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_border_rounded,
                          color: market.score <= 100 && market.score >= 80
                              ? FlatColors.green_light
                              : (market.score < 80 && market.score >= 60
                                  ? FlatColors.orange_light
                                  : FlatColors.red_light),
                        ),
                        Text(
                          market.score.toString() + "/100",
                          style: TextStyle(
                              color: market.score <= 100 && market.score >= 80
                                  ? FlatColors.green_light
                                  : (market.score < 80 && market.score >= 60
                                      ? FlatColors.orange_light
                                      : FlatColors.red_light),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
