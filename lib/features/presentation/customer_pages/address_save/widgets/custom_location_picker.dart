import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/services/location.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/action_btn.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../customer_widgets/simple_app_bar.dart';

class CustomLocationPicker extends StatefulWidget {
  @override
  _CustomLocationPickerState createState() => _CustomLocationPickerState();
}

class _CustomLocationPickerState extends State<CustomLocationPicker> {
  late GoogleMapController mapController;

  late LatLng pinPosition;
  late Marker pinMarker;
  late CameraPosition cameraPosition;

  bool loading = true;

  void initializeState() async {
    var currentPosition = await LocationService.getSavedLocation();

    pinPosition = LatLng(
      currentPosition.latitude,
      currentPosition.longitude,
    );

    pinMarker = Marker(
      visible: true,
      icon: BitmapDescriptor.fromBytes(
        await getBytesFromAsset(
          "assets/images/ic_location_marker.png",
        ),
      ),
      markerId: MarkerId("marketId"),
      position: pinPosition,
    );

    cameraPosition = CameraPosition(
      zoom: 15,
      bearing: 30,
      target: pinPosition,
    );

    setState(() => loading = false);
  }

  void refresh(LatLng latlng) async {
    pinPosition = latlng;

    pinMarker = Marker(
      visible: true,
      icon: BitmapDescriptor.fromBytes(
        await getBytesFromAsset(
          "assets/images/ic_location_marker.png",
        ),
      ),
      markerId: MarkerId("marketId"),
      position: pinPosition,
    );

    cameraPosition = CameraPosition(
      zoom: 15,
      bearing: 30,
      target: pinPosition,
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "انتخاب آدرس",
        showBackBtn: true,
      ),
      body: loading
          ? Center(child: AppLoading())
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  initialCameraPosition: cameraPosition,
                  markers: <Marker>{
                    pinMarker,
                  },
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  onTap: (value) {
                    setState(() => refresh(value));
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: ActionBtn(
                      text: "تایید آدرس",
                      onTap: () => Routes.sailor.pop(pinPosition),
                      textColor: Colors.white,
                      background: AppTheme.customerAccent,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Future<Uint8List> getBytesFromAsset(String path) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: 100,
  );
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
