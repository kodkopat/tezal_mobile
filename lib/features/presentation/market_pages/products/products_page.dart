// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/main_category_notifier.dart';
import '../../providers/market_providers/sub_category_notifier.dart';
import '../add_products/add_products_page.dart';
import 'widgets/main_category_tab_bar.dart';
import 'widgets/main_category_tab_bar_view.dart';
import 'widgets/search_box.dart';

class ProductsPage extends StatefulWidget {
  static const route = "/market_products";

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  bool showSearchBox = false;

  var searchCtrl = TextEditingController();

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
                        ),
                        textList: provider.mainCategories!
                            .map((e) => "${e.name}")
                            .toList(),
                        onItemTap: (index) {
                          print(
                            "selected main category id: "
                            "${provider.mainCategories![index].id}\n",
                          );
                        },
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: provider.mainCategories!.map((category) {
                            return ChangeNotifierProvider(
                              create: (ctx) => SubCategoryNotifier(
                                provider.marketProductRepo,
                              ),
                              child: MainCategoryTabBarView(
                                mainCategoryId: "${category.id}",
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
          appBar: SimpleAppBar(context).create(text: "محصولات"),
          body: consumer,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Routes.sailor(AddProductsPage.route);
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        Positioned(
          top: 28,
          right: 4,
          child: Parent(
            gesture: Gestures()
              ..onTap(() {
                setState(() {
                  showSearchBox = !showSearchBox;
                });
              }),
            style: ParentStyle()
              ..width(48)
              ..height(48)
              ..borderRadius(all: 24)
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
        ),
        if (showSearchBox)
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: SearchBox(
              controller: searchCtrl,
              onSearchTap: () {},
              terms: [],
            ),
          ),
      ],
    );
  }
}
