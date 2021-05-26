// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/main_category_notifier.dart';
import '../../market_providers/sub_category_notifier.dart';
import '../add_products/add_products_page.dart';
import 'widgets/main_category_tab_bar.dart';
import 'widgets/main_category_tab_bar_view.dart';

class ProductsPage extends StatefulWidget {
  static const route = "/market_products";

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with TickerProviderStateMixin {
  late TabController tabController;

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
          appBar: SimpleAppBar(context).create(
            text: Lang.of(context).productsPage,
          ),
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
      ],
    );
  }
}
