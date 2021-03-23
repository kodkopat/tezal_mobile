import 'package:flutter/material.dart';

import 'adderss_list_item.dart';

class AddressList extends StatelessWidget {
  const AddressList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return AddressListItem();
      },
    );
  }
}
