import 'dart:async';
import 'dart:io';

import 'package:commercial_app/bloc/Profileedatavalidator.dart';
import 'package:commercial_app/myWidget/gallery.dart';

import 'package:commercial_app/myWidget/myDrawer.dart';
import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/preparation_profile_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class Profilee extends StatefulWidget {
  @override
  _ProfileeState createState() => _ProfileeState();
}

class _ProfileeState extends State<Profilee> {
  TextEditingController bilednumber = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController titlen_en = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController phone3 = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController state_id = TextEditingController();

  TextEditingController description = TextEditingController();
  TextEditingController description_en = TextEditingController();

  TextEditingController addersinmap = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController twiter = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController insta = TextEditingController();
  TextEditingController dlivery = TextEditingController();

  TextEditingController address = TextEditingController();

//====================================

  TextEditingController name_tr = TextEditingController();

  TextEditingController address_tr = TextEditingController();
  TextEditingController des_tr = TextEditingController();

  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  Location location = new Location();
  Completer<GoogleMapController> _controller = Completer();
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  LatLng _locationtosend;
  bool _serviceEnabled;
  CameraPosition _kGooglePlex;
  bool setcaruntloction = false;
  File _image;
  bool senddata = false;
  List<Marker> _markers = <Marker>[];
  getloc() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    _markers.add(Marker(
      markerId: MarkerId('1'),
      position: LatLng(_locationData.latitude, _locationData.longitude),
      // infoWindow: InfoWindow(
      //     title: 'The title of the marker'
      // )
    ));
    _kGooglePlex = CameraPosition(
      target: LatLng(_locationData.latitude, _locationData.longitude),
      zoom: 14,
    );
    print(_locationData.latitude);
    print(_locationData.longitude);
    _locationtosend = LatLng(_locationData.latitude, _locationData.longitude);
    // setState(() {
    //   print(_locationData.latitude);
    // });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: mydrawer(context),
          appBar: AppBar(
            centerTitle: true,
            title: Text('ﺍﻟﺒﺮﻭﻓﺎﻳﻞ',
                style: TextStyle(
                  fontFamily: 'Arbf',
                  color: Colors.black,
                )),
          ),
          body: StreamBuilder<Preparation_profile_json>(
              stream: _allNetworking
                  .preparation_profile(token_id: box.read('token'))
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data.message);
                  print('99999999999999999999999999999999999999');
                  print(snapshot.data.result.serviceDetails.length);
                  ServiceDetails dat = snapshot.data.result.serviceDetails[0];
                  address.text = dat.address;

                  address_tr.text = dat.addressTr;
                  name_tr.text = dat.nameTr;
                  des_tr.text = dat.descriptionTr;

                  title.text = dat.nameAr;

                  password.text = dat.password;

                  titlen_en.text = dat.nameEn;
                  phone.text = dat.phone;
                  phone2.text = dat.phoneSecond;
                  phone3.text = dat.phoneThird;
                  whatsapp.text = dat.whatsapp;

                  description.text = dat.description;
                  description_en.text = dat.descriptionEn;

