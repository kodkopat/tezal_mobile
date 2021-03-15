import 'package:flutter/material.dart';
import 'package:tezal/services/LocationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({
    Key key,
  }) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  _CategoriesPageState() {
    LocationService.refreshLocation();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> p) {
          return Center(
            child: Text(p.connectionState == ConnectionState.done
                ? p.data.getString('longitude')
                : 'loading'),
          );
        });
    // return CampaignSliderWidget(tag: 'null');
  }
}
