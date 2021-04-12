import 'package:flutter/material.dart';

import '../../../../data/models/address_result_model.dart';
import 'address_detail_menu_item.dart';

class AddressDetailMenu extends StatelessWidget {
  const AddressDetailMenu({required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddressDetailMenuItem(
            title: "عنوان:",
            text: "${address.name}",
          ),
          AddressDetailMenuItem(
            title: "آدرس:",
            text: "${address.address}",
          ),
          AddressDetailMenuItem(
            title: "توضیحات:",
            text: "${address.description}",
          ),
          AddressDetailMenuItem(
            title: "استان:",
            text: "${address.province}",
          ),
          AddressDetailMenuItem(
            title: "شهر:",
            text: "${address.city}",
          ),
        ],
      ),
    );
  }
}
