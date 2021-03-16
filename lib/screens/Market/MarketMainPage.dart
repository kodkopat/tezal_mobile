import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../lang/Lang.dart';
import '../../models/MarkerOrderModel.dart';
import '../../services/AuthService.dart';
import '../../services/DataService.dart';
import '../../services/FlatColors.dart';
import '../../services/RouteBuilderService.dart';
import '../AccountPage.dart';
import 'MarketInfoPage.dart';
import 'MarketOrderDetailPage.dart';
import 'MarketOrderPage.dart';
import 'product/MarketProductPage.dart';

class MarketMainPage extends StatefulWidget {
  const MarketMainPage({Key key}) : super(key: key);
  @override
  _MarketMainPageState createState() => _MarketMainPageState();
}

class _MarketMainPageState extends State<MarketMainPage> {
  List<Widget> items = [];
  var pages;
  int pageindex = 0;
  int walletTotal;
  int orderCount;
  String marketId;

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<AnimatedListState> _keys = new GlobalKey<AnimatedListState>();
  var storage = new FlutterSecureStorage();
  Future<MarketOrderModel> getMarketOrder() async {
    var headers = await AuthService.getDefaultHeaders();

    var adres = DataService.marketBaseaddress + 'Order/GetOrderSummary';
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    return res.statusCode == 200
        ? marketOrderModelFromJson(res.body)
        : MarketOrderModel();
  }

  void add(MarketOrderModel data) async {
    Future ft = Future(() {});
    MarketOrder element = data.data[0];

    for (var i = 0; i < element.orders.length; i++) {
      ft = ft.then(
        (value) {
          return Future.delayed(
            Duration(milliseconds: 100),
            () {
              items.add(marketOrderItem(element.orders[i]));
              _keys.currentState.insertItem(items.length - 1);
            },
          );
        },
      );
      if (walletTotal == null && element.walletTotal > 0)
        setState(() {
          walletTotal = element.walletTotal;
          orderCount = element.orders.length;
          marketId = element.id;
        });
    }
  }

  _MarketMainPageState();
  var ass = Tween(begin: Offset(1, 0), end: Offset(0, 0));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMarketOrder(),
        builder: (context, AsyncSnapshot<MarketOrderModel> res) {
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
                title: Text("Main Page"),
              ),
              body: ListView(
                children: <Widget>[
                  new Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.wallet_travel,
                            size: 14.0, color: Colors.black),
                        Text(
                          walletTotal.toString() + '﷼',
                          style: new TextStyle(
                              decorationThickness: 3,
                              fontSize: 12.0,
                              color: Colors.black),
                        ),
                        Container(
                          height: 30.0,
                          width: 30.0,
                        ),
                        Icon(
                          Icons.my_library_books_outlined,
                          size: 16.0,
                          color: Colors.black,
                        ),
                        Text(
                          orderCount.toString(),
                          style: new TextStyle(
                              decorationThickness: 3,
                              fontSize: 14.0,
                              color: Colors.black),
                        ),
                        Container(
                          height: 30.0,
                          width: 30.0,
                        ),
                        Icon(
                          Icons.comment,
                          size: 16.0,
                          color: Colors.black,
                        ),
                        new Text(
                          '4',
                          style: new TextStyle(
                              decorationThickness: 3,
                              fontSize: 14.0,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
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
                          color: FlatColors.green_dark),
                      label: Lang(context).products),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.wallet_travel,
                          color: FlatColors.green_dark),
                      label: Lang(context).wallet),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.my_library_books_outlined,
                          color: Colors.green),
                      label: Lang(context).previousOrders),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_rounded,
                          color: FlatColors.green_dark),
                      label: Lang(context).profile),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.exit_to_app,
                          color: FlatColors.orange_light),
                      label: Lang(context).exit),
                ],
                currentIndex: pageindex,
                onTap: (index) {
                  if (index == 0)
                    Navigator.push(context,
                        RouteBuilderService.goto(MarketProductPage(marketId)));
                  if (index == 2)
                    Navigator.push(
                        context, RouteBuilderService.goto(MarketOrderPage()));
                  if (index == 3)
                    Navigator.push(
                        context, RouteBuilderService.goto(MarketInfoPage()));
                  if (index == 4)
                    Navigator.push(
                        context, RouteBuilderService.goto(AccountPage()));
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
                  width: 100,
                  child: Card(
                    child: Text(
                      " " + marketOrder.customerName,
                      style: TextStyle(
                          fontSize: 10,
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
                      child: Text(" " + marketOrder.customerPhone,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  width: 40,
                  child: Card(
                    color: Colors.white,
                    child: Center(
                      child: Text(" " + marketOrder.createTime,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  width: 40,
                  // child: Card(
                  //   color: Colors.white,
                  //   child: Center(
                  //     child: Text(" " + marketOrder.createTime,
                  //         style: TextStyle(
                  //             fontSize: 10,
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold)),
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 25,
                  width: 40,
                  child: InkWell(
                    onTap: () {
                      newToApproveed(marketOrder.id).then((value) {
                        // getMarketOrder();
                        // newMethod();
                      });
                    },
                    child: marketOrder.orderStatus == 'new_order'
                        ? Card(
                            color: Colors.white,
                            child: Icon(Icons.new_releases_outlined,
                                color: Colors.green, size: 16.0))
                        : Card(
                            color: Colors.white,
                            child: Icon(Icons.approval,
                                color: Colors.blue, size: 16.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  newToApproveed(String orderId) async {
    var headers = await AuthService.getDefaultHeaders();
    var adres =
        DataService.marketBaseaddress + 'Order/ApproveOrder?Id=' + orderId;
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    return res.statusCode == 200
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MarketOrderDetailPage(orderId)))
        : MarketOrderModel();
  }

  SizedBox newOrder() {
    return SizedBox(
      height: 25,
      width: 50,
      child: Card(
        color: Colors.lightGreen,
        child: Center(
          child: Text(
            " new ",
            style: TextStyle(
                fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  SizedBox approveOrder() {
    return SizedBox(
      height: 25,
      width: 50,
      child: Card(
        color: Colors.blue,
        child: Center(
          child: Text(
            "approved",
            style: TextStyle(
                fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
