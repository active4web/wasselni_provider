import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/jsondata/get_current_orders_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_order_details_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:map_launcher/map_launcher.dart';

import 'login.dart';
import 'mapForOlder.dart';

class Get_current_orders extends StatefulWidget {
  @override
  _Get_current_ordersState createState() => _Get_current_ordersState();
}

class _Get_current_ordersState extends State<Get_current_orders> {
  final box = GetStorage();
  String? token;
  AllNetworking _allNetworking = AllNetworking();

  @override
  void initState() {
    super.initState();
    token = box.read('token');
  }

  List<List<Widget>> list = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        top: true,
        child: Scaffold(
          body: token != null
              ? StreamBuilder<Get_current_orders_json?>(
                  stream: _allNetworking
                      .get_current_orders(token_id: token)
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.result!.allOrders!.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data!.result?.allOrders?.length,
                            itemBuilder: (context, pos) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  // _allNetworking
                                                  //     .update_order(token_id: token, id_order: snapshot.data.result.allOrders[pos].idOrder.toString(), key_action: 2)
                                                  //     .then((value) {
                                                  //   setState(() {});
                                                  //   // Get.snackbar('',
                                                  //   //     value.);
                                                  // });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      'جاري تجهيز الطلب',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18)),
                                                )),
                                            GestureDetector(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    _allNetworking
                                                        .update_order(
                                                            token_id: token,
                                                            id_order: snapshot
                                                                .data
                                                                ?.result
                                                                ?.allOrders![
                                                                    pos]
                                                                .idOrder
                                                                .toString(),
                                                            key_action: 2)
                                                        .then((value) {
                                                      setState(() {});
                                                      // Get.snackbar('',
                                                      //     value.);
                                                    });
                                                  },
                                                  child: Text('انهاء الطلب',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18))),
                                            ))
                                            // GestureDetector(
                                            //     onTap: () {
                                            //       _allNetworking
                                            //           .update_order(token_id: token, id_order: snapshot.data.result.allOrders[pos].idOrder.toString(), key_action: 3)
                                            //           .then((value) {
                                            //         setState(() {});
                                            //         // Get.snackbar('',
                                            //         //     value.);
                                            //       });
                                            //     },
                                            //     child: Text('جاري توصيل الطلب',
                                            //         style: TextStyle(
                                            //             color:
                                            //             Colors.white,
                                            //             fontWeight:
                                            //             FontWeight
                                            //                 .bold,fontSize:18 )))
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'كود الطلب',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(snapshot.data?.result
                                                    ?.allOrders?[pos].idOrder
                                                    .toString() ??
                                                ''),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'تكلفة الشحن',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(snapshot
                                                    .data!
                                                    .result!
                                                    .allOrders![pos]
                                                    .shippingCharges!
                                                    .trim()
                                                    .isEmpty
                                                ? ''
                                                : snapshot
                                                        .data!
                                                        .result!
                                                        .allOrders![pos]
                                                        .shippingCharges! +
                                                    " " +
                                                    snapshot
                                                        .data!
                                                        .result!
                                                        .allOrders![pos]
                                                        .currencyName!),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'اجمالي المنتجات',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(snapshot
                                                    .data
                                                    ?.result
                                                    ?.allOrders?[pos]
                                                    .totalProduct ??
                                                ''),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'تاريخ الطلب : ',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(snapshot.data?.result
                                                    ?.allOrders?[pos].date ??
                                                ''),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'التكلفة الكلية : ',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(snapshot
                                                    .data!
                                                    .result!
                                                    .allOrders![pos]
                                                    .totalPrice! +
                                                " " +
                                                snapshot
                                                    .data!
                                                    .result!
                                                    .allOrders![pos]
                                                    .currencyName!),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: size.width * .7,
                                        height: 1,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        height: size.height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'الاسم : ',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(snapshot
                                                    .data
                                                    ?.result
                                                    ?.allOrders?[pos]
                                                    .fullname ??
                                                ''),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'التليفون : ',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(snapshot.data?.result
                                                    ?.allOrders?[pos].phone ??
                                                ''),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'العنوان : ',
                                              maxLines: 2,
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(snapshot.data?.result
                                                    ?.allOrders?[pos].address ??
                                                ''),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'العنوان البديل: ',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Container(
                                              child: Text(snapshot
                                                      .data
                                                      ?.result
                                                      ?.allOrders?[pos]
                                                      .antherAddress ??
                                                  ''),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              'اسم المدينه : ',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(snapshot
                                                    .data
                                                    ?.result
                                                    ?.allOrders?[pos]
                                                    .cityName ??
                                                ''),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          // Get.to(MapForOlder(
                                          //   lat: double.parse(snapshot.data
                                          //       .result.allOrders[pos].lat),
                                          //   lag: double.parse(snapshot.data
                                          //       .result.allOrders[pos].lag),
                                          // ));
                                          final availableMaps =
                                              await MapLauncher.installedMaps;
                                          print(availableMaps);
                                          if (await MapLauncher.isMapAvailable(
                                                  MapType.google) ??
                                              false) {
                                            await MapLauncher.showMarker(
                                                mapType: MapType.google,
                                                coords: Coords(
                                                  double.parse(snapshot
                                                          .data
                                                          ?.result
                                                          ?.allOrders?[pos]
                                                          .lat ??
                                                      ''),
                                                  double.parse(snapshot
                                                          .data
                                                          ?.result
                                                          ?.allOrders?[pos]
                                                          .lag ??
                                                      ''),
                                                ),
                                                title: '');
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Text(
                                                'الموقع علي الخريطه : ',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.location_on),
                                            )
                                          ],
                                        ),
                                      ),
                                      FutureBuilder<Get_order_details_json?>(
                                          future:
                                              _allNetworking.get_order_details(
                                            id_order: snapshot.data?.result
                                                ?.allOrders?[pos].idOrder,
                                            token_id: token,
                                          ),
                                          builder: (context, snapshot) {
                                            print("snapshot.data");
                                            print(snapshot.data);
                                            print("snapshot.data");
                                            List<Widget> list = [];
                                            if (snapshot.hasData) {
                                              for (int i = 0;
                                                  i <
                                                      snapshot.data!.result!
                                                          .allProducts!.length;
                                                  i++) {
                                                list.add(Productsiteem(
                                                    size: size,
                                                    offers: snapshot
                                                        .data!
                                                        .result!
                                                        .allProducts![i]));
                                              }
                                              return ExpansionTile(
                                                title: Text('تفاصيل'),
                                                children: list,
                                              );
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                          })
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: Text('لا يوجد طلبات'),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
              : Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(LoginScr());
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      child: Center(
                        child: Text('savep',
                            style: TextStyle(
                                fontFamily: 'Arbf',
                                color: Colors.white,
                                fontSize: 23)),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(40.0)),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget Productsiteem({AllProducts? offers, size}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: size.height * .2,
        width: size.width * .9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                offers?.image ?? '',
                width: size.width * .3,
                height: size.height * .15,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 2),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: size.height * .1,
                      width: size.width * .3,
                      child: Text(offers?.productName ?? ''),
                    ),
                  ),
                  Text("${offers?.price.toString()}  ${offers?.currencyName}")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(offers?.quantity.toString() ?? '',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
