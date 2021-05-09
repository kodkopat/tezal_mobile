import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
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

  bool wasFetchCommentsCalled = false;
  bool commentsLoading = true;
  String? commentsErrorMsg;

  int commentsSkip = 0;
  int commentsTake = 10;
  int? commentsTotalCount;
  bool? commentsEnableLoadMoreData;

  List<MarketComment>? marketComments;

  Future<void> fetchComments(BuildContext context) async {
    if (!wasFetchCommentsCalled) {
      wasFetchCommentsCalled = true;
      notifyListeners();
    }

    if (commentsTotalCount == null) {
      var result = await marketRepo.getMarketComments(
        skip: commentsSkip,
        take: commentsTake,
      );

      result.fold(
        (left) => commentsErrorMsg = left.message,
        (right) {
          commentsTotalCount = right.data!.totalCount;
          marketComments = right.data!.result;
          commentsEnableLoadMoreData =
              commentsTotalCount != marketComments!.length;
          commentsSkip += commentsTake;
        },
      );

      commentsLoading = false;
    } else {
      if (commentsTotalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await marketRepo.getMarketComments(
        skip: commentsSkip,
        take: commentsTake,
      );

      result.fold(
        (left) => commentsErrorMsg = left.message,
        (right) {
          marketComments!.addAll(right.data!.result!);
          commentsEnableLoadMoreData =
              commentsTotalCount != marketComments!.length;
          commentsSkip += commentsTake;
        },
      );

      prgDialog.hide();
    }

    notifyListeners();
  }

  void refreshComments(BuildContext context) async {
    wasFetchCommentsCalled = false;
    commentsLoading = true;
    commentsErrorMsg = null;
    commentsSkip = 0;
    commentsTake = 10;
    commentsTotalCount = null;
    commentsEnableLoadMoreData = null;
    marketComments = null;

    fetchComments(context);
  }
}
