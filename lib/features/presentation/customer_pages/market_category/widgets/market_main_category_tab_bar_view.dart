// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

import '../../../../../core/widgets/loading.dart';
import '../../../../data/models/customer/sub_category_result_model.dart';
import '../../../../data/repositories/customer_category_repository.dart';
import '../../../customer_providers/basket_notifier.dart';
import 'market_sub_category_list.dart';
import 'market_sub_category_view.dart';

class MarketMainCategoryTabBarView extends StatefulWidget {
  MarketMainCategoryTabBarView({
    required this.marketId,
    required this.mainCategoryId,
    required this.basketNotifier,
  });

  final String marketId;
  final String mainCategoryId;
  final BasketNotifier basketNotifier;

  @override
  _MarketMainCategoryTabBarViewState createState() =>
      _MarketMainCategoryTabBarViewState();
}

class _MarketMainCategoryTabBarViewState
    extends State<MarketMainCategoryTabBarView>
    with AutomaticKeepAliveClientMixin<MarketMainCategoryTabBarView> {
  SubCategoryResultModel? subCategoryResultModel;
  bool loading = true;

  List<String> subCategoryNameList = [];
  List<String> subCategoryIdList = [];
  int subCategoryListSelectedIndex = 0;

  void initializeState(BuildContext context) async {
    var customerCategoryRepo = CustomerCategoryRepository();
    var result = await customerCategoryRepo.getSubCategories(
      marketId: widget.marketId,
      mainCategoryId: widget.mainCategoryId,
    );

    result.fold(
      (left) => null,
      (right) {
        print("subCategories: ${right.toJson()}\n");
        right.data!.forEach((subCategory) {
          subCategoryIdList.add(subCategory.id);
          subCategoryNameList.add(subCategory.name);
        });

        setState(() => loading = false);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initializeState(context);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return loading
        ? Center(child: AppLoading())
        : Column(
            children: [
              MarketSubCategoryList(
                textList: subCategoryNameList,
                selectedIndex: subCategoryListSelectedIndex,
                onItemTap: (index) {
                  setState(() {
                    subCategoryListSelectedIndex = index;
                  });
                  print(
                    "selected sub category id: "
                    "${subCategoryIdList[index]}\n",
                  );
                },
              ),
              Expanded(
                child: MarketSubCategoryView(
                  marketId: widget.marketId,
                  subCategoryId:
                      subCategoryIdList[subCategoryListSelectedIndex],
                  basketNotifier: widget.basketNotifier,
                ),
              ),
            ],
          );
  }

  @override
  bool get wantKeepAlive => true;
}
