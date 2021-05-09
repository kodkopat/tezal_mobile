import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/base_api_result_model.dart';
import '../../../data/models/market/market_default_hours_result_model.dart';
import '../../../data/models/market/market_profile_result_model.dart';
import '../../../data/models/market/update_market_default_hours_model.dart';
import '../../../data/repositories/market_repository.dart';

class ProfileNotifier extends ChangeNotifier {
  static ProfileNotifier? _instance;

  factory ProfileNotifier(
    MarketRepository marketRepo,
  ) {
    if (_instance == null) {
      _instance = ProfileNotifier._privateConstructor(marketRepo);
    }

    return _instance!;
  }

  ProfileNotifier._privateConstructor(this.marketRepo);

  final MarketRepository marketRepo;

  bool wasFetchInfoCalled = false;
  bool infoLoading = true;
  String? infoErrorMsg;
  MarketProfileResultModel? infoResult;

  Future<void> fetchInfo() async {
    if (!wasFetchInfoCalled) {
      wasFetchInfoCalled = true;
      notifyListeners();
    }

    var result = await marketRepo.getMarketProfile();

    result.fold(
      (left) => infoErrorMsg = left.message,
      (right) => infoResult = right,
    );

    infoLoading = false;
    notifyListeners();
  }

  String? updateInfoErrorMsg;
  BaseApiResultModel? updateInfoResult;

  Future<void> updateInfo(
    BuildContext context, {
    required String? id,
    required String? name,
    required String? phone,
    required String? telephone,
    required String? email,
    required String? address,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketRepo.changeMarketProfile(
      id: id,
      name: name,
      phone: phone,
      telephone: telephone,
      email: email,
      address: address,
    );

    result.fold(
      (left) => updateInfoErrorMsg = left.message,
      (right) => updateInfoResult = right,
    );

    prgDialog.hide();
    notifyListeners();
  }

  void refreshInfo() async {
    wasFetchInfoCalled = false;
    infoLoading = true;
    infoErrorMsg = null;
    infoResult = null;

    updateInfoErrorMsg = null;
    updateInfoResult = null;

    fetchInfo();
  }

  bool wasFetchDefaultHoursCalled = false;
  bool defaultHoursLoading = true;
  String? defaultHoursErrorMsg;
  MarketDefaultHoursResultModel? defaultHoursResult;

  Future<void> fetchDefaultHours() async {
    if (!wasFetchDefaultHoursCalled) {
      wasFetchDefaultHoursCalled = true;
      notifyListeners();
    }

    var result = await marketRepo.getMarketDefaultHours();

    result.fold(
      (left) => defaultHoursErrorMsg = left.message,
      (right) => defaultHoursResult = right,
    );

    defaultHoursLoading = false;
    notifyListeners();
  }

  String? updateDefaultHoursErrorMsg;
  BaseApiResultModel? updateDefaultHoursResult;

  Future<void> updateDefaultHours(
    BuildContext context, {
    required List<UpdateMarketDefaultHoursModel> defaultHours,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketRepo.updateMarketDefaultHours(
      defaultHours: defaultHours,
    );

    result.fold(
      (left) => updateDefaultHoursErrorMsg = left.message,
      (right) => updateDefaultHoursResult = right,
    );

    prgDialog.hide();
    notifyListeners();
  }

  void refreshDefaultHours() async {
    wasFetchDefaultHoursCalled = false;
    defaultHoursLoading = true;
    defaultHoursErrorMsg = null;
    defaultHoursResult = null;

    updateDefaultHoursErrorMsg = null;
    updateDefaultHoursResult = null;

    fetchDefaultHours();
  }
}