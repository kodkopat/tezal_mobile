import 'package:flutter/material.dart';

class DeliveryProfileNotifier extends ChangeNotifier {
  // static MarketProfileNotifier? _instance;

  // factory MarketProfileNotifier(
  //   MarketRepository marketRepo,
  // ) {
  //   if (_instance == null) {
  //     _instance = MarketProfileNotifier._privateConstructor(marketRepo);
  //   }

  //   return _instance!;
  // }

  // DeliveryProfileNotifier._privateConstructor(this.marketRepo);

  // // final MarketRepository marketRepo;

  // String? shabaNumber;

  // bool wasFetchInfoCalled = false;
  // bool infoLoading = true;
  // String? infoErrorMsg;
  // MarketProfileResultModel? infoResult;

  // Future<void> fetchInfo() async {
  //   if (!wasFetchInfoCalled) {
  //     wasFetchInfoCalled = true;
  //     notifyListeners();
  //   }

  //   var result = await marketRepo.getMarketProfile();

  //   result.fold(
  //     (left) => infoErrorMsg = left.message,
  //     (right) {
  //       infoResult = right;
  //       shabaNumber = infoResult!.data!.shabaNumber;
  //     },
  //   );

  //   infoLoading = false;
  //   notifyListeners();
  // }

  // String? updateInfoErrorMsg;
  // BaseApiResultModel? updateInfoResult;

  // Future<void> updateInfo(
  //   BuildContext context, {
  //   required String? id,
  //   required String? name,
  //   required String? phone,
  //   required String? telephone,
  //   required String? email,
  //   required String? address,
  //   required String? shabaNumber,
  //   required bool? isOpen,
  // }) async {
  //   var prgDialog = AppProgressDialog(context).instance;
  //   prgDialog.show();

  //   var result = await marketRepo.changeMarketProfile(
  //     id: id,
  //     name: name,
  //     phone: phone,
  //     telephone: telephone,
  //     email: email,
  //     address: address,
  //     shabaNumber: shabaNumber,
  //     isOpen: isOpen,
  //   );

  //   result.fold(
  //     (left) => updateInfoErrorMsg = left.message,
  //     (right) => updateInfoResult = right,
  //   );

  //   prgDialog.hide();
  //   notifyListeners();
  // }

  // String? openCloseErrorMsg;
  // BaseApiResultModel? openCloseResult;

  // Future<void> openClose(BuildContext context) async {
  //   var prgDialog = AppProgressDialog(context).instance;
  //   prgDialog.show();

  //   var result = await marketRepo.openCloseMarket();

  //   result.fold(
  //     (left) => openCloseErrorMsg = left.message,
  //     (right) => openCloseResult = right,
  //   );

  //   refreshInfo();

  //   prgDialog.hide();
  //   notifyListeners();
  // }

  // void refreshInfo() async {
  //   wasFetchInfoCalled = false;
  //   infoLoading = true;
  //   infoErrorMsg = null;
  //   infoResult = null;

  //   updateInfoErrorMsg = null;
  //   updateInfoResult = null;

  //   fetchInfo();
  // }
}
