import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../lang/Lang.dart';
import '../../models/Customer/AddressModel.dart';
import '../../services/AuthService.dart';
import '../../services/DataService.dart';
import '../../services/FlatColors.dart';
import 'widgets/AppBarNew.dart';

class KeyValue {
  const KeyValue(this.id, this.name);
  final String name;
  final String id;
}

class Newaddress extends StatefulWidget {
  final String id;

  const Newaddress({Key key, this.id = ""}) : super(key: key);
  @override
  _NewaddressState createState() => _NewaddressState(id);
}

class _NewaddressState extends State<Newaddress> {
  _NewaddressState(this.id);
  final String id;
  KeyValue province;
  List<KeyValue> provinces;
  bool isdefault = true;
  bool saving = false;
  KeyValue city;
  List<KeyValue> cities;
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController description = new TextEditingController();

  Future<AddressModel> getAdress() async {
    if (id.isNotEmpty) {
      var headers =
          await AuthService.getDefaultHeadersNoLocation(context: context);

      var adres = DataService.customerBaseaddress + 'Address/getAddress';

      var res = await http.get(
          Uri.http(DataService.authority, adres, {'Id': id}),
          headers: headers);

      if (res.statusCode == 200) {
        return AddressModel.fromJson(json.decode(res.body));
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    province = KeyValue('waz', Lang(context).westAzerbaijan);
    provinces = <KeyValue>[province];
    city = KeyValue('urm', Lang(context).urmia);
    cities = <KeyValue>[city];
    return Scaffold(
      appBar: AppBarNew(title: Lang(context).newAddress),
      body: FutureBuilder(
          future: getAdress(),
          builder: (context, AsyncSnapshot<AddressModel> res) {
            if (res.connectionState == ConnectionState.done) {
              if (res.data != null) {
                name.text = res.data.data.name;
                description.text = res.data.data.description;
                address.text = res.data.data.address;
                isdefault = res.data.data.isDefault;
                return buildScaffold(context);
              } else {
                return buildScaffold(context);
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildScaffold(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Lang(context).name + ' :'),
                TextField(
                    controller: name,
                    decoration: InputDecoration(hintText: Lang(context).name)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Lang(context).province + ' :'),
                DropdownButton<KeyValue>(
                    isExpanded: true,
                    value: province,
                    icon: Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: FlatColors.green_light,
                    ),
                    onChanged: (KeyValue newValue) {
                      setState(() {
                        province = newValue;
                      });
                    },
                    items: provinces.map((KeyValue province) {
                      return new DropdownMenuItem<KeyValue>(
                        value: province,
                        child: new Text(
                          province.name,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList()),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Lang(context).city + ' :'),
                DropdownButton<KeyValue>(
                    isExpanded: true,
                    value: city,
                    icon: Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: FlatColors.green_light,
                    ),
                    onChanged: (KeyValue newValue) {
                      setState(() {
                        city = newValue;
                      });
                    },
                    items: cities.map((KeyValue city) {
                      return new DropdownMenuItem<KeyValue>(
                        value: city,
                        child: new Text(
                          city.name,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList()),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Lang(context).address + ' :'),
                TextField(
                    controller: address,
                    decoration:
                        InputDecoration(hintText: Lang(context).address)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Lang(context).description + ' :'),
                TextField(
                  controller: description,
                  decoration:
                      InputDecoration(hintText: Lang(context).description),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Checkbox(
                    value: isdefault,
                    onChanged: (val) {
                      setState(() {
                        isdefault = val;
                      });
                    }),
                Text(Lang(context).isdefault)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              color: FlatColors.green_dark,
              child: InkWell(
                onTap: () async {
                  save();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (saving)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      if (!saving)
                        Text(
                          Lang(context).save,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future save() async {
    setState(() {
      saving = true;
    });
    var headers =
        await AuthService.getDefaultHeadersNoLocation(context: context);
    var body = jsonEncode(<String, dynamic>{
      'id': id ?? '',
      'province': province.id,
      'city': city.id,
      'address': address.text,
      'description': description.text,
      'isDefault': isdefault,
      'name': name.text
    });
    var adres = DataService.customerBaseaddress + 'address/save';

    var res = await http.post(Uri.http(DataService.authority, adres),
        headers: headers, body: body);

    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      if (data["success"].toString().toLowerCase() == 'true') {
        Navigator.pop(context);
      } else {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: FlatColors.red_dark,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(Lang(context).error),
                  )
                ],
              ),
              content: SingleChildScrollView(
                child: Text(data["message"].toString()),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(Lang(context).ok),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    setState(() {
                      saving = false;
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
