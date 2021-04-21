import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/location.dart';
import '../themes/app_theme.dart';
import 'loading.dart';

class MapBox extends StatefulWidget {
  MapBox({
    required this.height,
    this.latitude,
    this.longitude,
  });

  final double height;
  final String? latitude;
  final String? longitude;

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  // var _controller = Completer<GoogleMapController>();
  late GoogleMapController mapController;

  late BitmapDescriptor pinLocationIcon;
  Set<Marker> markers = {};

  late Marker pinMarker;
  late LatLng pinPosition;
  late CameraPosition initialLocation;
  late String mapStyle;
  bool loading = true;

  void initializeState() async {
    Uint8List marketIconBytes = await getBytesFromAsset(
      "assets/images/ic_location_marker.png",
    );

    var markerIcon = BitmapDescriptor.fromBytes(marketIconBytes);

    pinMarker = Marker(
      visible: true,
      icon: markerIcon,
      markerId: MarkerId("marketId"),
      position: LatLng(
        double.parse(widget.latitude!),
        double.parse(widget.longitude!),
      ),
    );

    Position position;
    if (widget.latitude == null) {
      position = await LocationService.getSavedLocation();
    } else {
      position = Position(
        latitude: double.parse(widget.latitude!),
        longitude: double.parse(widget.longitude!),
      );
    }

    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/destination_map_marker.png',
    );

    pinPosition = LatLng(
      position.latitude,
      position.longitude,
    );

    initialLocation = CameraPosition(
      zoom: 16,
      bearing: 32,
      target: pinPosition,
    );

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        ),
      child: SizedBox(
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          child: loading
              ? AppLoading(color: AppTheme.customerPrimary)
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: initialLocation,
                  markers: <Marker>{
                    pinMarker,
                  },
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                ),
        ),
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
