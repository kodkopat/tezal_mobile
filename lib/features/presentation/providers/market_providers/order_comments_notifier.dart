import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/base_api_result_model.dart';
import '../../../data/models/market/order_comments_result_model.dart';
import '../../../data/repositories/market_order_repository.dart';

class OrderCommentsNotifier extends ChangeNotifier {
  OrderCommentsNotifier(this.marketOrderRepo);

  final MarketOrderRepository marketOrderRepo;

  bool wasFetchCommentsCalled = false;
  bool commentsLoading = true;
  String? commentsErrorMsg;

  int commentsSkip = 0;
  int commentsTake = 10;
  int? commentsTotalCount;
  bool? commentsEnableLoadMoreData;

  List<OrderComment>? orderComments;

  Future<void> fetchComments(BuildContext context,
      {required String orderId}) async {
    if (!wasFetchCommentsCalled) {
      wasFetchCommentsCalled = true;
      notifyListeners();
    }

    if (commentsTotalCount == null) {
      var result = await marketOrderRepo.getOrderComments(
        orderId: orderId,
        skip: commentsSkip,
        take: commentsTake,
      );

      result.fold(
        (left) => commentsErrorMsg = left.message,
        (right) {
          commentsTotalCount = right.data!.totalCount;
          orderComments = right.data!.result;
          commentsEnableLoadMoreData =
              commentsTotalCount != orderComments!.length;
          commentsSkip += commentsTake;
        },
      );

      commentsLoading = false;
    } else {
      if (commentsTotalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await marketOrderRepo.getOrderComments(
        orderId: orderId,
        skip: commentsSkip,
        take: commentsTake,
      );

      result.fold(
        (left) => commentsErrorMsg = left.message,
        (right) {
          orderComments!.addAll(right.data!.result!);
          commentsEnableLoadMoreData =
              commentsTotalCount != orderComments!.length;
          commentsSkip += commentsTake;
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

    var result = await marketOrderRepo.replyOrderComments(
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
    wasFetchCommentsCalled = false;
    commentsLoading = true;
    commentsErrorMsg = null;
    commentsSkip = 0;
    commentsTake = 10;
    commentsTotalCount = null;
    commentsEnableLoadMoreData = null;
    orderComments = null;

    notifyListeners();
  }
}
