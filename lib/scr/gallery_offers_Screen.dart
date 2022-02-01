import 'dart:ui';

import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_gallery_offers_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'addPicOfferGallery.dart';

class Gallery_Offers_Scr extends StatefulWidget {
  final int offer_id;

  Gallery_Offers_Scr(this.offer_id);

  @override
  _Gallery_Offers_ScrState createState() => _Gallery_Offers_ScrState();
}

class _Gallery_Offers_ScrState extends State<Gallery_Offers_Scr> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String token;

  @override
  void initState() {
    super.initState();
    token = box.read('token');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('معرض الصور'),
        centerTitle: true,
      ),
      body: Column(
        children: [GestureDetector(onTap: (){
Get.to(AddPicOfferGallery(widget.offer_id));
        },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: size.height * .05,
                width:size. width * 0.4,
                child: Center(
                  child: Text('اضافه صور',
                      style: TextStyle(
                          fontFamily: 'Arbf',
                          color: Colors.white,
                          fontSize: 18)),
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
        ),
          Expanded(
            child: FutureBuilder<Get_all_gallery_offers_json>(
                future: _allNetworking.get_all_gallery_offers(
                    token_id: token,
                    limit: 100,
                    page_number: 0,
                    offer_id: widget.offer_id),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    print(snapshot.data.result.allGalleries);
                    return ListView.builder(
                        itemCount: snapshot.data.result.allGalleries.length,
                        itemBuilder: (context, pos) {
                          return Card(elevation: 8,
                            child: Container(width: size.width,padding: EdgeInsets.all(8),
                              height: size.height * .3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container( width: size.width,
                                      child: Image.network(snapshot
                                          .data.result.allGalleries[pos].offerImage,fit: BoxFit.fill,),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _allNetworking
                                            .delete_img_gallery_offer(
                                                token_id: token,
                                                img_id: snapshot.data.result
                                                    .allGalleries[pos].imgId)
                                            .then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          );
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
    );
  }
}
