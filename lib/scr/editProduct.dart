import 'dart:io';

import 'package:commercial_app/bloc/datavalidatorAddOffer.dart';

import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/preparation_edit_product_JSON.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  String token;
  int proid;

  EditProduct({this.proid, this.token});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  datavalidatorAddOffer v = datavalidatorAddOffer();
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  TextEditingController stock = TextEditingController();
  TextEditingController pronamear = TextEditingController();
  TextEditingController pronameen = TextEditingController();
  TextEditingController detailsar = TextEditingController();
  TextEditingController detailsen = TextEditingController();
  TextEditingController name_tr = TextEditingController();
  TextEditingController details_tr = TextEditingController();
  TextEditingController thenewprice = TextEditingController();
  File _image;
  bool savedata = false;
  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var high = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('تعديل منتج ',
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: StreamBuilder<Preparation_edit_product_JSON>(
              stream: _allNetworking
                  .preparation_edit_product(
                      token_id: widget.token, product_id: widget.proid)
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  stock.text= snapshot.data.result.allProducts[0].stock;
                  pronamear.text =
                      snapshot.data.result.allProducts[0].productName;
                  pronameen.text =
                      snapshot.data.result.allProducts[0].productNameEn;
                  detailsar.text =
                      snapshot.data.result.allProducts[0].productDescription;
                  detailsen.text =
                      snapshot.data.result.allProducts[0].productDescriptionEn;
                  name_tr.text= snapshot.data.result.allProducts[0].nameTr;

                  details_tr .text= snapshot.data.result.allProducts[0].descriptionTr;


                  thenewprice.text =
                      snapshot.data.result.allProducts[0].newPrice ?? ' ';

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: high * .1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('اضافه صوره للمنتج',
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: hexToColor('#00abeb'),
                                    fontSize: 20)),
                            InkWell(
                              onTap: () async {
                                var image = await ImagePicker.platform
                                    .pickImage(
                                        source: ImageSource.gallery,
                                        maxHeight: 1500,
                                        maxWidth: 1200,
                                        imageQuality: 100);
                                setState(() {
                                  if (image != null) {
                                    _image = File(image.path);
                                  }
                                });
                              },
                              child: Container(
                                height: high * .1,
                                width: high * .1,
                                child: _image != null
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        snapshot.data.result.allProducts[0]
                                            .productImage,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: high * .02,
                        ),
                        TextFormField(
                          controller: pronamear,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'اسم المنتج',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: high * .02,
                        ),
                        TextFormField(
                          controller: name_tr,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'اسم المنتج بلتركي ',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: high * .02,
                        ),
                        TextFormField(
                          controller: pronameen,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Product name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: high * .02,
                        ),
                        TextFormField(
                          controller: detailsar,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'ﻭﺻﻒ ﺍﻟﻤﻨﺘﺞ',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: high * .02,
                        ),
                        TextFormField(
                          controller: detailsen,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Details',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: high * .02,
                        ),
                        TextFormField(
                          controller: details_tr,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'وصف المنتج بلتركي',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: high * .02,
                        ),
                        // TextFormField(
                        //   controller: theoldprice,
                        //   onChanged: (s) {},
                        //   textAlign: TextAlign.center,
                        //   maxLines: null,
                        //   style: TextStyle(
                        //     fontFamily: 'Arbf',
                        //     color: hexToColor('#ed1c6f'),
                        //   ),
                        //   decoration: InputDecoration(
                        //     labelText: 'ﺍﻟﺴﻌﺮالقديم',
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: hexToColor('#00abeb'), width: 2),
                        //       borderRadius: BorderRadius.circular(5.0),
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: hexToColor('#00abeb'), width: 2),
                        //       borderRadius: BorderRadius.circular(5.0),
                        //     ),
                        //     hintStyle: TextStyle(
                        //       fontFamily: 'Arbf',
                        //       color: hexToColor('#ed1c6f'),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: high * .02,
                        ),
                        TextFormField(keyboardType:TextInputType.number ,
                          controller: thenewprice,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'ﺍﻟﺴﻌﺮ',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: high * .02,
                        ),



                        TextFormField(
                          controller: stock,
                          onChanged: (s) {},
                          textAlign: TextAlign.center,
                          maxLines: null,
                          style: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                          decoration: InputDecoration(
                            labelText: 'قيمه المخزن',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#00abeb'), width: 2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          ),
                        ),




                        SizedBox(
                          height: high * .02,
                        ),
                        savedata
                            ? Container(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(),
                              )
                            : GestureDetector(
                                onTap: () {
                                  print('0000000000000000000000000000000');
                                  savedata = true;
                                  setState(() {
                                    
                                  });
                                  String token = box.read('token');
                                  _allNetworking
                                      .edit_product(
                                          token_id: token,stock: stock.text,
                                          title: pronamear.text,
                                          id_product: widget.proid,
                                          title_en: pronameen.text,
                                          current_price: thenewprice.text,
                                          old_price:'',// theoldprice.text,
                                          description_ar: detailsar.text,name_tr: name_tr.text??"",description_tr: details_tr.text??"",
                                          description_en: detailsen.text,
                                          file: _image)
                                      .then((value) {
                                    print(value.data);
                                    print(
                                        'ppppppppppppppppppppppppppppppppppppppppppp');
                                    savedata = false;
                                    setState(() {});
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text( ''),
                                        content: Text("تم التعديل"),
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
                                    );});
                                },
                                child: Container(
                                    height: high * .1,
                                    width: width * 0.5,
                                    child: Center(
                                      child: Text('حفظ',
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
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              )
                      ]),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
