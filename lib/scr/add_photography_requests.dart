import 'package:commercial_app/myWidget/myDrawer.dart';
import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/tickets_types_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Add_Photography_Requests extends StatefulWidget {
  @override
  _Add_Photography_RequestsState createState() => _Add_Photography_RequestsState();
}

class _Add_Photography_RequestsState extends State<Add_Photography_Requests> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String? data = '';
  String? title = '';
  String? token;
  bool? senddata = false;
  @override
  void initState() {
    super.initState();
    token = box.read('token');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mydrawer(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text('طلب تصميم وتصوير'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: Text(
                  "انشاء طلب تصميم وتصوير",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
      SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: hexToColor('#00abeb'),
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'عنوان',
                    ),
                    onChanged: (st) {
                      title = st;
                    },
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: hexToColor('#00abeb'),
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: 'الرسالة'),
                        onChanged: (st) {
                          data = st;
                        },
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.right,
                        maxLines: null,
                        style: TextStyle(
                          fontFamily: 'Arbf',
                          color: hexToColor('#ed1c6f'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              senddata!
                  ? CircularProgressIndicator()
                  : GestureDetector(
                onTap: () {
                  if (!data!.trim().isEmpty && !title!.trim().isEmpty) {
                    senddata = true;
                    setState(() {});
                    _allNetworking
                        .add_photography_requests(
                        token_id: token,
                        title: title,
                        content: data)
                        .then((value) {
                      senddata = false;
                      Get.dialog(
                        AlertDialog(
                          title: Text(''),
                          content: Text(value?.data['message']),
                          actions: <Widget>[
                            TextButton(
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
                      setState(() {});
                    });
                  }
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Text('ﺍﺭﺳﺎﻝ',
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
                        borderRadius: BorderRadius.circular(40.0))),
              )
            ],
          )),
    );
  }
}
