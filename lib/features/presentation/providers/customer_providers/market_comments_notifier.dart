import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/comments_result_model.dart';
import '../../../data/repositories/customer_market_repository.dart';

// tip: this class must not be a singleton
// because it used for any object of ProductListItem
// then, when it used as singleton in dispose method of
// widgets, this object will be gone!
class MarketCommentsNotifier extends ChangeNotifier {
  MarketCommentsNotifier(this.customerMarketRepository);

  final CustomerMarketRepository customerMarketRepository;

  bool marketCommentsLoading = true;
  String? marketCommentsErrorMsg;

  bool? enableLoadMoreData;
  int? marketCommentsTotalCount;
  int? latestPageIndex;
  List<Comment>? marketComments;

  Future<void> fetchProductComments(
    BuildContext context, {
    required String marketId,
  }) async {
    if (marketCommentsTotalCount == null) {
      var result = await customerMarketRepository.marketComments(
        marketId: marketId,
        page: 1,
      );

      result.fold(
        (left) => marketCommentsErrorMsg = left.message,
        (right) {
          marketCommentsTotalCount = right.data!.total;
          latestPageIndex = right.data!.page;
          marketComments = right.data!.comments!;
          enableLoadMoreData =
              marketCommentsTotalCount != marketComments!.length;
        },
      );
      marketCommentsLoading = false;
    } else {
      if (marketCommentsTotalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await customerMarketRepository.marketComments(
        marketId: marketId,
        page: latestPageIndex! + 1,
      );

      result.fold(
        (left) => marketCommentsErrorMsg = left.message,
        (right) {
          marketCommentsTotalCount = right.data!.total;
          latestPageIndex = right.data!.page;
          marketComments!.addAll(right.data!.comments!);
          enableLoadMoreData =
              marketCommentsTotalCount != marketComments!.length;
        },
      );

      prgDialog.hide();
    }
    notifyListeners();
  }
}
