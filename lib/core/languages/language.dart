import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class Lang {
  BuildContext context;

  Lang.of(this.context) {
    // al stands for appLocalizations
    var al = AppLocalizations.of(context);

    appName = al!.translate("appName") ?? "";

    homePage = al.translate("homePage") ?? "";

    searchPage = al.translate("searchPage") ?? "";

    basketPage = al.translate("basketPage") ?? "";

    ordersPage = al.translate("ordersPage") ?? "";

    productsPage = al.translate("productsPage") ?? "";

    profilePage = al.translate("profilePage") ?? "";
    profileMobile = al.translate("profileMobile") ?? "";
    profileEmail = al.translate("profileEmail") ?? "";
    editProfilePage = al.translate("editProfilePage") ?? "";
    editProfileName = al.translate("editProfileName") ?? "";
    editProfileEmail = al.translate("editProfileEmail") ?? "";

    marketProfileName = al.translate("marketProfileName") ?? "";
    marketProfileMobile = al.translate("marketProfileMobile") ?? "";
    marketProfileTelephone = al.translate("marketProfileTelephone") ?? "";
    marketProfileEmail = al.translate("marketProfileEmail") ?? "";
    marketProfileAddress = al.translate("marketProfileAddress") ?? "";
    marketProfileShabaNumber = al.translate("marketProfileShabaNumber") ?? "";
    marketProfileStatus = al.translate("marketProfileStatus") ?? "";

    addressesPage = al.translate("addressesPage") ?? "";
    title = al.translate("title") ?? "";
    address = al.translate("address") ?? "";
    description = al.translate("description") ?? "";
    province = al.translate("province") ?? "";
    city = al.translate("city") ?? "";
    setDefaultAddress = al.translate("setDefaultAddress") ?? "";
    editAddress = al.translate("editAddress") ?? "";
    deleteAddress = al.translate("deleteAddress") ?? "";

    walletPage = al.translate("walletPage") ?? "";
    walletBalance = al.translate("walletBalance") ?? "";
    walletCharge = al.translate("walletCharge") ?? "";
    walletWithdrawal = al.translate("walletWithdrawal") ?? "";
    walletWithdrawalRequests = al.translate("walletWithdrawalRequests") ?? "";
    transactionType = al.translate("transactionType") ?? "";
    transactionDate = al.translate("transactionDate") ?? "";
    cost = al.translate("cost") ?? "";

    olderOrdersPage = al.translate("olderOrdersPage") ?? "";
    orderMarket = al.translate("orderMarket") ?? "";
    orderDate = al.translate("orderDate") ?? "";
    orderStatus = al.translate("orderStatus") ?? "";

    likedProductsPage = al.translate("likedProductsPage") ?? "";

    workingTimesPage = al.translate("workingTimesPage") ?? "";
    workingTimesPageEdit = al.translate("workingTimesPageEdit") ?? "";
    startTime = al.translate("startTime") ?? "";
    endTime = al.translate("endTime") ?? "";
    weekDay = al.translate("weekDay") ?? "";
    from = al.translate("from") ?? "";
    to = al.translate("to") ?? "";

    marketPhotosPage = al.translate("marketPhotosPage") ?? "";
    addNewPhoto = al.translate("addNewPhoto") ?? "";
    submitPhotosOrder = al.translate("submitPhotosOrder") ?? "";

    marketCommentsPage = al.translate("marketCommentsPage") ?? "";

    sharePage = al.translate("sharePage") ?? "";
    contacts = al.translate("contacts") ?? "";

    settingsPage = al.translate("settingsPage") ?? "";
    settingNotification = al.translate("settingNotification") ?? "";
    settingsLanguage = al.translate("settingsLanguage") ?? "";
    settingsUpdate = al.translate("settingsUpdate") ?? "";

    aboutUsPage = al.translate("aboutUsPage") ?? "";

    logOut = al.translate("logOut") ?? "";
    logOutTitle = al.translate("logOutTitle") ?? "";
    logOutDescription = al.translate("logOutDescription") ?? "";
    logOutAgree = al.translate("logOutAgree") ?? "";
    logOutDisagree = al.translate("logOutDisagree") ?? "";

    loadMore = al.translate("loadMore") ?? "";
    edit = al.translate("edit") ?? "";
    submit = al.translate("submit") ?? "";
    send = al.translate("send") ?? "";
    select = al.translate("select") ?? "";
    rate = al.translate("rate") ?? "";
    date = al.translate("date") ?? "";

    imageFromCamera = al.translate("imageFromCamera") ?? "";
    imageFromGallery = al.translate("imageFromGallery") ?? "";
  }

  late String appName;

  late String homePage;

  late String searchPage;

  late String basketPage;

  late String ordersPage;

  late String productsPage;

  late String profilePage;
  late String profileMobile;
  late String profileEmail;
  late String editProfilePage;
  late String editProfileName;
  late String editProfileEmail;

  late String marketProfileName;
  late String marketProfileMobile;
  late String marketProfileTelephone;
  late String marketProfileEmail;
  late String marketProfileAddress;
  late String marketProfileShabaNumber;
  late String marketProfileStatus;

  late String addressesPage;
  late String title;
  late String address;
  late String description;
  late String province;
  late String city;
  late String setDefaultAddress;
  late String editAddress;
  late String deleteAddress;

  late String walletPage;
  late String walletBalance;
  late String walletCharge;
  late String walletWithdrawal;
  late String walletWithdrawalRequests;
  late String transactionType;
  late String transactionDate;
  late String cost;

  late String olderOrdersPage;
  late String orderMarket;
  late String orderDate;
  late String orderStatus;

  late String likedProductsPage;

  late String workingTimesPage;
  late String workingTimesPageEdit;
  late String startTime;
  late String endTime;
  late String weekDay;
  late String from;
  late String to;

  late String marketPhotosPage;
  late String addNewPhoto;
  late String submitPhotosOrder;

  late String marketCommentsPage;

  late String sharePage;
  late String contacts;

  late String settingsPage;
  late String settingNotification;
  late String settingsLanguage;
  late String settingsUpdate;

  late String aboutUsPage;

  late String logOut;
  late String logOutTitle;
  late String logOutDescription;
  late String logOutAgree;
  late String logOutDisagree;

  late String loadMore;
  late String edit;
  late String submit;
  late String send;
  late String select;
  late String rate;
  late String date;

  late String imageFromCamera;
  late String imageFromGallery;
}
