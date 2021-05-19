import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/base_api_result_model.dart';
import '../../../data/models/market/market_comments_result_model.dart';
import '../../../data/repositories/market_repository.dart';

class CommentsNotifier extends ChangeNotifier {
  static CommentsNotifier? _instance;

  factory CommentsNotifier(
    MarketRepository marketRepo,
  ) {
    if (_instance == null) {
      _instance = CommentsNotifier._privateConstructor(marketRepo);
    }

    return _instance!;
  }

  CommentsNotifier._privateConstructor(this.marketRepo);

  final MarketRepository marketRepo;

  bool _wasFetchCommentsCalled = false;
  bool get wasFetchCommentsCalled => _wasFetchCommentsCalled;
  bool _loading = true;
  bool get loading => _loading;
  String? _errorMsg;
  String? get errorMsg => _errorMsg;
  bool? _enableLoadMoreOption;
  bool? get enableLoadMoreOption => _enableLoadMoreOption;
  int _skip = 0;
  int _take = 10;
  int? _totalCount;
  List<MarketComment>? marketComments;

  Future<void> fetchComments(BuildContext context) async {
    if (!_wasFetchCommentsCalled) {
      _wasFetchCommentsCalled = true;
      notifyListeners();
    }

    if (_totalCount == null) {
      var result = await marketRepo.getMarketComments(
        skip: _skip,
        take: _take,
      );

      result.fold(
        (left) => _errorMsg = left.message,
        (right) {
          _totalCount = right.data!.totalCount;
          marketComments = right.data!.result;
          _enableLoadMoreOption = _totalCount != marketComments!.length;
          _skip += _take;
        },
      );

      _loading = false;
    } else {
      if (_totalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await marketRepo.getMarketComments(
        skip: _skip,
        take: _take,
      );

      result.fold(
        (left) => _errorMsg = left.message,
        (right) {
          marketComments!.addAll(right.data!.result!);
          _enableLoadMoreOption = _totalCount != marketComments!.length;
          _skip += _take;
        },
      );

      prgDialog.hide();
    }

    notifyListeners();
  }

  String? replyErrorMsg;
  BaseApiResultModel? replyResult;

  Future<void> replyComment(
    BuildContext context, {
    required String commentId,
    required String reply,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketRepo.replyMarketComment(
      commentId: commentId,
      reply: reply,
    );

    result.fold(
      (left) => replyErrorMsg = left.message,
      (right) => replyResult = right.data,
    );

    prgDialog.hide();
    _refresh(context);
  }

  void _refresh(BuildContext context) async {
    _wasFetchCommentsCalled = false;
    _loading = true;
    _errorMsg = null;
    _skip = 0;
    _take = 10;
    _totalCount = null;
    _enableLoadMoreOption = null;
    marketComments = null;

    fetchComments(context);
  }
}
