// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/main_category_notifier.dart';
import '../../providers/market_providers/products_notifier.dart';
import '../../providers/market_providers/sub_category_notifier.dart';
import '../search_products/search_products_page.dart';
import 'widgets/main_category_tab_bar.dart';
import 'widgets/main_category_tab_bar_view.dart';

class AddProductsPage extends StatefulWidget {
  static const route = "/market_add_products";

  @override
  _AddProductsPageState createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<MainCategoryNotifier>(
      builder: (context, provider, child) {
        if (provider.mainCategories == null) {
          provider.fetchMainCategories();
        }

        return provider.mainCategoriesLoading
            ? Center(child: AppLoading())
            : provider.mainCategories == null
                ? provider.mainCategoriesErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt("${provider.mainCategoriesErrorMsg}",
                        style: AppTxtStyles().body..alignment.center())
                : Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainCategoryTabBar(
                        controller: tabController = TabController(
                          length: provider.mainCategories!.length,
                          vsync: this,
                        )..addListener(() {
                            var mainCategories = provider.mainCategories!;
                            var currentMainCategory =
                                mainCategories[this.tabController.index];

                            var id = currentMainCategory.id;
                            var name = currentMainCategory.name;

                            Get.put<String>(name, tag: id);
                          }),
                        textList: provider.mainCategories!
                            .map((e) => "${e.name}")
                            .toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children:
                              provider.mainCategories!.map((mainCategory) {
                            return MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                  create: (ctx) => SubCategoryNotifier(
                                    provider.marketProductRepo,
                                  ),
                                ),
                                ChangeNotifierProvider(
                                  create: (ctx) => ProductsNotifier(
                                    provider.marketProductRepo,
                                  ),
                                ),
                              ],
                              child: MainCategoryTabBarView(
                                mainCategoryId: "${mainCategory.id}",
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  );
      },
    );

    return Stack(
      children: [
        Scaffold(
          appBar: SimpleAppBar(context).create(
            text: "محصولات",
            showBackBtn: true,
          ),
          body: consumer,
        ),
        Align(
          alignment: Directionality.of(context) == TextDirection.ltr
              ? Alignment.topRight
              : Alignment.topLeft,
          child: Parent(
            gesture: Gestures()
              ..onTap(() {
                Routes.sailor(SearchProductsPage.route);
              }),
            style: ParentStyle()
              ..width(48)
              ..height(48)
              ..borderRadius(all: 24)
              ..margin(horizontal: 4, top: 28)
              ..alignmentContent.center()
              ..ripple(true),
            child: Image.asset(
              "assets/images/ic_search.png",
              color: Colors.white,
              fit: BoxFit.contain,
              width: 24,
              height: 24,
            ),
          ),
        )
      ],
    );
  }
}
