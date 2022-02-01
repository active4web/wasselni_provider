import 'dart:async';

import 'package:commercial_app/scr/editbranch.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_branches_JSON.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

CameraPosition _kGooglePlex;
List<Marker> _markers = <Marker>[];
Widget branchItemWidg({high, AllProducts branch, width, fundel,context}) {

  print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
  print(branch.nameTr);
  print(branch.nameTr);
  print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
  // if (!branch.lat.trim().isEmpty) {
    _kGooglePlex = CameraPosition(
      target: LatLng(double.tryParse(branch.lat), double.tryParse(branch.lag)),
      zoom: 10,
    );
  _markers.add(
      Marker(
        markerId: MarkerId('1'),
        position:  LatLng(double.tryParse(branch.lat), double.tryParse(branch.lag)),
        // infoWindow: InfoWindow(
        //     title: 'The title of the marker'
        // )
      )
  );

  // } else {
  //   _kGooglePlex = CameraPosition(
  //       bearing: 192.8334901395799,
  //       target: LatLng(37.43296265331129, -122.08832357078792),
  //       tilt: 59.440717697143555,
  //       zoom: 19.151926040649414);
  // }

  Completer<GoogleMapController> _controller = Completer();
  print(branch.productImage);

  return Card(
    elevation: 8,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(branch.brancheName),
                  Text(branch.brancheNameEn),
                  Text( branch.nameTr ),
                  Text(branch.phone),
                  Text(branch.phoneSecond),
                  Text(branch.phoneThird),

                ],
              ),
            ),
            Expanded(
              child: Container(
                width: width * .5,
                child: branch.productImage.trim().isEmpty
                    ? Text('')
                    : Image.network(
                        branch.productImage,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ],
        ),
        Container(
          height: high * .15,
          child: Padding(

            padding: const EdgeInsets.all(8.0),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
          markers:  Set<Marker>.of(_markers),  ),
          ),
        ),
        GestureDetector(
          onTap: fundel,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete),
              Text(' حذف الفرع'),
              SizedBox(
                width: 20,
              ),
              GestureDetector(onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          EditPranch(bid: branch.prodId  )
                  ),
                );

              }, child: Icon(Icons.edit))
            ],
          ),
        )
      ],
    ),
  );
}
