
import 'dart:async';

import 'package:commercial_app/utilitie/jsondata/gate_list_location_json.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScr extends StatefulWidget {
  AllListLocation allListLocation;

 MapScr(this.allListLocation);

  @override
  _MapScrState createState() => _MapScrState();
}

class _MapScrState extends State<MapScr> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker>  markers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    markers.add(
        Marker(
          markerId: MarkerId('1'),
          position:  LatLng(double.tryParse(widget.allListLocation.lat), double.tryParse(widget.allListLocation.lag)),
          // infoWindow: InfoWindow(
          //     title: 'The title of the marker'
          // )
        )
    );
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(double.parse( widget.allListLocation.lat), double.parse(widget.allListLocation.lag)),
      zoom: 10,
    );




    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },  markers: Set<Marker>.of(markers),
      ),

    );
  }

}