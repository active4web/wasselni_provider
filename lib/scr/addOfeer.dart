import 'dart:io';
import 'dart:math';

import 'package:commercial_app/bloc/datavalidatorAddOffer.dart';
import 'package:commercial_app/myWidget/inputTextWidget.dart';
import 'package:commercial_app/myWidget/myDrawer.dart';
import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddOffer extends StatefulWidget {
  BuildContext mycontext;

  AddOffer(this.mycontext);

  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  datavalidatorAddOffer v = datavalidatorAddOffer();
  TextEditingController _textEditingControllerthename = TextEditingController();
  TextEditingController _textEditingControllertheenname =
      TextEditingController();
  TextEditingController _textEditingControllertheoldprice =
      TextEditingController();
  TextEditingController _textEditingControllertheardes =
      TextEditingController();
  TextEditingController _textEditingControllertheendes =
      TextEditingController();
  TextEditingController _textEditingControllerthenewprice =
      TextEditingController();

  TextEditingController _textEditingControllerthetarkname =
      TextEditingController();
  TextEditingController _textEditingControllerthetarkdes =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList;
  File _image;
  List<File> _images = [];
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String thename, theenname, theoldprice, theardes, theendes, thenewprice;
  bool savedata = false;
  DateTime startpickDate;
  DateTime endpickDate;

  @override
  void dispose() {
    v.despoos();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startpickDate = DateTime.now();
    endpickDate = DateTime.now();
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
            title: Text('addoffer'.tr,
                style: TextStyle(
                    fontFamily: 'Arbf', color: Colors.white, fontSize: 18)),
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 16),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: high * .1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            var image = await ImagePicker.platform.pickImage(
                                source: ImageSource.gallery,
                                maxHeight: 1500,
                                maxWidth: 1200,
                                imageQuality: 100);
                            setState(() {
                              _image = File(image.path);
                            });
                          },
                          child: Text('اضافه الصوره الرئيسية للعرض',
                              style: TextStyle(
                                  fontFamily: 'Arbf',
                                  color: hexToColor('#00abeb'),
                                  fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _picker
                                .pickMultiImage(
                              maxWidth: 1200,
                              maxHeight: 1500,
                              imageQuality: 100,
                            )
                                .then((value) {
                              _imageFileList = value;
                              Fluttertoast.showToast(
                                  msg: "تم اختيار ${value.length} صور");
                              _images.clear();
                              for (int i = 0; i < value.length; i++) {
                                print('ppppppppppppppppppppppppppppppp');
                                File file = File(value[i].path);
                                _images.add(file);
                                setState(() {});
                              }
                              // _imageFileList.map((e) {
                              //
                              //
                              //   // return Padding(
                              //   //   padding: const EdgeInsets.all(8.0),
                              //   //   child: Container(
                              //   //     width: MediaQuery.of(context).size.width,
                              //   //     height:
                              //   //         MediaQuery.of(context).size.height * .3,
                              //   //     child: Image.file(
                              //   //       file,
                              //   //       fit: BoxFit.cover,
                              //   //     ),
                              //   //   ),
                              //   // );
                              // }).toList();
                            });
                          },
                          child: Text(
                              'اضافه المزيد من الصور(${_images.length})  ',
                              style: TextStyle(
                                  fontFamily: 'Arbf',
                                  color: hexToColor('#00abeb'),
                                  fontSize: 20)),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        var image = await ImagePicker.platform.pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 1500,
                            maxWidth: 1200,
                            imageQuality: 100);
                        setState(() {
                          _image = File(image.path);
                        });
                      },
                      child: _image == null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.blueAccent,
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_image),
                            ),
                    )
                  ],
                ),
                SizedBox(
                  height: high * .02,
                ),
                inputText(
                    inputtype: TextInputType.text,
                    textedet: _textEditingControllerthename,
                    changedata: (st) {
                      v.changeName(st);
                      thename = st;
                    },
                    stram: v.nameoffer,
                    hint: 'اسم العرض'),
                SizedBox(
                  height: high * .02,
                ),
                inputText(
                    inputtype: TextInputType.text,
                    textedet: _textEditingControllertheenname,
                    changedata: (st) {
                      v.changeenname(st);
                      theenname = st;
                    },
                    stram: v.ennameoffer,
                    hint: 'offer name'),
                SizedBox(
                  height: high * .02,
                ),

                TextFormField(
                  controller: _textEditingControllerthetarkname,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  maxLines: null,
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                  decoration: InputDecoration(
                    labelText: 'الاسم بلتركي',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#00abeb'), width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#00abeb'), width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'الاسم بلتركي',
                    hintStyle: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                  ),
                ),
                SizedBox(
                  height: high * .02,
                ),
                inputText(
                    inputtype: TextInputType.multiline,
                    textedet: _textEditingControllertheardes,
                    changedata: (st) {
                      v.changeardes(st);
                      theardes = st;
                    },
                    stram: v.ardesoffer,
                    hint: 'ﻭﺻﻒ العرض'),
                SizedBox(
                  height: high * .02,
                ),
                inputText(
                    inputtype: TextInputType.multiline,
                    textedet: _textEditingControllertheendes,
                    changedata: (st) {
                      v.changeendes(st);
                      theendes = st;
                    },
                    stram: v.endesoffer,
                    hint: 'Details'),

                SizedBox(
                  height: high * .02,
                ),

                TextFormField(
                  controller: _textEditingControllerthetarkdes,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  maxLines: null,
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                  decoration: InputDecoration(
                    labelText: 'الوصف بلتركي',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#00abeb'), width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#00abeb'), width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'الوصف بلتركي',
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
                  keyboardType: TextInputType.number,
                  controller: _textEditingControllertheoldprice,
                  onChanged: (s) {
                    theoldprice = s;
                  },
                  textAlign: TextAlign.center,
                  maxLines: null,
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                  decoration: InputDecoration(
                    labelText: 'السعر قبل الخصم',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#00abeb'), width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#00abeb'), width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'السعر قبل الخصم',
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
                  keyboardType: TextInputType.number,
                  controller: _textEditingControllerthenewprice,
                  onChanged: (s) {
                    thenewprice = s;
                  },
                  textAlign: TextAlign.center,
                  maxLines: null,
                  style: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                  decoration: InputDecoration(
                    labelText: 'السعر بعد الخصم',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#00abeb'), width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#00abeb'), width: 2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'السعر بعد الخصم',
                    hintStyle: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                  ),
                ),
                SizedBox(
                  height: high * .02,
                ),
                GestureDetector(
                    onTap: () async {
                      DateTime date = await showDatePicker(
                          context: context,
                          initialDate: startpickDate,
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(DateTime.now().year + 1));
                      if (date != null) {
                        startpickDate = date;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: hexToColor('#00abeb'),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                            "تاريخ البدء: ${startpickDate.year},${startpickDate.month},${startpickDate.day}"),
                      ),
                    )),
                SizedBox(
                  height: high * .02,
                ),
                GestureDetector(
                    onTap: () async {
                      DateTime date = await showDatePicker(
                          context: context,
                          initialDate: endpickDate,
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(DateTime.now().year + 1));
                      if (date != null) {
                        endpickDate = date;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: hexToColor('#00abeb'),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                            "تاريخ الانتهاء: ${endpickDate.year},${endpickDate.month},${endpickDate.day}"),
                      ),
                    )),
                SizedBox(
                  height: high * .02,
                ),
                savedata
                    ? Center(child: CircularProgressIndicator())
                    : GestureDetector(
                        onTap: () async {
                          savedata = true;
                          setState(() {});

                          String phone = box.read('phone');
                          String token = box.read('token');
                          // final bytes =
                          // await File(_image.path).readAsBytesSync();
                          // //  base64Image = base64Encode(bytes.readAsBytesSync());
                          // base64Image = await base64.encode(bytes);
                          // print(base64Image);
                          String end_date = endpickDate.year.toString() +
                              "-" +
                              endpickDate.month.toString() +
                              "-" +
                              endpickDate.day.toString();
                          String start_date = startpickDate.year.toString() +
                              "-" +
                              startpickDate.month.toString() +
                              "-" +
                              startpickDate.day.toString();
                          print(end_date);
                          print(start_date);
                          _allNetworking
                              .add_offer(
                            phone: phone,
                            name_tr:
                                _textEditingControllerthetarkname.text ?? " ",
                            description_tr:
                                _textEditingControllerthetarkdes.text ?? " ",
                            token_id: token,
                            title: thename,
                            title_en: theenname,
                            current_price: thenewprice,
                            old_price: theoldprice,
                            description_ar: theardes,
                            description_en: theendes,
                            end_date: end_date,
                            start_date: start_date,
                            file: _image ?? null,
                            file1: _images.length > 0 ? _images[0] : null,
                            file2: _images.length > 1 ? _images[1] : null,
                            file3: _images.length > 2 ? _images[2] : null,
                            file4: _images.length > 3 ? _images[3] : null,
                            file5: _images.length > 4 ? _images[4] : null,
                          )
                              .then((value) {
                            //      _image=null;
                            //      _textEditingControllerthename.clear();
                            //
                            //      _textEditingControllertheenname .clear();
                            //     _textEditingControllertheoldprice.clear();
                            //       _textEditingControllertheardes.clear();
                            //     _textEditingControllertheendes.clear();
                            // _textEditingControllerthenewprice.clear();
                            Navigator.pop(widget.mycontext);

                            //
                            // thename=''; theenname='';  theoldprice=''; theardes='';  theendes='';  thenewprice='';
                            // print(value.data);
                            // print(
                            //     'ppppppppppppppppppppppppppppppppppppppppppp');
                            // savedata = false;
                            //
                          });
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
                                borderRadius: BorderRadius.circular(5.0))),
                      )
