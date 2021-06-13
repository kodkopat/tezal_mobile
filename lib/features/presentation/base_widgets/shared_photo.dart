import 'package:flutter/material.dart';

import '../../../core/consts/consts.dart';
import 'custom_image_network.dart';

class SharedPhoto {
  static const _apiUrlPrefix = "Shared";

  static Widget getProductPhoto({required String id}) {
    return CustomImageNetwork(
      imageUrl: "$sharedBaseApiUrl$_apiUrlPrefix/GetProductPhoto?Id=$id",
    );
  }

  static Widget getMarketPhoto({required String id}) {
    return CustomImageNetwork(
      imageUrl: "$sharedBaseApiUrl$_apiUrlPrefix/GetMarketPhoto?Id=$id",
    );
  }

  static Widget getMarketCategoryPhoto({required String id}) {
    return CustomImageNetwork(
      imageUrl: "$sharedBaseApiUrl$_apiUrlPrefix/GetMarketCategoryPhoto?Id=$id",
    );
  }

  static Widget getMainCategoryPhoto({required String id}) {
    return CustomImageNetwork(
      imageUrl: "$sharedBaseApiUrl$_apiUrlPrefix/GetMainCategoryPhoto?Id=$id",
    );
  }

  static Widget getSubCategoryPhoto({required String id}) {
    return CustomImageNetwork(
      imageUrl: "$sharedBaseApiUrl$_apiUrlPrefix/GetSubCategoryPhoto?Id=$id",
    );
  }
}
