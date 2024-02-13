import 'package:commercial_app/myWidget/listQrClientWidget.dart';
import 'package:commercial_app/myWidget/myDrawer.dart';
import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_user_coupons_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' as intl;

class QRDetailsPoints extends StatefulWidget {
   final String? phoneNumber;
  const QRDetailsPoints({Key? key, this.phoneNumber}) : super(key: key);
  @override
  _QRDetailsPointsState createState() => _QRDetailsPointsState();
}

class _QRDetailsPointsState extends State<QRDetailsPoints> {
  AllNetworking _allNetworking = AllNetworking();
  int sizelist = 0;
  int limit = 1000;
  final box = GetStorage();
  String f = "";
  int? sum;
  ScrollController? _scrollController;
  TextEditingController _startDate=TextEditingController();
  TextEditingController _endDate=TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: mydrawer(context),
        appBar: AppBar(
          centerTitle: true,
          title: Text('نقاط المسح'.tr,
              style: TextStyle(
                  fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
        ),
        body: FutureBuilder<Get_all_user_coupons_json>(
            future: _allNetworking
                .check_phone(token_id: box.read('token'),phone: widget.phoneNumber),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AllVisitoe> dat = snapshot.data?.result?.allVisitoe??[];
                List<AllVisitoe> data = [];
                dat.forEach((element) {
                  if (element.userPhone!.contains(f)) {
                    data.add(element);
                  }
                });
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                      onChanged: (v) {
                                        f = v;
                                        setState(() {});
                                      },
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: 'البحث برقم التلفون',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Arbf',
                                          color: hexToColor('#ed1c6f'),
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //      Expanded(
                    //        child: TextFormField(
                    //          controller: _startDate,
                    //         textAlign: TextAlign.center,
                    //         style:   TextStyle(
                    //           fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                    //         decoration: InputDecoration(
                    //           contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    //           labelText: "من تاريخ",
                    //           isDense: true,
                    //           enabledBorder: OutlineInputBorder(
                    //             borderSide: BorderSide(color: hexToColor('#00abeb'), width: 2),
                    //             borderRadius: BorderRadius.circular(40.0),
                    //           ),
                    //           border: OutlineInputBorder(
                    //             borderSide: BorderSide(color: hexToColor('#00abeb'), width: 2),
                    //             borderRadius: BorderRadius.circular(40.0),
                    //           ),
                    //           hintText: 'من تاريخ',
                    //           suffix: InkWell(
                    //               onTap: ()async {
                    //                 var result = await showDatePicker(context: context, initialDate: DateTime(2022), firstDate: DateTime(2022), lastDate: DateTime(2050));
                    //                 _startDate.text = intl.DateFormat("yyyy-MM-dd").format(result);
                    //               },
                    //               child: Icon(Icons.calendar_today)),
                    //
                    //           hintStyle:
                    //           TextStyle(
                    //             fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                    //         ),
                    //     ),
                    //      ),
                    //     SizedBox(width: 10,),
                    //     Expanded(
                    //       child: TextFormField(
                    //         controller: _endDate,
                    //         textAlign: TextAlign.center,
                    //         style:   TextStyle(
                    //           fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                    //         decoration: InputDecoration(
                    //           contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    //           isDense: true,
                    //           labelText: "الي تاريخ",
                    //           enabledBorder: OutlineInputBorder(
                    //             borderSide: BorderSide(color: hexToColor('#00abeb'), width: 2),
                    //             borderRadius: BorderRadius.circular(40.0),
                    //           ),
                    //           border: OutlineInputBorder(
                    //             borderSide: BorderSide(color: hexToColor('#00abeb'), width: 2),
                    //             borderRadius: BorderRadius.circular(40.0),
                    //           ),
                    //           hintText: 'الي تاريخ',
                    //           suffix: InkWell(
                    //             onTap: ()async {
                    //               var result = await showDatePicker(context: context, initialDate: DateTime(2022), firstDate: DateTime(2022), lastDate: DateTime(2050));
                    //               _endDate.text = intl.DateFormat("yyyy-MM-dd").format(result);
                    //             },
                    //               child: Icon(Icons.calendar_today)),
                    //           hintStyle:
                    //           TextStyle(
                    //             fontFamily: 'Arbf', color: hexToColor('#ed1c6f'), ),
                    //         ),
                    //       ),
                    //     ),
                    //     IconButton(onPressed: ()async{
                    //       var result = await _allNetworking
                    //           .filter_points(
                    //           token_id: box.read('token'),startDate: _startDate.text,endDate: _endDate.text,limit: limit,page_number: 0);
                    //
                    //       data = result.result.allVisitoe;
                    //       setState(() {});
                    //
                    //     }, icon: Icon(Icons.filter_alt_outlined))
                    //   ],
                    // ),
                    Text("عدد النقاط : ${snapshot.data?.result?.totalPoints}"),
                    Expanded(
                      child: ListView.builder(
                          itemCount:  f.trim().isEmpty
                              ?snapshot.data?.result?.allVisitoe?.length:data.length,
                          controller: _scrollController,
                          itemBuilder: (context, pos) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Card(
                                elevation: 8,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        f.trim().isEmpty
                                            ? 'اسم العميل : ${snapshot.data?.result?.allVisitoe?[pos].userName}'
                                            : 'اسم العميل : ${data[pos].userName}',
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        f.trim().isEmpty
                                            ? 'رقم التلفون : ${snapshot.data?.result?.allVisitoe?[pos].userPhone}'
                                            : 'رقم التلفون : ${data[pos].userPhone}',
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        f.trim().isEmpty
                                            ?  'نقاط المسح : ${snapshot.data?.result?.allVisitoe?[pos].serviceCoupon}': 'كود الخصم : ${data[pos].serviceCoupon}',
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        f.trim().isEmpty
                                            ?  'تاريخ المسح : ${snapshot.data?.result?.allVisitoe?[pos].date}':'تاريخ الاستخدام : ${data[pos].date}',
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: GestureDetector(
                                              onTap: () {
                                                _allNetworking
                                                    .delete_user_coupon(
                                                        token_id:
                                                            box.read('token'),
                                                        coupon_id:  f.trim().isEmpty
                                                            ? snapshot
                                                            .data
                                                            ?.result
                                                            ?.allVisitoe![pos]
                                                            .visitorId:data[pos]
                                                            .visitorId)
                                                    .then((value) {
                                                  setState(() {});
                                                });
                                              },
                                              child: Icon(Icons.delete)))
                                    ],
                                  ),
                                ),
                              ),
                            );

                            //
                            // listQRclient(
                            //   data: snapshot.data.result.allVisitoe[pos],
                            //   high: high,
                            //   fun: () {
                            //
                            //   });
                          }),
                    ),
                  ],
                );
              } else {
                print(snapshot.error.toString());
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  _scrollListener() {
    if (_scrollController!.offset >=
            _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      if (sizelist > 50) {
        limit = limit + 20;
        setState(() {});
        // getallp(
        //     limit: limit.toString().toString(),
        //     page_number: 0.toString(),
        //     token_id: token,
        //     phone: phone);
      }
    }
  }
}