                  addersinmap.text = dat.location;
                  facebook.text = dat.facebook;
                  twiter.text = dat.twitter;
                  insta.text = dat.instagram;
                  if (dat.lag.trim().isEmpty) {
                    _locationtosend =
                        LatLng(29.844621439086723, 31.334775711571776);
                    _kGooglePlex = CameraPosition(
                      target: LatLng(29.844621439086723, 31.334775711571776),
                      zoom: 14,
                    );
                    _markers.add(Marker(
                      markerId: MarkerId('1'),
                      position: LatLng(29.844621439086723, 31.334775711571776),
                      // infoWindow: InfoWindow(
                      //     title: 'The title of the marker'
                      // )
                    ));
                  } else {
                    _locationtosend =
                        LatLng(double.parse(dat.lat), double.parse(dat.lag));
                    _markers.add(Marker(
                      markerId: MarkerId('1'),
                      position:
                          LatLng(double.parse(dat.lat), double.parse(dat.lag)),
                      // infoWindow: InfoWindow(
                      //     title: 'The title of the marker'
                      // )
                    ));
                    _kGooglePlex = CameraPosition(
                      target:
                          LatLng(double.parse(dat.lat), double.parse(dat.lag)),
                      zoom: 14,
                    );
                  }
                  if (dat.deliveryOn == '1') {
                    dlivery.text = 'يوجد دليفيري';
                  } else {
                    dlivery.text = 'لايوجد دليفيري ';
                  }
                  print('iiiiiiiiiiiiiiiii');
                  print(dat.mainImg);
                  print(dat.mainImg);
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 50, left: 50, right: 50, bottom: 8),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var image = await ImagePicker.platform.pickImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 200,
                                  maxWidth: 200,
                                  imageQuality: 100);
                              setState(() {
                                if (image != null) {
                                  _image = File(image.path);
                                }
                              });
                            },
                            child: _image == null && dat.mainImg.trim().isEmpty
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //  crossAxisAlignment: CrossAxisAlignment.baseline,
                                    children: [
                                      Text('اضافة صورة المكان',
                                          style: TextStyle(
                                              fontFamily: 'Arbf',
                                              color: hexToColor('#ed1c6f'),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Icon(Icons.camera_alt)
                                    ],
                                  )
                                : _image == null
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        child: Image.network(
                                          dat.mainImg,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        child: Image.file(
                                          _image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
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
                                borderRadius: BorderRadius.circular(40.0)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Gallery()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ﻣﻌﺮﺽ ﺍﻟﺼﻮﺭ',
                                    style: TextStyle(
                                        fontFamily: 'Arbf',
                                        color: hexToColor('#ed1c6f'),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(Icons.camera_alt)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                            textEditingController: title,
                            hint: 'الاسم بالكامل',
                            inputtype: TextInputType.text,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                            textEditingController: titlen_en,
                            hint: 'Full Name',
                            inputtype: TextInputType.text,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                            textEditingController: name_tr,
                            hint: 'الاسم بلتركي',
                            inputtype: TextInputType.text,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),

                          mywidget(
                            textEditingController: description,
                            hint: 'الوصف',
                            inputtype: TextInputType.multiline,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),

                          mywidget(
                            textEditingController: des_tr,
                            hint: 'الوصف بلتركي',
                            inputtype: TextInputType.multiline,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                            textEditingController: description_en,
                            hint: 'Details',
                            inputtype: TextInputType.multiline,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                            textEditingController: password,
                            hint: 'كلمه المرور',
                            inputtype: TextInputType.text,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                            textEditingController: whatsapp,
                            hint: 'رقم الوتس اب',
                            inputtype: TextInputType.phone,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),

                          mywidget(
                            textEditingController: address,
                            hint: 'العنوان',
                            inputtype: TextInputType.text,
                          ),
                          SizedBox(
                            height: high * .01,
                          ),

                          mywidget(
                            textEditingController: address_tr,
                            hint: 'العنوان بلتركي',
                            inputtype: TextInputType.text,
                          ),

                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                              textEditingController: facebook,
                              inputtype: TextInputType.text,
                              hint: 'ﺭﺍﺑﻂ ﺍﻟﻔﻴﺲ'),
                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                              textEditingController: twiter,
                              inputtype: TextInputType.text,
                              hint: 'ﺭﺍﺑﻂ ﺍﻟﺘﻮﻳﺘﺮ'),
                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                              textEditingController: insta,
                              inputtype: TextInputType.text,
                              hint: 'ﺭﺍﺑﻂ ﺍﻻﻧﺴﺠﺮﺍﻡ'),
                          SizedBox(
                            height: high * .01,
                          ),
                          mywidget(
                              textEditingController: dlivery,
                              inputtype: TextInputType.text,
                              hint: 'ﺧﺪﻣﺔ ﺍﻟﺪﻟﻴﻔﺮﻱ'),
                          SizedBox(
                            height: high * .01,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            controller: addersinmap,
                            style: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                            decoration: InputDecoration(
                              labelText: 'عنوان علي الخريطه',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: hexToColor('#00abeb'), width: 2),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              hintText: 'عنوان علي الخريطه',
                              hintStyle: TextStyle(
                                fontFamily: 'Arbf',
                                color: hexToColor('#ed1c6f'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: high * .01,
                          ),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                label: Text(' الموقع الحالي'),
                                icon: Icon(Icons.location_on_sharp),
                                onPressed: () {
                                  getloc();
                                },
                              ),
                              ElevatedButton.icon(
                                label: Text('لضغط علي الخريطه'),
                                icon: Icon(Icons.location_on_sharp),
                                onPressed: () {
                                  getloc();
                                },
                              )
                            ],
                          ),
                          senddata
                              ? CircularProgressIndicator()
                              : GestureDetector(
                                  onTap: () {
                                    senddata = true;
                                    setState(() {});
                                    _allNetworking
                                        .edit_profile(
                                      token_id: box.read('token'),
                                      name_ar: title.text,
                                      address_tr: address_tr.text,
                                      name_tr: name_tr.text,
                                      description_tr: des_tr.text,
                                      name_en: titlen_en.text,
                                      phone: phone.text,
                                      whatsapp: whatsapp.text,
                                      address: address.text,
                                      floar_num: bilednumber.text,
                                      description: description.text,
                                      description_en: description_en.text,
                                      phone_second: phone2.text,
                                      phone_third: phone3.text,
                                      main_img: _image,
                                      password: password.text,
                                      location: addersinmap.text,
                                      instagram: insta.text,
                                      twitter: twiter.text,
                                      facebook: facebook.text,
                                      website: website.text,
                                      email: email.text,
                                      lat: _locationtosend.latitude,

                                      //setcaruntloction
                                      // _locationData != null
                                      //     ? _locationData.latitude
                                      //     : null,
                                      lag: _locationtosend.longitude,

                                      // setcaruntloction
                                      // _locationData != null
                                      //     ? _locationData.latitude
                                      //     : null,
                                    )
                                        .then((value) {
                                      Get.snackbar('', value.statusMessage);

                                      senddata = false;
                                      setState(() {});
                                    });
                                  },
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
                                          borderRadius:
                                              BorderRadius.circular(40.0))),
                                ),
                          // SizedBox(
                          //   height: high * .01,
                          // ),
                          // CheckboxListTile(
                          //   title: Text("تغير الموقع الحالي الي موقع جديد"),
                          //   value: setcaruntloction,
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       setcaruntloction = newValue;
                          //     });
                          //   },
                          //   controlAffinity: ListTileControlAffinity
                          //       .leading, //  <-- leading Checkbox
                          // ),
                          SizedBox(
                            height: high * .01,
                          ),
                          Container(
                            height: high * .3,
                            child: Center(
                              child: _kGooglePlex == null
                                  ? CircularProgressIndicator()
                                  : GoogleMap(
                                      mapType: MapType.normal,
                                      onTap: (mylocation) {
                                        _locationtosend = LatLng(
                                            mylocation.latitude,
                                            mylocation.longitude);
                                        print(mylocation);
                                      },
                                      initialCameraPosition: _kGooglePlex,
                                      zoomGesturesEnabled: true,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _controller.complete(controller);
                                      },
                                      markers: Set<Marker>.of(_markers),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }

  Widget mywidget(
      {hint, inputtype, TextEditingController textEditingController}) {
    return TextFormField(
      keyboardType: inputtype,
      controller: textEditingController,
      textAlign: TextAlign.center,
      maxLines: null,
      style: TextStyle(
        fontFamily: 'Arbf',
        color: hexToColor('#ed1c6f'),
      ),
      decoration: InputDecoration(
        labelText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: hexToColor('#00abeb'), width: 2),
          borderRadius: BorderRadius.circular(40.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: hexToColor('#00abeb'), width: 2),
          borderRadius: BorderRadius.circular(40.0),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'Arbf',
          color: hexToColor('#ed1c6f'),
        ),
      ),
    );
  }
}
