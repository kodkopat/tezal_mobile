import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/modal_image_picker.dart';
import '../../../data/models/photo_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/photos_notifier.dart';
import 'widgets/modal_photo_preview.dart';
import 'widgets/modal_photos_menu.dart';
import 'widgets/photos_list.dart';

class PhotosPage extends StatefulWidget {
  static const route = "/market_photos";

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  PhotosNotifier? photosNotifier;
  bool wasPhotosOrderChanged = false;
  List<PhotoModel>? marketPhotosList;

  @override
  Widget build(BuildContext context) {
    photosNotifier ??= Provider.of<PhotosNotifier>(context, listen: false);

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
                          marketPhotos:
                              marketPhotosList ?? provider.marketPhotos!,
                          onItemTap: (index) {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black,
                              builder: (context) => PhotoPreviewModal(
                                marketPhoto: provider.marketPhotos![index],
                                onRemoveBtnTap: () async {
                                  photosNotifier!
                                      .removePhoto(context,
                                          photoId:
                                              provider.marketPhotos![index].id)
                                      .then((value) => Routes.sailor.pop());
                                },
                              ),
                            );
                          },
                          onReorder: (oldIndex, newIndex) {
                            marketPhotosList = provider.marketPhotos!;

                            var temp = marketPhotosList![oldIndex];
                            marketPhotosList![oldIndex] =
                                marketPhotosList![newIndex];
                            marketPhotosList![newIndex] = temp;

                            if (!wasPhotosOrderChanged) {
                              wasPhotosOrderChanged = true;
                            }

                            setState(() {});
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

    return Stack(
      children: [
        Scaffold(
          appBar: SimpleAppBar(context).create(
            text: Lang.of(context).marketPhotosPage,
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
                showModalBottomSheet(
                  context: context,
                  elevation: 16,
                  isDismissible: true,
                  barrierColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  builder: (context) => PhotosMenuModal(
                    addPhotoOnTap: () async {
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
                        photosNotifier!
                            .addPhoto(context, photo: File(imagePath));
                      }
                    },
                    reOrderPhotosOnTap: () async {
                      if (marketPhotosList != null) {
                        Map<String, int> marketPhotosOrder = {};

                        for (int i = 0; i < marketPhotosList!.length; i++) {
                          marketPhotosOrder["${marketPhotosList![i].id}"] = i;
                        }

                        await photosNotifier!.reOrderPhotos(
                          context,
                          photosList: marketPhotosOrder,
                        );
                      }
                    },
                  ),
                );
              }),
            style: ParentStyle()
              ..width(48)
              ..height(48)
              ..margin(top: 28, horizontal: 4)
              ..alignmentContent.center()
              ..borderRadius(all: 24)
              ..ripple(true),
            child: Image.asset(
              "assets/images/ic_setting.png",
              color: Colors.white,
              fit: BoxFit.contain,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}
