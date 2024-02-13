import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/scr/forget_password/edit_password_screen.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var phoneNumber = TextEditingController();
  bool login = false;

  AllNetworking _allNetworking = AllNetworking();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/log.png",
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneNumber,
                  decoration: InputDecoration(
                    labelText: ' رقم الهاتف',
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
                    hintText: 'رقم الهاتف',
                    hintStyle: TextStyle(
                      fontFamily: 'Arbf',
                      color: hexToColor('#ed1c6f'),
                    ),
                  )),
              !login
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                       style: ButtonStyle(
                         shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(24),
                           ),
                         )
                       ),
                        onPressed: () async {
                          if (phoneNumber.text != null) {
                            login = true;
                            setState(() {});
                            {
                              await _allNetworking
                                  .forgetPassword(
                                      phone: phoneNumber.text, lang: 'ar')
                                  .then((value) async {
                                if (value?.data["status"]) {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => OtpScreen()),
                                  );
                                } else {
                                  Get.snackbar('', value?.data["message"]);
                                }
                                login = false;
                                setState(() {});
                              });
                            }
                          }
                        },
                        // padding: EdgeInsets.all(12),
                        // color: hexToColor('#00abeb'),
                        child: Text('تاكيد',
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
