import 'dart:convert';
import 'package:tezal/lang/Lang.dart';
import 'package:flutter/material.dart';
import 'package:tezal/screens/AccountPage.dart';
import 'package:tezal/screens/Customer/BasketPage.dart';
import 'package:tezal/screens/Customer/SearchPage.dart';
import 'package:tezal/services/AuthService.dart';
import 'package:tezal/services/DataService.dart';
import 'package:tezal/services/FlatColors.dart';
import 'package:tezal/services/RouteBuilderService.dart';
import 'package:http/http.dart' as http;
import 'HomePage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  static void setIndex(BuildContext context, int index) {
    context.findAncestorStateOfType<_MainPageState>().setIndex(index);
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageindex = 0;
  List<Widget> pages = [];
  Widget page = HomePage();
  Widget searchPage = SearchPage();
  void setIndex(int index) {
    setState(() {
      page = HomePage();
    });
  }

  @override
  void initState() {
    pages = [
      HomePage(),
      searchPage,
      BasketPage(
        isNewWindow: false,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlatColors.grey_light,
      appBar: homepageAppBar(),
      body: IndexedStack(
        index: pageindex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: Lang(context).home),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: Lang(context).search),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: Lang(context).basket),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: Lang(context).account),
        ],
        currentIndex: pageindex,
        onTap: (index) {
          switch (index) {
            case 0:
              setState(() {
                pages = [
                  HomePage(),
                  searchPage,
                  BasketPage(
                    isNewWindow: false,
                  )
                ];
                pageindex = index;
              });

              break;
            case 1:
              setState(() {
                pages = [
                  HomePage(),
                  searchPage,
                  BasketPage(
                    isNewWindow: false,
                  )
                ];
                pageindex = index;
              });
              break;
            case 2:
              setState(() {
                pages = [
                  HomePage(),
                  searchPage,
                  BasketPage(
                    isNewWindow: false,
                  )
                ];
                pageindex = index;
              });
              break;
            case 3:
              Navigator.of(context)
                  .push(
                    new MaterialPageRoute(builder: (_) => AccountPage()),
                  )
                  .then((val) => setState(() {
                        page = HomePage();
                      }));
              break;
            default:
          }
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Future<int> getBasketCount() async {
    var headers = await AuthService.getDefaultHeadersNoLocation();
    var adres = DataService.customerBaseaddress + 'basket/getBasketCount';
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    if (res.statusCode == 200) {
      return int.parse(json.decode(res.body)['data'].toString());
    }
    return 0;
  }

  Widget appbarAction() {
    return FutureBuilder(
        future: getBasketCount(),
        builder: (context, AsyncSnapshot<int> res) {
          return Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () {
                  Navigator.push(
                      context, RouteBuilderService.goto(BasketPage()));
                },
              ),
              if (res.connectionState == ConnectionState.done)
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: FlatColors.white_light),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      res.data.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
            ],
          );
        });
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
                Lang(context).programSlogan,
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          )
        ],
      ),
      //actions: [appbarAction()],
    );
  }
}
