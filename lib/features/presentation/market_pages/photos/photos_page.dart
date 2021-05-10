import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/modal_image_picker.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/photos_notifier.dart';
import 'widgets/modal_photo_preview.dart';
import 'widgets/photos_list.dart';

class PhotosPage extends StatelessWidget {
  static const route = "/market_photos";

  @override
  Widget build(BuildContext context) {
    var photosNotifier = Provider.of<PhotosNotifier>(context, listen: false);

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
                        PhotosList(
                          marketPhotos: provider.marketPhotos!,
                          onItemTap: (index) {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black,
                              builder: (context) => PhotoPreviewModal(
                                marketPhoto: provider.marketPhotos![index],
                                onRemoveBtnTap: () async {
                                  photosNotifier
                                      .removePhoto(context,
                                          photoId:
                                              provider.marketPhotos![index].id)
                                      .then((value) => Routes.sailor.pop());
                                },
                              ),
                            );
                          },
                        ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await showModalBottomSheet(
            context: context,
            elevation: 16,
            isDismissible: true,
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            builder: (context) => ImagePickerModal(),
          );

          if (result != null) {
            var imagePath = result as String;
            photosNotifier.addPhoto(context, photo: File(imagePath));
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
