// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/photos_notifier.dart';
import 'widgets/photos_list.dart';

class PhotosPage extends StatelessWidget {
  static const route = "/market_photos";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<PhotosNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchPhotosCalled) {
          provider.fetchPhotos(context);
        }

        return provider.photosLoading
            ? AppLoading()
            : provider.marketPhotos == null
                ? provider.photosErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.photosErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PhotosList(marketPhotos: provider.marketPhotos!),
                        const SizedBox(height: 8),
                        if (provider.photosEnableLoadMoreData!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchPhotos(context);
                          })
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "گالری تصاویر فروشگاه",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