//                     : StreamBuilder(
//                   stream: v.validationUserDataoffer,
//                   builder: (context, data) {
//                     return GestureDetector(
//                       onTap: data.data != null
//                           ? () async {
//                         savedata = true;
//                         setState(() {});
//
//                         String phone = box.read('phone');
//                         String token = box.read('token');
//                         // final bytes =
//                         // await File(_image.path).readAsBytesSync();
//                         // //  base64Image = base64Encode(bytes.readAsBytesSync());
//                         // base64Image = await base64.encode(bytes);
//                         // print(base64Image);
//                         String end_date = endpickDate.year.toString() +"-"+
//                             endpickDate.month.toString() +"-"+
//                             endpickDate.day.toString();
//                         String start_date = startpickDate.year.toString() +"-"+
//                             startpickDate.month.toString() +"-"+
//                             startpickDate.day.toString();
// print(end_date);
//                         print(start_date);
//                         _allNetworking
//                             .add_offer(
//                             phone: phone,name_tr: _textEditingControllerthetarkname.text??" ",description_tr: _textEditingControllerthetarkdes.text??" ",
//                             token_id: token,
//                             title: thename,
//                             title_en: theenname,
//                             current_price: thenewprice,
//                             old_price: theoldprice,
//                             description_ar: theardes,
//                             description_en: theendes,
//                             end_date
//                             :end_date,
//                             start_date
//                             :start_date,
//                             file: _image)
//                             .then((value) {
//                      //      _image=null;
//                      //      _textEditingControllerthename.clear();
//                      //
//                      //      _textEditingControllertheenname .clear();
//                      //     _textEditingControllertheoldprice.clear();
//                      //       _textEditingControllertheardes.clear();
//                      //     _textEditingControllertheendes.clear();
//                      // _textEditingControllerthenewprice.clear();
//                           Navigator.pop(widget.mycontext);
//
//
//
//                           //
//                           // thename=''; theenname='';  theoldprice=''; theardes='';  theendes='';  thenewprice='';
//                           // print(value.data);
//                           // print(
//                           //     'ppppppppppppppppppppppppppppppppppppppppppp');
//                           // savedata = false;
//                           //
//
//
//                          });
//                       }
//                           : null,
//                       child: Container(
//                         height: high * .1,
//                         width: width * 0.5,
//                         child: Center(
//                           child: Text('حفظ',
//                               style: TextStyle(
//                                   fontFamily: 'Arbf',
//                                   color: Colors.white,
//                                   fontSize: 25)),
//                         ),
//                         decoration: data.data != null
//                             ? BoxDecoration(
//                             color: hexToColor('#00abeb'),
//                             gradient: new LinearGradient(
//                                 colors: [
//                                   hexToColor('#2358a6'),
//                                   hexToColor('#00abeb')
//                                 ],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                                 tileMode: TileMode.clamp),
//                             borderRadius: BorderRadius.circular(5.0))
//                             : BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius:
//                             BorderRadius.circular(5.0)),
//                       ),
//                     );
//                   },
//                 )
              ]),
            ),
          )),
    );
  }
}
