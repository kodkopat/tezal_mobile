import 'package:flutter/material.dart';

import '../../../../data/models/addresses_result_model.dart';
import 'home_combo_box_drop_down_item.dart';

class HomeComboBoxDropDown extends StatefulWidget {
  HomeComboBoxDropDown({required this.addresses});

  final List<Address> addresses;

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
        HomeComboBoxDropDownItem(
          text: "آدرس تحویل سفارشات خود را مشخص کنید",
          iconPath: "assets/images/ic_location.png",
          onTap: () {
            setState(() {
              showAllItems = !showAllItems;
            });
          },
          showChevron: true,
          chevronPath: showAllItems
              ? "assets/images/ic_chevron_up.png"
              : "assets/images/ic_chevron_down.png",
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
                    onTap: () {},
                  );
                },
              )
            : SizedBox(),
      ],
    );
  }
}
