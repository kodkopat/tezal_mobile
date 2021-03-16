import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/CampaignListModel.dart';
import '../services/DataService.dart';

class CampaignSliderWidget extends StatefulWidget {
  const CampaignSliderWidget({Key key, @required this.tag}) : super(key: key);

  final String tag;

  @override
  _CampaignSliderWidgetState createState() => _CampaignSliderWidgetState();
}

class _CampaignSliderWidgetState extends State<CampaignSliderWidget> {
  int _current = 0;
  List<String> imgList;
  Future<CampaignListModel> getCampaigns() async {
    var res = await http
        .get(Uri.http(DataService.customerBaseaddress + 'Campaign/List', ''));
    if (res.statusCode == 200) {
      var data = CampaignListModel.fromJson(json.decode(res.body));
      return data;
    }
    return CampaignListModel();
  }

  @override
  void initState() {
    super.initState();
    getCampaigns().then((res) {
      imgList = new List<String>();
      res.data.forEach((element) {
        imgList.add(DataService.customerBaseaddress +
            'Campaign/GetPhoto?Id=' +
            element.photo);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return imgList == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(children: [
            CarouselSlider(
              items: imgList
                  .map(
                    (item) => Container(
                      child: Center(
                        child: InkWell(
                          onTap: () {},
                          child: Image.network(item,
                              fit: BoxFit.cover, width: 1000),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ]);
  }
}
