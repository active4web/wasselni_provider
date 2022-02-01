import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/preparation_points_json.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class PointScr extends StatefulWidget {
  @override
  _PointScrState createState() => _PointScrState();
}

class _PointScrState extends State<PointScr> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  TextEditingController _pointsController = TextEditingController();
  TextEditingController _pointsForQrCodeController = TextEditingController();
  bool save = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نقاطي'),
        centerTitle: true,
      ),
      body: StreamBuilder<Preparation_points_json>(
          stream: _allNetworking
              .preparation_points(token_id: box.read('token'))
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _pointsController.text = snapshot.data.result.totalPoints;
              _pointsForQrCodeController.text =
                  snapshot.data.result.totalPointsQr;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   controller: _pointsController,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontFamily: 'Arbf',
                  //     color: hexToColor('#ed1c6f'),
                  //   ),
                  //   decoration: InputDecoration(
                  //     labelText: "عدد النقاط لكل طلب",
                  //     enabledBorder: OutlineInputBorder(
                  //       borderSide:
                  //           BorderSide(color: hexToColor('#00abeb'), width: 2),
                  //       borderRadius: BorderRadius.circular(40.0),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderSide:
                  //           BorderSide(color: hexToColor('#00abeb'), width: 2),
                  //       borderRadius: BorderRadius.circular(40.0),
                  //     ),
                  //     hintText: 'عدد النقاط لكل طلب',
                  //     hintStyle: TextStyle(
                  //       fontFamily: 'Arbf',
                  //       color: hexToColor('#ed1c6f'),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  TextFormField(
                    controller: _pointsForQrCodeController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                    decoration: InputDecoration(
                      labelText: "عدد النقاط لكل مسح",
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#00abeb'), width: 2),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      hintText: 'عدد النقاط لكل مسح',
                      hintStyle: TextStyle(
                        fontFamily: 'Arbf',
                        color: hexToColor('#ed1c6f'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  save
                      ? CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              save = true;
                            });
                            _allNetworking
                                .edit_points(
                                    token_id: box.read('token'),
                                    // total_points: _pointsController.text,
                                    total_points_qr:
                                        _pointsForQrCodeController.text)
                                .then((value) {
                              setState(() {
                                save = false;
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("تم التعديل"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("تم"),
                                      )
                                    ],
                                  ),
                                );
                              });
                            });

                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * .07,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Center(
                              child: Text("حفظ",
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
                                borderRadius: BorderRadius.circular(40.0)),
                          ),
                        ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
