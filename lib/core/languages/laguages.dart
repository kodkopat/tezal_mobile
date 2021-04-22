import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class Lang {
  BuildContext context;

  Lang.of(this.context) {
    // al stands for appLocalizations
    var al = AppLocalizations.of(context);

    appName = al!.translate('appName') ?? "";

    bottomAppBarItemHome = al.translate('bottomAppBarItemHome') ?? "";
    bottomAppBarItemSearch = al.translate('bottomAppBarItemSearch') ?? "";
    bottomAppBarItemBasket = al.translate('bottomAppBarItemBasket') ?? "";
    bottomAppBarItemProfile = al.translate('bottomAppBarItemProfile') ?? "";
    profileMenuItemAddresses = al.translate('profileMenuItemAddresses') ?? "";

    profileMenuItemWallet = al.translate('profileMenuItemWallet') ?? "";
    profileMenuItemOrders = al.translate('profileMenuItemOrders') ?? "";
    profileMenuItemLikedProducts =
        al.translate('profileMenuItemLikedProducts') ?? "";
    profileMenuItemSettings = al.translate('profileMenuItemSettings') ?? "";
    profileMenuItemAboutUs = al.translate('profileMenuItemAboutUs') ?? "";
    profileMenuItemLogOut = al.translate('profileMenuItemLogOut') ?? "";

    pageLoginAppBar = al.translate('pageLoginAppBar') ?? "";
    pageSignUpAppBar = al.translate('pageSignUpAppBar') ?? "";
    pageHomeAppBar = al.translate('pageHomeAppBar') ?? "";
    pageSearchAppBar = al.translate('pageSearchAppBar') ?? "";
    pageBasketAppBar = al.translate('pageBasketAppBar') ?? "";
    pageProfileAppBar = al.translate('pageProfileAppBar') ?? "";
  }

  late String appName;

  late String bottomAppBarItemHome;
  late String bottomAppBarItemSearch;
  late String bottomAppBarItemBasket;
  late String bottomAppBarItemProfile;

  late String profileMenuItemAddresses;
  late String profileMenuItemWallet;
  late String profileMenuItemOrders;
  late String profileMenuItemLikedProducts;
  late String profileMenuItemSettings;
  late String profileMenuItemAboutUs;
  late String profileMenuItemLogOut;

  late String pageLoginAppBar;
  late String pageSignUpAppBar;
  late String pageHomeAppBar;
  late String pageSearchAppBar;
  late String pageBasketAppBar;
  late String pageProfileAppBar;
}
