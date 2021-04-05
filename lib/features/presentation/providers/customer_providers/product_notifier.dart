import 'package:flutter/material.dart';

import '../../../data/repositories/customer_product_repository.dart';

class ProductNotifier extends ChangeNotifier {
  ProductNotifier(this.customerProductRepo);

  final CustomerProductRepository customerProductRepo;
}
