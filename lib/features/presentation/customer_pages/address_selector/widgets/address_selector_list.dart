import 'package:flutter/material.dart';

import '../../../providers/customer_providers/address_notifier.dart';
import 'address_selector_list_item.dart';

class AddressSelectorList extends StatelessWidget {
  const AddressSelectorList({@required this.addressNotifier});

  final AddressNotifier addressNotifier;

  @override
  Widget build(BuildContext context) {
    var list = addressNotifier.addressList;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return AddressSelectorListItem(
          address: list[index],
          onTap: () async {
            await addressNotifier.setAddressDefault(
              addressId: list[index].id,
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.black12,
          thickness: 0.5,
          height: 0,
        );
      },
    );
  }
}
