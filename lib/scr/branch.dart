import 'dart:async';

import 'package:commercial_app/myWidget/branclistWidget.dart';
import 'package:commercial_app/myWidget/myDrawer.dart';
import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_branches_JSON.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'addnewpranch.dart';

class Branch extends StatefulWidget {
  @override
  _BranchState createState() => _BranchState();
}

class _BranchState extends State<Branch> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String? token;

  @override
  void initState() {
    super.initState();
    token = box.read('token');
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
          title: Text('الفروع'),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () async{
                final value = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddnewPranch()),

                );
                setState(() {

                });
             //   Get.to(AddnewPranch(), transition: Transition.leftToRight);
              },
              child: Container(
                height: high * .07,
                width: width * 0.5,
                child: Center(
                  child: Text("اضافه فرع جديد",
                      style: TextStyle(
                          fontFamily: 'Arbf',
                          color: Colors.white,
                          fontSize: 25)),
                ),
                decoration: BoxDecoration(
                    color: hexToColor('#00abeb'),
                    gradient: new LinearGradient(
                        colors: [hexToColor('#2358a6'), hexToColor('#00abeb')],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(40.0)),
              ),
            ),
            Expanded(
              flex: 1,
              child: StreamBuilder<Get_all_branches_JSON?>(
                  stream: _allNetworking.get_all_branches(token_id: token).asStream(),
                  builder: (context, snapshot) {
                    // .
                    if (snapshot.hasData) {
                      return ListView.builder(
                          padding: EdgeInsets.all(4),
                          itemCount: snapshot.data?.result?.allProducts?.length,
                          itemBuilder: (context, pos) {
                            return branchItemWidg(

                                high: high,context: context,
                                width: width,
                                branch: snapshot.data?.result?.allProducts?[pos],
                                fundel: () {
                                  _allNetworking
                                      .delete_branch(
                                          token_id: token,
                                          id_branch: snapshot.data?.result
                                              ?.allProducts?[pos].prodId)
                                      .then((value) {
                                        print(value);
                                        setState(() {

                                        });
                                  });
                                });
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
