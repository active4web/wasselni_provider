import 'dart:async';
import "dart:io";
import "dart:convert";
import 'dart:typed_data';
import 'package:commercial_app/myWidget/customDialog.dart';
import 'package:commercial_app/myWidget/myDrawer.dart';
import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/scr/offer.dart';
import 'package:commercial_app/scr/product.dart';
import 'package:commercial_app/scr/qrDetailsPoints.dart';
import 'package:commercial_app/scr/qrPoints.dart';
import 'package:commercial_app/scr/rateTitle.dart';
import 'package:commercial_app/scr/visitorCount.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/get_home_json.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'MyOrder.dart';
import 'QRread.dart';
import 'add_photography_requests.dart';
import 'addnewpranch.dart';
import 'gate_list_location.dart';
import 'get_all_orderSCr.dart';
import 'get_all_visitor_pointsSCR.dart';
import 'notificationScr.dart';

class Statisticss extends StatefulWidget {
  @override
  _StatisticssState createState() => _StatisticssState();
}

class _StatisticssState extends State<Statisticss> {
  Uint8List bytes = Uint8List(0);
  String _qrStringgnra = '';
  int _selectedIndex = 0;
  String token;
  bool serch = false;
  bool qrgnratt = false;
  bool activediscount = false;
  final box = GetStorage();
  AllNetworking _allNetworking = AllNetworking();
  File _imge;
  @override
  void initState() {
    super.initState();
    token = box.read('token');
    _requestPermission();
    getMessage();
  }

