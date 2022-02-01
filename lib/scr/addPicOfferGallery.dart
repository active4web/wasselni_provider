import 'dart:io';

import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddPicOfferGallery extends StatefulWidget {
  final int offer_id;

  AddPicOfferGallery(this.offer_id);

  @override
  _AddPicOfferGalleryState createState() => _AddPicOfferGalleryState();
}

class _AddPicOfferGalleryState extends State<AddPicOfferGallery> {
  AllNetworking _allNetworking = AllNetworking();
  List<XFile>  _imageFileList;
  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();
  String token;
  File _image;
bool sendpictoweb=false;
  @override
  void initState() {
    super.initState();
    token = box.read('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('اضافه صور للعرض'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                // final pickedFileList = await _picker.pickMultiImage(
                //   maxWidth: 1200,
                //   maxHeight: 1500,
                //   imageQuality: 100,
                // );

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
                  ? Container(
                      color: Colors.blue,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .3,
                      child: Image.asset('assets/images/add.png',fit: BoxFit.fill,),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .3,
                      child: Image.file(
                        _image,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          sendpictoweb?Center(child: CircularProgressIndicator(),):  GestureDetector(
            onTap: () {
              print('ofer id ${widget.offer_id}');
              sendpictoweb=true;
              setState(() {

              });
_allNetworking.add_gallery_offer(token_id: token, offer_id: widget.offer_id, file: _image).then((value) {
  Navigator.pop(context);

});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * .05,
                  width: MediaQuery.of(context).size.width * 0.4,
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
                      borderRadius: BorderRadius.circular(40.0))),
            ),
          ),
        ],
      ),
    );
  }
}
