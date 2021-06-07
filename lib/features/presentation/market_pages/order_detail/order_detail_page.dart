// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/market/orders_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/order_notifier.dart';
import '../order_comments/order_comments_page.dart';
import 'widgets/order_detail_action_box.dart';
import 'widgets/order_detail_list.dart';
import 'widgets/order_detail_status_timeline.dart';

class OrderDetailPage extends StatelessWidget {
  static const route = "/market_order_detail";

  OrderDetailPage({required this.marketOrder});

  final MarketOrder marketOrder;

  @override
  Widget build(BuildContext context) {
    var orderNotifier = Provider.of<OrderNotifier>(context, listen: false);

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات سفارش",
        showBackBtn: true,
      ),
      body: CustomFutureBuilder(
        future: orderNotifier.fetchPhotos(orderId: marketOrder.orderId),
        successBuilder: (context, data) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                /* OrderListItem(
                  marketOrder: marketOrder,
                  onTap: () {},
                  showIcons: true,
                ),
                SizedBox(height: 8), */
                OrderDetailList(
                  marketOrderItems: marketOrder.items!,
                  marketOrderPhotos: data as List<String>,
                  onItemTap: (index) {},
                ),
                SizedBox(height: 8),
                Parent(
                  gesture: Gestures()
                    ..onTap(() {
                      Routes.sailor.navigate(
                        OrderCommentsPage.route,
                        params: {"orderId": marketOrder.orderId},
                      );
                    }),
                  style: ParentStyle()
                    ..margin(vertical: 8)
                    ..padding(right: 16, left: 4, vertical: 4)
                    ..background.color(Colors.white)
                    ..borderRadius(all: 8)
                    ..boxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 3.0),
                      blur: 6,
                      spread: 0,
                    )
                    ..ripple(true),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        "مشاهده نظر کاربر",
                        style: AppTxtStyles().body..bold(),
                      ),
                      Parent(
                        style: ParentStyle()
                          ..width(48)
                          ..height(48)
                          ..alignmentContent.center(),
                        child: Image.asset(
                          "assets/images/ic_comment.png",
                          color: Colors.black12,
                          fit: BoxFit.contain,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                OrderDetailStatusTimeLime(
                  orderStatusKey: marketOrder.orderStatusKey,
                ),
                const SizedBox(height: 8),
                OrderDetailActionBox(
                  marketOrder: marketOrder,
                  /* onApproveOrder: () async {
                    await orderNotifier.approveOrder(
                      context: context,
                      orderId: marketOrder.orderId,
                    );
                    Routes.sailor.pop();
                  },
                  onRejectOrder: () async {
                    await orderNotifier.rejectOrder(
                      context: context,
                      orderId: marketOrder.orderId,
                    );
                    Routes.sailor.pop();
                  }, */
                ),
              ],
            ),
          );
        },
        errorBuilder: (context, error) {
          return Center(child: AppLoading());
        },
      ),
    );
  }
}
