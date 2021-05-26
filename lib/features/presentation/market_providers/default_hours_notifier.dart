import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/base_api_result_model.dart';
import '../../data/models/market/market_comments_result_model.dart';
import '../../data/models/market/market_default_hours_result_model.dart';
import '../../data/models/market/update_market_default_hours_model.dart';
import '../../data/repositories/market_repository.dart';

class DefaultHoursNotifier extends ChangeNotifier {
  static DefaultHoursNotifier? _instance;

  factory DefaultHoursNotifier(
    MarketRepository marketRepo,
  ) {
    if (_instance == null) {
      _instance = DefaultHoursNotifier._privateConstructor(marketRepo);
    }

    return _instance!;
  }

  DefaultHoursNotifier._privateConstructor(this.marketRepo);

  final MarketRepository marketRepo;

  bool wasFetchCommentsCalled = false;
  bool commentsLoading = true;
  String? commentsErrorMsg;

  int commentsSkip = 0;
  int commentsTake = 10;
  int? commentsTotalCount;
  bool? commentsEnableLoadMoreData;

  List<MarketComment>? marketComments;

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
