import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/widgets/loading.dart';

class OrderDetailMap extends StatefulWidget {
  OrderDetailMap({
    required this.height,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
  });

  final double height;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;

  @override
  State<OrderDetailMap> createState() => _OrderDetailMapState();
}

class _OrderDetailMapState extends State<OrderDetailMap> {
  late GoogleMapController mapController;
  late CameraPosition initialLocation;

  Set<Marker> markers = {};
  bool loading = true;

  void initialization() async {
    Uint8List originMarketIconBytes =
        await getBytesFromAsset("assets/images/ic_location_blue.png");
    var originMarkerIcon = BitmapDescriptor.fromBytes(originMarketIconBytes);

    Uint8List destinationMarketIconBytes =
        await getBytesFromAsset("assets/images/ic_location_green.png");
    var destinationMarkerIcon =
        BitmapDescriptor.fromBytes(destinationMarketIconBytes);

    // add origin marker
    markers.add(Marker(
      visible: true,
      icon: originMarkerIcon,
      markerId: MarkerId("originMarker"),
      position: LatLng(
        widget.originLat,
        widget.originLng,
      ),
    ));

    // add destination marker
    markers.add(Marker(
      visible: true,
      icon: destinationMarkerIcon,
      markerId: MarkerId("destinationMarker"),
      position: LatLng(
        widget.destinationLat,
        widget.destinationLng,
      ),
    ));

    double initialLat = (widget.originLat + widget.destinationLat) / 2;
    double initialLng = (widget.originLng + widget.destinationLng) / 2;

    initialLocation = CameraPosition(
      zoom: 14,
      bearing: 0.0,
      target: LatLng(initialLat, initialLng),
    );

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: loading
          ? AppLoading()
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialLocation,
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
    );
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
}
