// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/widgets/loading.dart';

class OrderDetailFlutterMaps extends StatefulWidget {
  OrderDetailFlutterMaps({
    required this.controller,
    required this.height,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
  });

  final MapController controller;
  final double height;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;

  @override
  _OrderDetailFlutterMapsState createState() => _OrderDetailFlutterMapsState();
}

class _OrderDetailFlutterMapsState extends State<OrderDetailFlutterMaps> {
  late List<Marker> markers;
  late LatLng center;
  double zoom = 14;
  late MapOptions mapOptions;

  bool loading = true;

  void initialization() async {
    var _marketStyle = ParentStyle()
      ..width(48)
      ..height(48)
      ..alignmentContent.center()
      ..borderRadius(all: 24)
      ..ripple(true);

    markers = [];

    // add origin marker
    markers.add(
      Marker(
        width: 48.0,
        height: 48.0,
        point: LatLng(widget.originLat, widget.originLng),
        builder: (context) => Parent(
          // gesture: Gestures()..onTap(() {}),
          style: _marketStyle,
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 24,
          ),
        ),
      ),
    );

    // add destination marker
    markers.add(
      Marker(
        width: 48.0,
        height: 48.0,
        point: LatLng(widget.destinationLat, widget.destinationLng),
        builder: (context) => Parent(
          // gesture: Gestures()..onTap(() {}),
          style: _marketStyle,
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 24,
          ),
        ),
      ),
    );

    double initialLat = (widget.originLat + widget.destinationLat) / 2;
    double initialLng = (widget.originLng + widget.destinationLng) / 2;

    center = LatLng(initialLat, initialLng);

    mapOptions = MapOptions(
      center: center,
      zoom: zoom,
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
          ? Center(child: AppLoading())
          : Stack(
              children: [
                FlutterMap(
                  mapController: widget.controller,
                  options: mapOptions,
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(markers: markers),
                  ],
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: _MapsZoomController(
                    onZoomInTap: () {
                      print("zoomIn called!\n");
                      setState(() {
                        mapOptions = MapOptions(zoom: zoom++);
                      });
                    },
                    onZoomOutTap: () {
                      print("zoomOut called!\n");
                      setState(() {
                        mapOptions = MapOptions(zoom: zoom--);
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _MapsZoomController extends StatelessWidget {
  _MapsZoomController({
    required this.onZoomInTap,
    required this.onZoomOutTap,
  });

  final VoidCallback onZoomInTap;
  final VoidCallback onZoomOutTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..width(36)
        ..height(72)
        ..borderRadius(all: 4)
        ..background.color(Colors.white.withOpacity(0.75)),
      child: Column(
        children: [
          Parent(
            gesture: Gestures()..onTap(onZoomInTap),
            style: ParentStyle()
              ..width(36)
              ..height(36)
              ..borderRadius(topLeft: 4, topRight: 4)
              ..ripple(true),
            child: Icon(
              Feather.plus,
              color: Colors.black,
              size: 18,
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 0,
          ),
          Parent(
            gesture: Gestures()..onTap(onZoomOutTap),
            style: ParentStyle()
              ..width(36)
              ..height(36)
              ..borderRadius(bottomLeft: 4, bottomRight: 4)
              ..ripple(true),
            child: Icon(
              Feather.minus,
              color: Colors.black,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
