import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../lang/Lang.dart';
import '../../models/Market/OrderModel.dart';
import '../../services/AuthService.dart';
import '../../services/DataService.dart';
import '../../services/RouteBuilderService.dart';
import '../AccountPage.dart';
import 'MarketMainPage.dart';

class MarketOrderPage extends StatefulWidget {
  const MarketOrderPage({Key key}) : super(key: key);
  @override
  _MarketOrderPageState createState() => _MarketOrderPageState();
}

class _MarketOrderPageState extends State<MarketOrderPage> {
  List<Widget> items = [];
  var pages;
  int pageindex = 0;

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<AnimatedListState> _keys = new GlobalKey<AnimatedListState>();
  var storage = new FlutterSecureStorage();
  Future<OrderModel> getMarketOrder() async {
    var headers = await AuthService.getDefaultHeaders();
    var adres = DataService.marketBaseaddress + 'Order/GetPostOrderSummary';
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    return res.statusCode == 200 ? orderModelFromJson(res.body) : OrderModel();
  }

  void add(OrderModel data) async {
    Future ft = Future(() {});
    data.data.forEach(
      (Order element) {
        ft = ft.then(
          (value) {
            return Future.delayed(Duration(milliseconds: 100), () {
              items.add(marketOrderItem(element));
              _keys.currentState.insertItem(items.length - 1);
            });
          },
        );
      },
    );
  }

  var ass = Tween(begin: Offset(1, 0), end: Offset(0, 0));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMarketOrder(),
        builder: (context, AsyncSnapshot<OrderModel> res) {
          if (res.connectionState == ConnectionState.done) {
            _keys = new GlobalKey<AnimatedListState>();
            items = [];
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              add(res.data);
            });

            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 40,
                backgroundColor: Colors.blue,
                elevation: 3,
                title: Text("Order Page"),
              ),
              body: ListView(
                children: <Widget>[
                  Container(
                    height: 1000,
                    child: newMethod(),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.grey,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_tree_outlined,
                          color: Colors.green),
                      label: 'mainPage'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.exit_to_app, color: Colors.orange),
                      label: Lang(context).exit),
                ],
                currentIndex: pageindex,
                onTap: (index) {
                  setState(() {
                    if (index == 0)
                      Navigator.push(
                          context, RouteBuilderService.goto(MarketMainPage()));
                    if (index == 1) {
                      Navigator.push(
                          context, RouteBuilderService.goto(AccountPage()));
                    }
                  });
                },
                type: BottomNavigationBarType.fixed,
              ),
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }

  AnimatedList newMethod() {
    return AnimatedList(
      key: _keys,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
            child: items[index], position: animation.drive(ass));
      },
    );
  }

  Widget marketOrderItem(Order marketOrder) {
    return Card(
      elevation: 3,
      color: Colors.indigo[70],
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 25,
                  width: 90,
                  child: Card(
                    child: Text(
                      " " + marketOrder.customerName,
                      style: TextStyle(
                          fontSize: 9,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                marketOrder.orderStatus == 'new_order'
                    ? newOrder()
                    : approveOrder(),
                SizedBox(
                  height: 25,
                  width: 80,
                  child: Card(
                    color: Colors.white,
                    child: Center(
                      child: Text(marketOrder.createTime,
                          style: TextStyle(
                              fontSize: 9,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  width: 45,
                  child: Card(
                    color: Colors.white,
                    child: Center(
                      child: Text(marketOrder.paymentType,
                          style: TextStyle(
                              fontSize: 9,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  width: 50,
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0, right: 2),
                      child: Text(marketOrder.totalPrice.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 9,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Card(
                    color: Colors.white,
                    child: Icon(Icons.details_outlined,
                        color: Colors.green, size: 16.0))
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox newOrder() {
    return SizedBox(
      height: 25,
      width: 55,
      child: Card(
        color: Colors.lightGreen,
        child: Center(
          child: Text(
            " new ",
            style: TextStyle(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  SizedBox approveOrder() {
    return SizedBox(
      height: 25,
      width: 55,
      child: Card(
        color: Colors.blue,
        child: Center(
          child: Text(
            "approved",
            style: TextStyle(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