  void getMessage() async {
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage?.data != null) {
      if (initialMessage?.data['type'] == '1') {
        Get.to(() => Gate_list_location());
      }
      if (initialMessage?.data['type'] == '2') {
        Get.to(() => MyOrder());
      }
      if (initialMessage?.data['type'] == '3') {
        Get.to(() => NotificationScr());
      }
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == '1') {
        Get.to(() => Gate_list_location());
      }
      if (message.data['type'] == '2') {
        Get.to(() => MyOrder());
      }
      if (message.data['type'] == '3') {
        Get.to(() => NotificationScr());
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final high = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var color = hexToColor('#00abeb');
    List bottomitem = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'الرئيسية',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart_outlined,
        ),
        label: 'ﻣﻨﺘﺠﺎﺕ ﺍﻟﻔﺮﻉ',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'ﺍﻟﻌﺮﻭﺽ',
      ),
    ];
    return Scaffold(
      key: _scaffoldKey,
      drawer: mydrawer(context),
      body: swithscren(pos: _selectedIndex, width: width, high: high),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: hexToColor('#00abeb'),
        items: bottomitem,
        currentIndex: _selectedIndex,
        selectedItemColor: color, // Colors.amber[800],
        onTap: (i) {
          _selectedIndex = i;
          swithscren(pos: i, width: width, high: high);
          setState(() {});
        },
      ),
    );

    //swithscren(high: high, width: width, pos: _selectedIndex);
  }

  Widget swithscren({pos, high, width}) {
    if (pos == 0) {
      return StreamBuilder<Get_home_json>(
          stream:
              _allNetworking.get_home(token_id: token, lang: 'ar').asStream(),
          builder: (context, snapshot) {
            print(snapshot.data);

            if (snapshot.hasData) {
              Result data = snapshot.data.result;
              if (data.type == 0) {
                activediscount = false;
              } else {
                activediscount = true;
              }

              return Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black12,
                    actions: [],
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        GestureDetector(
                          onTap: () async {
                            // set up the buttons
                            Widget cancelButton = FlatButton(
                              child: Text("الفاء"),
                              onPressed: () {
                                _allNetworking
                                    .create_coupon(token_id: token, type: 0)
                                    .then((value) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                });
                                setState(() {});
                              },
                            );
                            Widget continueButton = FlatButton(
                              child: Text("تنفيذ"),
                              onPressed: () {
                                _allNetworking
                                    .create_coupon(token_id: token, type: 1)
                                    .then((value) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                });
                                setState(() {});
                              },
                            );

                            if (!_textEditingController.text.trim().isEmpty) {
                              setState(() {
                                serch = true;
                              });
                              _allNetworking
                                  .check_coupon(
                                  token_id: token,
                                  coupon: _textEditingController.text)
                                  .then((value) {
                                // set up the AlertDialog
                                print(value.data);
                                if (value.data['status']) {
                                  String user_name =
                                  value.data['data']['user_name'];
                                  String user_phone =
                                  value.data['data']['user_phone'];
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        CustomDialog(
                                          title: "كود الخصم",
                                          description: "رقم الهاتف  $user_phone" +
                                              "\n" +
                                              "اسم المستخدم $user_name",

                                        ),
                                  );
                                } else {
                                  // set up the button
                                  Widget okButton = FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  );

                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("كود الخصم"),
                                    content: Text(value.data['message']),
                                    actions: [
                                      okButton,
                                    ],
                                  );

                                  // show the dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                }

                                setState(() {
                                  _textEditingController.text = "";
                                  serch = false;
                                });
                              });
                            }
                          },
                          child: serch
                              ? CircularProgressIndicator()
                              : Container(
                            color: Colors.white,
                            child: Icon(
                              Icons.apps_outlined,
                              color: hexToColor('#00abeb'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: TextField(
                          controller: _textEditingController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'بحث بالكود او رقم الهاتف '),
                        )),

                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!_textEditingController.text.trim().isEmpty) {
                              // setState(() {
                              //   serch = true;
                              // });
                              // _allNetworking
                              //     .check_phone(
                              //         token_id: token,
                              //         phone: _textEditingController.text)
                              //     .then((value) {
                              //   // set up the AlertDialog
                              //   print(value.data);
                              //   print(value.data['status']);
                              //   if (value.data['status']) {
                              //     String user_name =
                              //         value.data['data']['user_name'];
                              //     String user_phone =
                              //         value.data['data']['user_phone'];
                              //     showDialog(
                              //       context: context,
                              //       barrierDismissible: false,
                              //       builder: (BuildContext context) =>
                              //           CustomDialog(
                              //         Text2:
                              //             "عدد النقاط ${value.data['data']['user_total_points']}",
                              //         title: "",
                              //         function: () {
                              //           Navigator.of(context).pop();
                              //         },
                              //         buttonText2: "تنفيذ",
                              //         description: "رقم الهاتف  $user_phone" +
                              //             "\n" +
                              //             "اسم المستخدم $user_name",
                              //         buttonText: "الفاء",
                              //         phone: true,
                              //       ),
                              //     );
                              //   } else {
                              //     // set up the button
                              //     Widget okButton = FlatButton(
                              //       child: Text("OK"),
                              //       onPressed: () {
                              //         Navigator.of(context).pop();
                              //       },
                              //     );
                              //
                              //     // set up the AlertDialog
                              //     AlertDialog alert = AlertDialog(
                              //       title: Text("كود الخصم"),
                              //       content: Text(value.data['message']),
                              //       actions: [
                              //         okButton,
                              //       ],
                              //     );
                              //
                              //     // show the dialog
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return alert;
                              //       },
                              //     );
                              //   }
                              //
                              //   setState(() {
                              //     _textEditingController.text = "";
                              //     serch = false;
                              //   });
                              // });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => QRDetailsPoints(phoneNumber: _textEditingController.text.trim(),),));
                            }
                          },
                          child: serch
                              ? CircularProgressIndicator()
                              : Container(
                                  color: Colors.white,
                                  child: Icon(
                                    Icons.phone,
                                    color: hexToColor('#00abeb'),
                                  ),
                                ),
                        ),

                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: high * 0.04,
                          width: high * 0.05,
                          child: Image.asset(
                            'assets/images/log.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  drawer: mydrawer(context),
                  body: SafeArea(
                    top: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // serchWidget(width: width, high: high, fun: fun),
                            SizedBox(
                              height: high * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Add_Photography_Requests()),
                                    );
                                  },
                                  child: item_home_list(
                                      icon: 'assets/images/cam.png',
                                      keyupdata: 0,
                                      dat: false,
                                      number: "",
                                      //data.totalProduct.toString(),
                                      width: width,
                                      name: "طلب تصميم وتصوير")),
                            ),

                            if (data.showOrder == "1")
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyOrder()),
                                      );
                                    },
                                    child: item_home_list(
                                        icon: 'assets/images/shopping_cart.png',
                                        keyupdata: 0,
                                        dat: false,
                                        width: width,
                                        number: data.totalOrders.toString(),
                                        name: "ﻋﺪﺩ ﺍﻟﻄﻠﺒﺎﺕ ")),
                              ),
                            if (data.locationDisplay == "1")
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Gate_list_location()),
                                      );
                                    },
                                    child: item_home_list(
                                        icon: 'assets/images/Help.png',
                                        keyupdata: 0,
                                        dat: false,
                                        number: "",
                                        //data.totalProduct.toString(),
                                        width: width,
                                        name: data.locationTitle)),
                              ),
                            if (data.showRate == "1")
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RateTitle()),
                                      );
                                    },
                                    child: item_home_list(
                                        icon: 'assets/images/rat.png',
                                        keyupdata: 0,
                                        dat: false,
                                        number: "",
                                        //data.totalProduct.toString(),
                                        width: width,
                                        name: data.rateTitle)),
                              ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VisitorCount(token)),
                                    );
                                  },
                                  child: item_home_list(
                                      icon: 'assets/images/community.png',
                                      keyupdata: 0,
                                      dat: false,
                                      width: width,
                                      number: data.totalViews.toString(),
                                      name: "عدد الزوار")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: GestureDetector(
                                  onTap: () {},
                                  child: item_home_list(
                                      icon: 'assets/images/calendar.png',
                                      keyupdata: 0,
                                      dat: true,
                                      width: width,
                                      number: data.startDate,
                                      number2: data.endDate,
                                      name: "ﺗﺎﺭﻳﺦ ﺍﻻﺷﺘﺮﺍﻙ")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 1;
                                    });
                                  },
                                  child: item_home_list(
                                      icon: 'assets/images/box.png',
                                      keyupdata: 0,
                                      dat: false,
                                      width: width,
                                      number: data.totalProduct.toString(),
                                      name: "ﻋﺪﺩ ﺍﻟﻤﻨﺘﺠﺎﺕ")),
                            ),
                            if (data.pointsDisplay == '1')
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QRPoints()),
                                      );
                                    },
                                    child: item_home_list(
                                        icon: 'assets/images/scoreboard.png',
                                        keyupdata: 0,
                                        dat: false,
                                        width: width,
                                        number: data.totalPoints.toString(),
                                        name: "ﻋﺪﺩ نقاط المستخدمين")),
                              ),
                            if (data.scanDisplay == '1')
                              qrgnratt
                                  ? CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: GestureDetector(
                                          onTap: () async {
                                            int idOfQR = await box.read('id');
                                            await _generateBarCode(
                                                box.read('id').toString());
                                          },
                                          child: item_home_list(
                                              icon: 'assets/images/qr.png',
                                              keyupdata: 0,
                                              dat: false,
                                              width: width,
                                              number:
                                                  "",
                                              name: " انشاء  QR ")),
                                    ),

                            if (data.copounDisplay == '1')
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: GestureDetector(
                                    onTap: () async {
                                      if (activediscount) {
                                        _allNetworking
                                            .create_coupon(
                                                token_id: token, type: 0)
                                            .then((value) {});
                                        setState(() {});
                                      } else {
                                        _allNetworking
                                            .create_coupon(
                                                token_id: token, type: 1)
                                            .then((value) {});
                                        setState(() {});
                                      }
                                    },
                                    child: item_home_list(
                                      icon: 'assets/images/coupon.png',
                                      keyupdata: 0,
                                      dat: false,
                                      width: width,
                                      number: "",
                                      name: activediscount
                                          ? " مفعلة"
                                          : " تفعيل اكواد الخصم ",
                                    )),
                              ),

                            // SizedBox(
                            //   height: high * .02,
                            // ),
                            // GestureDetector(
                            //   onTap: () {
                            //     if (activediscount) {
                            //       _allNetworking
                            //           .create_coupon(token_id: token, type: 0)
                            //           .then((value) {});
                            //       setState(() {});
                            //     } else {
                            //       _allNetworking
                            //           .create_coupon(token_id: token, type: 1)
                            //           .then((value) {});
                            //       setState(() {});
                            //     }
                            //   },
                            //   child: Container(
                            //     height: high * .07,
                            //     width: width * 0.75,
                            //     child: Center(
                            //       child: activediscount
                            //           ? Text(" الغاء  ${data.serviceCoupon}",
                            //               style: TextStyle(
                            //                   fontFamily: 'Arbf',
                            //                   color: Colors.white,
                            //                   fontSize: 25))
                            //           : Text(" تفعيل اكواد الخصم ",
                            //               style: TextStyle(
                            //                   fontFamily: 'Arbf',
                            //                   color: Colors.white,
                            //                   fontSize: 25)),
                            //     ),
                            //     decoration: BoxDecoration(
                            //         color: hexToColor('#00abeb'),
                            //         gradient: new LinearGradient(
                            //             colors: [
                            //               hexToColor('#2358a6'),
                            //               hexToColor('#00abeb')
                            //             ],
                            //             begin: Alignment.centerLeft,
                            //             end: Alignment.centerRight,
                            //             tileMode: TileMode.clamp),
                            //         borderRadius: BorderRadius.circular(40.0)),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    } else if (pos == 1) {
      return ProductScr();
    } else if (pos == 2) {
      return OfferScr();
    }

    return Container();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  Future _generateBarCode(String inputCode) async {
    qrgnratt = true;
    setState(() {});
    Uint8List result = await scanner.generateBarCode(inputCode);
    File.fromRawPath(result);
    print(File.fromRawPath(result)); //_imge=
    FutureOr<dynamic> success =
        await ImageGallerySaver.saveImage(result, quality: 100);
    print(success);
    String imageString = base64Encode(result);
    print(imageString);

    await _allNetworking
        .save_QR(token_id: token, file: imageString)
        .then((value) async {
      print(value.data);

      Get.dialog(
        AlertDialog(
          title: Text(''),
          content: Text("تم حفظ الصوره في مكتبة الصور"),
          actions: <Widget>[
            FlatButton(
              child: Text("CLOSE"),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
        barrierDismissible: false,
      );
    });

    qrgnratt = false;
    setState(() {});
  }

  Widget item_home_list(
      {String name,
      String number,
      String icon,
      width,
      int keyupdata,
      fun,
      number2,
      bool dat}) {
    print("111111111111111111111111111111");
    print(keyupdata);
    print("111111111111111111111111111111");
    return Container(
      width: width,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: keyupdata == 1 ? Colors.blue[100] : Colors.white,
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFF0F0F0),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF4F4F4).withOpacity(0.8),
            offset: Offset(0, 2.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: keyupdata == 1
                ? GestureDetector(
                    onTap: keyupdata == 1 ? fun : null,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                          height: 75,
                          color: Colors.blue,
                          width: 75,
                          child: Center(
                              child: Text(
                                  keyupdata == 1
                                      ? 'تجديد الاشتراك'
                                      : ' تم ارسال الطلب',
                                  style: TextStyle(
                                      fontFamily: 'Arbf',
                                      color: Colors.white,
                                      fontSize: 10)))),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    height: 75,
                    color: Colors.blue,
                    width: 75,
                    child: Image.asset(
                      icon,
                      height: 30,
                      width: 30,
                      color: Colors.white,
                    ),
                  ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 1,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(name,
                    style: TextStyle(
                        fontFamily: 'Arbf', color: Colors.black, fontSize: 18)),
                SizedBox(
                  width: 8,
                ),
                dat
                    ? Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(" من " + number,
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: Colors.blue,
                                    fontSize: 12)),
                            Text(" الي " + number2,
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: Colors.blue,
                                    fontSize: 12)),
                          ],
                        ))
                    : Flexible(
                        child: Text(number,
                            style: TextStyle(
                                fontFamily: 'Arbf',
                                color: Colors.blue,
                                fontSize: 23)),
                      ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
//
// GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// Get_all_order(token)),
// );
// },
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceAround,
// children: [
// Column(
// children: [
// Container(
// width: width * .4,
// height: width * .4,
// color: Colors.deepPurpleAccent,
// child: Center(
// child: Text(
// data.totalSelling.toString(),
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.white,
// fontSize: 25),
// ),
// ),
// ),
// SizedBox(
// height: .01,
// ),
// Text(
// "ﻋﺪﺩ ﺍﻟﻄﻠﺒﺎﺕ ",
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.black,
// fontSize: 25),
// )
// ],
// ),
// GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// VisitorCount(token)),
// );
// },
// child: Column(
// children: [
// Container(
// width: width * .4,
// height: width * .4,
// color: Colors.orange,
// child: Center(
// child: Text(
// data.totalViews.toString(),
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.white,
// fontSize: 25),
// ),
// ),
// ),
// SizedBox(
// height: .01,
// ),
// Text(
// "عدد الزوار",
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.black,
// fontSize: 25),
// )
// ],
// ),
// )
// ],
// ),
// ),
// SizedBox(
// height: high * .02,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Column(
// children: [
// Container(
// width: width * .4,
// height: width * .4,
// color: Colors.blue,
// child: Center(
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.center,
// children: [
// Text(
// data.datePackege ,
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.white,
// fontSize: 25),
// ),
// // Text(
// //   '20-20',
// //   style: TextStyle(
// //       fontFamily: 'Arbf',
// //       color: Colors.white,
// //       fontSize: 25),
// // )
// ],
// ),
// ),
// ),
// SizedBox(
// height: .01,
// ),
// Text(
// "ﺗﺎﺭﻳﺦ ﺍﻻﺷﺘﺮﺍﻙ ",
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.black,
// fontSize: 25),
// )
// ],
// ),
// GestureDetector(
// onTap: () {
// setState(() {
// _selectedIndex = 1;
// });
// },
// child: Column(
// children: [
// Container(
// width: width * .4,
// height: width * .4,
// color: Colors.deepPurple,
// child: Center(
// child: Text(
// data.totalProduct.toString(),
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.white,
// fontSize: 25),
// ),
// ),
// ),
// SizedBox(
// height: .01,
// ),
// Text(
// " ﻋﺪﺩ ﺍﻟﻤﻨﺘﺠﺎﺕ",
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.black,
// fontSize: 25),
// )
// ],
// ),
// )
// ],
// ),
// SizedBox(
// height: high * .02,
// ),
//
//
// GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// Get_all_visitor_points(token)),
// );
// },
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceAround,
// children: [
// Column(
// children: [
// Container(
// width: width * .4,
// height: width * .4,
// color: Colors.deepPurpleAccent,
// child: Center(
// child: Text(
// data.totalPoints.toString(),
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.white,
// fontSize: 25),
// ),
// ),
// ),
// SizedBox(
// height: .01,
// ),
// Text(
// "ﻋﺪﺩ نقاط المستخدمين ",
// style: TextStyle(
// fontFamily: 'Arbf',
// color: Colors.black,
// fontSize: 25),
// )
// ],
// ),
//
// ],
// ),
// ),
