import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/scr/mapScr.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/gate_list_location_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:map_launcher/map_launcher.dart';

class Gate_list_location extends StatefulWidget {
  @override
  _Gate_list_locationState createState() => _Gate_list_locationState();
}

class _Gate_list_locationState extends State<Gate_list_location> {
  final box = GetStorage();
  String token;
  AllNetworking _allNetworking = AllNetworking();
  String f = "";
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
          body: FutureBuilder<Gate_list_location_json>(
              future: _allNetworking.gate_list_location(token_id: token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<AllListLocation> dat =
                      snapshot.data.result.allListLocation;
                  List<AllListLocation> data = [];
                  dat.forEach((element) {
                    if (element.phone.contains(f)) {
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
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: f.trim().isEmpty
                              ? snapshot.data.result.allListLocation.length
                              : data.length,
                          itemBuilder: (context, pos) {
                            return GestureDetector(
                              onTap: () async {
                                // Get.to(MapScr(f.trim().isEmpty
                                //     ? snapshot.data.result.allListLocation[pos]
                                //     : data[pos]));
                                final availableMaps =
                                    await MapLauncher.installedMaps;
                                print(availableMaps);
                                if (await MapLauncher.isMapAvailable(
                                    MapType.google)) {
                                  await MapLauncher.showMarker(
                                      mapType: MapType.google,
                                      coords: Coords(
                                        double.parse(snapshot.data.result
                                            .allListLocation[pos].lat),
                                        double.parse(snapshot.data.result
                                            .allListLocation[pos].lag),
                                      ));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 8,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                                ' الاسم : ${f.trim().isEmpty ? snapshot.data.result.allListLocation[pos].username : data[pos].username}')
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                                ' الهاتف  ${f.trim().isEmpty ? snapshot.data.result.allListLocation[pos].phone : data[pos].phone}')
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '  الموقع علي الخريطه  ${f.trim().isEmpty ? snapshot.data.result.allListLocation[pos].comment : data[pos].comment}'),
                                            Icon(
                                              Icons.map,
                                              size: 30,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
        ));
  }
}
