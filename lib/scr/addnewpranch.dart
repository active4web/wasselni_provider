import 'dart:async';
import 'dart:io';

import 'package:commercial_app/bloc/addPranchvalidator.dart';
import 'package:commercial_app/myWidget/inputTextWidget.dart';
import 'package:commercial_app/myWidget/inputTextWidgetWithoutStram.dart';
import 'package:commercial_app/myWidget/myDrawer.dart';
import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:location/location.dart';

class AddnewPranch extends StatefulWidget {
  @override
  _AddnewPranchState createState() => _AddnewPranchState();
}

class _AddnewPranchState extends State<AddnewPranch> {
  DatavalidatorAddPranch v = DatavalidatorAddPranch();

  // Location location = new Location();
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController address = TextEditingController();
  TextEditingController address_en = TextEditingController();

  TextEditingController _textEditingControllerthetarkname =
      TextEditingController();
  TextEditingController _textEditingControllerthetarkdes =
      TextEditingController();
  TextEditingController _textEditingControllerthetarkaddrees =
      TextEditingController();
  CameraPosition _kGooglePlex;
  bool savedata = false;
  File _image;
  AllNetworking _allNetworking = AllNetworking();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LatLng _locationData;
  String title,
      titlen_en,
      phone,
      phone2,
      phone3,
      whatsapp,
      description,
      description_en,
      phone_second,
      phone_third,
      addersinmap,
      city_id;

  // getloc() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   _locationData = await location.getLocation();
  //   _kGooglePlex = CameraPosition(
  //     target: LatLng(_locationData.latitude, _locationData.longitude),
  //     zoom: 15,
  //   );
  //   setState(() {
  //     print(_kGooglePlex.target);
  //   });
  // }

  String token;
  final box = GetStorage();

