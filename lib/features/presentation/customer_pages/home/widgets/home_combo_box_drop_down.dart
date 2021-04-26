// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/customer/addresses_result_model.dart';
import '../../../providers/customer_providers/address_notifier.dart';
import 'home_combo_box_drop_down_item.dart';

class HomeComboBoxDropDown extends StatefulWidget {
  HomeComboBoxDropDown({
    required this.addresses,
    required this.addressNotifier,
  });

  final List<Address> addresses;
  final AddressNotifier addressNotifier;

  @override
  _HomeComboBoxDropDownState createState() => _HomeComboBoxDropDownState();
}

class _HomeComboBoxDropDownState extends State<HomeComboBoxDropDown> {
  bool showAllItems = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Parent(
          gesture: Gestures()
            ..onTap(() {
              setState(() {
                showAllItems = !showAllItems;
              });
            }),
          style: ParentStyle()
            ..height(48)
            ..padding(horizontal: 16)
            ..ripple(true),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Txt(
                  "آدرس تحویل سفارشات خود را مشخص کنید",
                  style: AppTxtStyles().body
                    ..textAlign.start()
                    ..padding(top: 4)
                    ..textColor(Colors.black)
                    ..textOverflow(TextOverflow.fade)
                    ..maxLines(3),
                ),
              ),
              Image.asset(
                showAllItems
                    ? "assets/images/ic_chevron_up.png"
                    : "assets/images/ic_chevron_down.png",
                fit: BoxFit.contain,
                color: Colors.black,
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black12,
          thickness: 0.5,
          height: 0,
        ),
        showAllItems
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: widget.addresses.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var address = widget.addresses[index];
                  return HomeComboBoxDropDownItem(
                    text: address.name,
                    iconPath: address.isDefault
                        ? "assets/images/ic_location_filled.png"
                        : "assets/images/ic_location.png",
                    onTap: () {
                      widget.addressNotifier.setAddressDefault(
                        addressId: address.id,
                      );
                    },
                  );
                },
              )
            : SizedBox(),
      ],
    );
  }
}
