import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/Market/OrderDetailModel.dart';
import '../../services/AuthService.dart';
import '../../services/DataService.dart';
import '../../services/RouteBuilderService.dart';
import 'MarketMainPage.dart';

class MarketOrderDetailPage extends StatefulWidget {
  final String orderId;

  const MarketOrderDetailPage(this.orderId);

  @override
  _MarketOrderDetailPageState createState() =>
      _MarketOrderDetailPageState(orderId: orderId);
}

class _MarketOrderDetailPageState extends State<MarketOrderDetailPage> {
  String orderId;
  List<Widget> items = [];
  var pages;
  int pageindex = 0;

  _MarketOrderDetailPageState({this.orderId});

  GlobalKey<AnimatedListState> _keys = new GlobalKey<AnimatedListState>();
  var storage = new FlutterSecureStorage();

  Future<OrderDetailModel> getOrderDetail() async {
    var headers = await AuthService.getDefaultHeaders();
    var adres = DataService.marketBaseaddress +
        'Order/GetOrderDetail?Id=' +
        this.orderId;
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    return res.statusCode == 200
        ? orderDetailModelFromJson(res.body)
        : OrderDetailModel();
  }

  void add(OrderDetailModel data) async {
    Future ft = Future(() {});
    data.data.forEach((element) {
      ft = ft.then((value) {
        return Future.delayed(Duration(milliseconds: 100), () {
          items.add(orderItem(element));
          _keys.currentState.insertItem(items.length - 1);
        });
      });
    });
  }

  var ass = Tween(begin: Offset(1, 0), end: Offset(0, 0));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOrderDetail(),
        builder: (context, AsyncSnapshot<OrderDetailModel> res) {
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
                title: Text("Order Detail Page"),
                automaticallyImplyLeading: false,
              ),
              // body: Center(
              //   child: MyStatefulWidget(),
              // ),
              body: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 1000,
                      child: AnimatedList(
                        key: _keys,
                        initialItemCount: items.length,
                        itemBuilder: (context, index, animation) {
                          return SlideTransition(
                              child: items[index],
                              position: animation.drive(ass));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.grey,
                selectedFontSize: 11,
                unselectedFontSize: 11,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.green),
                      label: 'mainPage'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.fact_check_sharp, color: Colors.green),
                      label: 'complete'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.exit_to_app, color: Colors.blue),
                      label: 'Exit'),
                ],
                currentIndex: pageindex,
                onTap: (index) {
                  if (index == 0) {
                    Navigator.push(
                        context, RouteBuilderService.goto(MarketMainPage()));
                  } else if (index == 1) {
                    approvedToondelivery(orderId);

                    Navigator.push(
                        context, RouteBuilderService.goto(MarketMainPage()));
                  }
                },
                type: BottomNavigationBarType.fixed,
              ),
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }

  Widget orderItem(OrderDetail orderDetail) {
    return SizedBox(
      height: 90,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 1.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      DataService.marketBaseaddress +
                          'product/GetPhoto?Id=' +
                          orderDetail.photoId,
                      height: 55,
                      width: 70,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 93.0,
                          height: 22.0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //color: Color.fromARGB(255, 37, 94, 151),
                            color: Colors.blue,
                            child: Column(
                              children: <Widget>[
                                Text(
                                    "Amount : " + orderDetail.amount.toString(),
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 93.0,
                          height: 22.0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.blue,
                            child: Column(
                              children: <Widget>[
                                Text(
                                    "Price  : " +
                                        orderDetail.originalPrice.toString(),
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 93.0,
                          height: 22.0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.blue,
                            child: Column(
                              children: <Widget>[
                                Text(
                                    " Discount : " +
                                        orderDetail.discountedPrice.toString(),
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 200.0,
                        height: 23.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.grey[400],
                          child: Text(
                            "   " + orderDetail.productName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 65.0,
                          height: 23.0,
                          child: MyStatefulWidget(orderDetail.productName))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 65.0,
                        height: 25.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.blue,
                          child: Text(
                            "    " + orderDetail.totalPrice.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  approvedToondelivery(String orderId) async {
    var headers = await AuthService.getDefaultHeaders();
    var adres =
        DataService.marketBaseaddress + 'Order/PrepareOrder?Id=' + orderId;
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    return res.statusCode == 200
        ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => MarketMainPage()))
        : OrderDetailModel();
  }
}

class MyStatefulWidget extends StatefulWidget {
  final String productName;

  const MyStatefulWidget(this.productName);

  @override
  _MyStatefulWidgetState createState() =>
      _MyStatefulWidgetState(productName: productName);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _isChecked = false;
  String productName;
  List<String> switchProduct = [];

  _MyStatefulWidgetState({this.productName});

  @override
  Widget build(BuildContext context) {
    return
        // Switch(
        //   value: switchProduct.contains(productName) ? true : false,
        //   onChanged: (value) {
        //     if (value) {
        //       if (!switchProduct.contains(productName)) {
        //         setState(() {
        //           switchProduct.add(productName);
        //         });
        //       } else {
        //         setState(() {
        //           switchProduct.remove(productName);
        //         });
        //       }
        //     }
        //   },
        //   activeColor: Colors.green,
        // );

        Switch(
            activeColor: Colors.green,
            value: _isChecked,
            onChanged: (checked) {
              setState(() {
                _isChecked = !_isChecked;
              });
            });
  }
}