  @override
  void initState() {
    // getloc();
    token = box.read('token');
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(30.518043908795214, 31.575481854379177),
      zoom: 15,
    );
  }

  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // final CameraPosition _kLake = CameraPosition(
    //   bearing: 192.8334901395799,
    //   target: LatLng(37.43296265331129, -122.08832357078792),
    //   tilt: 59.440717697143555,
    //   zoom: 19.15192605649414);

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: mydrawer(context),
          appBar: AppBar(
            centerTitle: true,
            title: Text('اضافه فرع',
                style: TextStyle(
                  fontFamily: 'Arbf',
                  color: Colors.black,
                )),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 8),
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //  crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var image = await ImagePicker.platform.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 1000,
                              maxWidth: 1000,
                              imageQuality: 100);
                          setState(() {
                            if (image != null) {
                              _image = File(image.path);
                            }
                          });
                        },
                        child: Text('اضافة صورة المكان',
                            style: TextStyle(
                                fontFamily: 'Arbf',
                                color: hexToColor('#ed1c6f'),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      _image == null
                          ? Icon(Icons.camera_alt)
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_image),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 50, left: 50),
                    height: 5,
                    decoration: BoxDecoration(
                        color: hexToColor('#00abeb'),
                        gradient: new LinearGradient(
                            colors: [
                              hexToColor('#2358a6'),
                              hexToColor('#00abeb')
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('ﻣﻌﺮﺽ ﺍﻟﺼﻮﺭ',
                  //         style: TextStyle(
                  //             fontFamily: 'Arbf',
                  //             color: hexToColor('#ed1c6f'),
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold)),
                  //     SizedBox(
                  //       width: 50,
                  //     ),
                  //     Icon(Icons.camera_alt)
                  //   ],
                  // ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'الاسم بالكامل',
                    stram: v.arnameprPranch,
                    changedata: (st) {
                      v.changeName(st);
                      title = st;
                    },
                    inputtype: TextInputType.text,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'Full Name',
                    stram: v.ennamePranch,
                    changedata: (st) {
                      v.changeenName(st);

                      titlen_en = st;
                    },
                    inputtype: TextInputType.text,
                  ),
                  SizedBox(
                    height: high * .02,
                  ),

                  TextFormField(
                    controller: _textEditingControllerthetarkname,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    maxLines: null,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'الاسم بلتركي',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'الاسم بلتركي',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'رقم التلفون',
                    stram: v.mobilePranch,
                    changedata: (st) {
                      v.changearmobile(st);

                      phone = st;
                    },
                    inputtype: TextInputType.phone,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'رقم التلفون ',
                    changedata: (st) {
                      phone2 = st;
                    },
                    inputtype: TextInputType.phone,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'رقم التلفون',
                    changedata: (st) {
                      phone3 = st;
                    },
                    inputtype: TextInputType.phone,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'رقم الوتس اب',
                    stram: v.whatsappPranch,
                    changedata: (st) {
                      v.changewhatsapp(st);

                      whatsapp = st;
                    },
                    inputtype: TextInputType.phone,
                  ),

                  SizedBox(
                    height: high * .01,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: null,
                    controller: address,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'العنوان',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'العنوان',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: high * .01,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: null,
                    controller: address_en,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'address',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'address',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: high * .01,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: null,
                    controller: _textEditingControllerthetarkaddrees,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'العنوان بلتركي',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'العنوان بلتركي',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: null,
                    onChanged: (v) {
                      description = v;
                    },
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'التفاصيل',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'التفاصيل',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: null,
                    onChanged: (v) {
                      description_en = v;
                    },
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'description',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'description',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: high * .02,
                  ),

                  TextFormField(
                    controller: _textEditingControllerthetarkdes,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    maxLines: null,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: 'الوصف بلتركي',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'الوصف بلتركي',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: high * .01,
                  ),
                  inputText(
                    hint: 'العنوان علي الخريطه',
                    changedata: (st) {
                      addersinmap = st;
                    },
                    inputtype: TextInputType.text,
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  Container(
                    height: high * .3,
                    child: Center(
                      child: _kGooglePlex == null
                          ? CircularProgressIndicator()
                          : GoogleMap(
                              zoomGesturesEnabled: true,
                              mapType: MapType.normal,
                              onTap: (LatLng mylocation) {
                                _locationData = mylocation;
                                print(_locationData);
                              },
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                    ),
                  ),
                  SizedBox(
                    height: high * .01,
                  ),
                  savedata
                      ? CircularProgressIndicator()
                      : StreamBuilder(
                          initialData: false,
                          stream: v.profilevileddatastraim,
                          builder: (context, data) {
                            return GestureDetector(
                              onTap: data.data != false
                                  ? () {
                                      print('888888888888888888888');
                                      print(_textEditingControllerthetarkdes
                                          .text);
                                      print(_textEditingControllerthetarkname
                                          .text);
                                      print('888888888888888888888');
                                      _allNetworking
                                          .add_branch(
                                              token_id: token,
                                              description_tr:
                                                  _textEditingControllerthetarkdes
                                                      .text,address_tr: _textEditingControllerthetarkaddrees.text??"",
                                              name_tr:
                                                  _textEditingControllerthetarkname
                                                      .text,
                                              title: title,
                                              location: addersinmap,
                                              titlen_en: titlen_en,
                                              phone: phone,
                                              address_en: address_en.text,
                                              address: address.text,
                                              whatsapp: whatsapp,
                                              description: description,
                                              description_en: description_en,
                                              phone_second: phone2,
                                              phone_third: phone3,
                                              lag: _locationData == null
                                                  ? 37.43296265331129
                                                  : _locationData.longitude,
                                              lat: _locationData == null
                                                  ? -122.08832357078792
                                                  : _locationData.latitude,
                                              file: _image)
                                          .then((value) {
                                        // Get.dialog(
                                        //   AlertDialog(
                                        //     title: Text( ''),
                                        //     content: Text("تم اضافة الفرع"),
                                        //     actions: <Widget>[
                                        //       FlatButton(
                                        //         child: Text("CLOSE"),
                                        //         onPressed: () {
                                        //           //  Get.back();
                                        //         },
                                        //       )
                                        //     ],
                                        //   ),
                                        //   barrierDismissible: false,
                                        // );
                                        Navigator.pop(context);
                                      });
                                      // print("_locationData.longitude");
                                      // print(_locationData.longitude);
                                      // print(_locationData.latitude);
                                      // print(_locationData.accuracy);
                                      // print(_locationData.time);
                                    }
                                  : null,
                              child: Container(
                                height: high * .1,
                                width: width * 0.5,
                                child: Center(
                                  child: Text('حفظ',
                                      style: TextStyle(
                                          fontFamily: 'Arbf',
                                          color: Colors.white,
                                          fontSize: 25)),
                                ),
                                decoration: data.data != false
                                    ? BoxDecoration(
                                        color: hexToColor('#00abeb'),
                                        gradient: new LinearGradient(
                                            colors: [
                                              hexToColor('#2358a6'),
                                              hexToColor('#00abeb')
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            tileMode: TileMode.clamp),
                                        borderRadius:
                                            BorderRadius.circular(5.0))
                                    : BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                              ),
                            );
                          },
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
