import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapForOlder extends StatefulWidget {
  final double lat;

  final double lag;
  MapForOlder({this.lat, this.lag});

  @override
  _MapForOlderState createState() => _MapForOlderState();
}

class _MapForOlderState extends State<MapForOlder> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    markers.add(Marker(
      markerId: MarkerId('1'),
      position: LatLng(widget.lat, widget.lag),

      // infoWindow: InfoWindow(
      //     title: 'The title of the marker'
      // )
    ));
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.lag),
      zoom: 10,
    );

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        buildingsEnabled: true,
        indoorViewEnabled: true,
        mapToolbarEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        myLocationEnabled: true,
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
    );
  }
}
