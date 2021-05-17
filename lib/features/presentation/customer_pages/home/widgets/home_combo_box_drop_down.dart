// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../data/models/customer/addresses_result_model.dart';
import '../../../providers/customer_providers/address_notifier.dart';
import '../../address_save/address_save_page.dart';
import '../../addresses/addresses_page.dart';
import 'home_combo_box_drop_down_item.dart';

class HomeComboBoxDropDown extends StatefulWidget {
  HomeComboBoxDropDown({
    required this.addresses,
    required this.defaultAddress,
    required this.addressNotifier,
  });

  final List<Address>? addresses;
  final Address? defaultAddress;
  final AddressNotifier addressNotifier;

  @override
  _HomeComboBoxDropDownState createState() => _HomeComboBoxDropDownState();
}

class _HomeComboBoxDropDownState extends State<HomeComboBoxDropDown> {
  bool showAllItems = false;

  @override
  Widget build(BuildContext context) {
    return widget.addresses!.isEmpty
        ? HomeComboBoxDropDownItem(
            text: "آدرس تحویل سفارشات خود را مشخص کنید",
            iconPath: "assets/images/ic_location.png",
            onTap: () {
              Routes.sailor(AddressesPage.route);
            },
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.defaultAddress == null
                  ? HomeComboBoxDropDownItem(
                      text: "آدرس پیش‌فرض برای تحویل را مشخص کنید",
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
                    )
                  : HomeComboBoxDropDownItem(
                      text: widget.defaultAddress!.name,
                      iconPath: "assets/images/ic_location_filled.png",
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
              Divider(
                color: Colors.black12,
                thickness: 0.5,
                height: 0,
              ),
              showAllItems
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.addresses!.length + 1,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return index != widget.addresses!.length
                            ? HomeComboBoxDropDownItem(
                                text: widget.addresses![index].name,
                                iconPath: widget.addresses![index].isDefault
                                    ? "assets/images/ic_location_filled.png"
                                    : "assets/images/ic_location.png",
                                onTap: () async {
                                  await widget.addressNotifier
                                      .setAddressDefault(
                                    addressId: widget.addresses![index].id,
                                  );
                                  setState(() {
                                    showAllItems = !showAllItems;
                                  });
                                },
                              )
                            : HomeComboBoxDropDownItem(
                                text: "افزودن آدرس جدید",
                                iconPath: "assets/images/ic_location_add.png",
                                onTap: () {
                                  Routes.sailor.navigate(
                                    AddressSavePage.route,
                                    params: {},
                                  );
                                  setState(() {
                                    showAllItems = !showAllItems;
                                  });
                                },
                              );
                      },
                    )
                  : SizedBox(),
            ],
          );
  }
}
