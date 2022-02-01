import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/jsondata/gate_list_rate_json.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class RateTitle extends StatefulWidget {
  @override
  _RateTitleState createState() => _RateTitleState();
}

class _RateTitleState extends State<RateTitle> {
  final box = GetStorage();
  String token;
  AllNetworking _allNetworking = AllNetworking();

  @override
  void initState() {
    super.initState();
    token = box.read('token');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: FutureBuilder<Gate_list_rate_json>(
              future: _allNetworking.gate_list_rate(token_id: token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.result.allRate.length,
                    itemBuilder: (context, pos) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 8,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            ' الاسم : ${snapshot.data.result.allRate[pos].username}')
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      AllNetworking().deleteRate(
                                          token_id: token,
                                          rateId: snapshot
                                              .data.result.allRate[pos].rateId);
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                        '  التقيم  ${snapshot.data.result.allRate[pos].userrate}'),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Icon(Icons.star)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                        'تعليقات ${snapshot.data.result.allRate[pos].usercomment}')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
