// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/delivery/orders_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/order_detail_field.dart';
import 'widgets/order_detail_flutter_map.dart';

class OrderDetailPage extends StatelessWidget {
  static const route = "/delivery_order_detail";

  OrderDetailPage({required this.orderItem});

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
/*
    // sml stands for, splited market's location
    List<String> sml = "${orderItem.marketLocation}".split("-");
    // scl stands for, splited customer's location
    List<String> scl = "${orderItem.customerLocation}".split("-");

    double originLat = double.parse(sml.first);
    double originLng = double.parse(sml.last);
    double destinationLat = double.parse(scl.first);
    double destinationLng = double.parse(scl.last);
*/

    double originLat = double.parse("35.699726");
    double originLng = double.parse("51.338080");
    double destinationLat = double.parse("35.699756");
    double destinationLng = double.parse("51.324863");

    var mapController = MapController();

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات سفارش",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
/*
            OrderDetailMap(
              height: 256,
              originLat: originLat,
              originLng: originLng,
              destinationLat: destinationLat,
              destinationLng: destinationLng,
            ),
*/

            OrderDetailFlutterMaps(
              controller: mapController,
              height: 256,
              originLat: originLat,
              originLng: originLng,
              destinationLat: destinationLat,
              destinationLng: destinationLng,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt("اطلاعات مشتری", style: AppTxtStyles().body..bold()),
                  OrderDetailField(
                    title: "نام",
                    text: "${orderItem.customerName}",
                  ),
                  OrderDetailField(
                    title: "آدرس",
                    text: "${orderItem.customerAdress}",
                  ),
                  const SizedBox(height: 16),
                  Txt("اطلاعات فروشگاه", style: AppTxtStyles().body..bold()),
                  OrderDetailField(
                    title: "نام",
                    text: "${orderItem.marketName}",
                  ),
                  OrderDetailField(
                    title: "آدرس",
                    text: "${orderItem.marketAdress}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
