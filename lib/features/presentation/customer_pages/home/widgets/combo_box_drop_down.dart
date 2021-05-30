// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../data/models/customer/address_model.dart';
import '../../../customer_providers/addresses_notifier.dart';
import '../../../customer_providers/campaign_notifier.dart';
import '../../../customer_providers/market_category_notifier.dart';
import '../../address_save/address_save_page.dart';
import '../../addresses/addresses_page.dart';
import 'combo_box_drop_down_item.dart';

class HomeComboBoxDropDown extends StatefulWidget {
  HomeComboBoxDropDown({
    required this.addresses,
    required this.defaultAddress,
    required this.addressNotifier,
  });

  final List<Address>? addresses;
  final Address? defaultAddress;
  final AddressesNotifier addressNotifier;

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
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemCount: widget.addresses!.length + 1,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var addresses = widget.addresses!;

                        return index != addresses.length
                            ? HomeComboBoxDropDownItem(
                                text: addresses[index].name,
                                iconPath: addresses[index].isDefault
                                    ? "assets/images/ic_location_filled.png"
                                    : "assets/images/ic_location.png",
                                onTap: () async {
                                  await widget.addressNotifier
                                      .setAddressDefault(
                                    addressId: addresses[index].id,
                                  );

                                  Get.find<MarketCategoryNotifier>().refresh();
                                  Get.find<CampaignNotifier>().refresh();

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
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.black12,
                          indent: 8 + 24 + 8,
                          thickness: 0.5,
                          height: 0,
                        );
                      },
                    )
                  : SizedBox(),
            ],
          );
  }
}
