import 'dart:io';

import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/scr/branch.dart';
import 'package:commercial_app/scr/contactwithmanager.dart';
import 'package:commercial_app/scr/login.dart';
import 'package:commercial_app/scr/myprofile.dart';
import 'package:commercial_app/scr/notificationScr.dart';
import 'package:commercial_app/scr/pointScr.dart';
import 'package:commercial_app/scr/qrClient.dart';
import 'package:commercial_app/scr/qrPoints.dart';
import 'package:commercial_app/scr/remembering.dart';
import 'package:commercial_app/scr/tags_screen.dart';
import 'package:commercial_app/scr/ticketdetails.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';

Widget mydrawer(context) {
  AllNetworking _allNetworking = AllNetworking();
  String phone;
  String point;
  final box = GetStorage();
  return Drawer(
    child: Container(
      padding: EdgeInsets.only(right: 50, left: 50),
      color: Colors.blue,
      child: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          ListTile(
            title: Text(box.read('name'),
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {},
          ),
          Container(
            color: Colors.white,
            height: 2,
          ),
          ListTile(
            title: Text('حذف النقاط',
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: Text(''),
                  content: Column(
                    children: [
                      TextFormField(
                        onChanged: (s) {
                          phone = s;
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontFamily: 'Arbf',
                          color: hexToColor('#ed1c6f'),
                        ),
                        decoration: InputDecoration(
                          labelText: 'رقم الهاتف',
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
                          hintStyle: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (s) {
                          point = s;
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Arbf',
                          color: hexToColor('#ed1c6f'),
                        ),
                        decoration: InputDecoration(
                          labelText: 'عدد النقاط',
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
                          hintStyle: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                        ),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("CLOSE"),
                      onPressed: () {
                        print(phone);
                        Get.back();
                      },
                    ),
                    FlatButton(
                      child: Text("تنفيذ"),
                      onPressed: () {
                        print(phone);
                        _allNetworking
                            .empty_points(
                                total_points: point,
                                phone: phone,
                                token_id: box.read('token'))
                            .then((value) {
                          Get.dialog(
                            AlertDialog(
                              title: Text(''),
                              content: Text(value.data['message']),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("CLOSE"),
                                  onPressed: () {
                                    Get.back();
                                    Get.back();
                                  },
                                )
                              ],
                            ),
                            barrierDismissible: false,
                          );
                        });
                      },
                    )
                  ],
                ),
                barrierDismissible: false,
              );

              //_allNetworking.empty_points(total_points: null, phone: null)
            },
          ),
          Container(
            color: Colors.white,
            height: 2,
          ),
          ListTile(
            title: Text("الكلمات البحثية",
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {
              // Get.to(Profilee(),transition: Transition.cupertino);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TagsScreen()),
              );
            },
          ),
          Container(
            color: Colors.white,
            height: 2,
          ),
          ListTile(
            title: Text("ﺑﺮﻭﻓﺎﻳﻞ",
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {
              // Get.to(Profilee(),transition: Transition.cupertino);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profilee()),
              );
            },
          ),
          Container(
            color: Colors.white,
            height: 2,
          ),
          // ListTile(
          //   title: Text("ﺍﻟﻔﺮﻭﻉ",
          //       style: TextStyle(
          //           fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Branch()),
          //     );
          //     // Get.to(Branch(),transition: Transition.cupertino);
          //   },
          // ),
          // Container(
          //   color: Colors.white,
          //   height: 2,
          // ),
          ListTile(
            title: Text("ﺗﻨﺒﻴﻬﺎﺕ",
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScr()),
              );
              //     Get.to(NotificationScr(),transition: Transition.cupertino);
            },
          ),
          Container(
            color: Colors.white,
            height: 2,
          ),
          ListTile(
            title: Text("ﻛﻮﺑﻮﻧﺎﺕ ﺧﺼﻢ",
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRClient()),
              );
            },
          ),
          Container(
            color: Colors.white,
            height: 2,
          ),
          ListTile(
            title: Text("نقاط المسح",
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRPoints()),
              );
            },
          ),
          Container(
            color: Colors.white,
            height: 2,
          ),
          ListTile(
            title: Text("ﺗﻮﺍﺻﻞ ﻣﻊ ﺍﻻﺩﺍﺭﺓ",
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Remembering()),
              );

              //Get.to(Remembering(),);
            },
          ),
          Container(
            color: Colors.white,
            height: 2,
          ),
          ListTile(
            title: Text("النقاط",
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PointScr()),
              );

              //Get.to(Remembering(),);
            },
          ),
          Container(
            color: Colors.white,
            height: 2,
          ),
          ListTile(
            title: Text("ﺗﺴﺠﻴﻞ ﺍﻟﺨﺮﻭﺝ",
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 25)),
            onTap: () {
              _allNetworking
                  .logout(
                      token_id: box.read('token'),
                      firebase_token: box.read('firebase_token'))
                  .then((value) async {
                await box.remove(
                  'phone',
                );
                await box.remove('firebase_token');
                await box.remove('name');

                await box.remove('token');
                await box.remove('email');
                await box.remove('id');
                Navigator.pushAndRemoveUntil(
                    context,
                    new MaterialPageRoute(builder: (context) => LoginScr()),
                    (Route<dynamic> route) => false);
              });
            },
          )
        ],
      ),
    ),
    elevation: 8,
  );
}
