import 'dart:convert';

import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/scr/statistics.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:commercial_app/utilitie/jsondata/agent_login_JSON.dart';
import 'package:commercial_app/utilitie/jsondata/ios_login_json.dart';
import 'package:commercial_app/utilitie/push_notifcation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'forget_password/forget_password_screen.dart';

class LoginScr extends StatefulWidget {
  @override
  _LoginScrState createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  PushNotificationManagger _pushNotificationManagger =
      PushNotificationManagger();

  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  bool login = false;
  bool isShown = true;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  final loginButton = Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {},
      padding: EdgeInsets.all(12),
      color: hexToColor('#00abeb'),
      child: Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
    ),
  );

  final forgotLabel = FlatButton(
    child: Text(
      'Forgot password?',
      style: TextStyle(color: Colors.black54),
    ),
    onPressed: () {},
  );

  @override
  void initState() {
    super.initState();
    _allNetworking.ios_login().then((value) {
      print(value);
      print('oooooooooooooooooooooooooooooooooooooooooo');
    }).catchError((e) {
      print('pppppppppppppppppppppp');
    });
  } //phone: '022428241', password: '123456'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Ios_login_json>(
            future: _allNetworking.ios_login(),
            builder: (context, data) {
              print(data.data);
              if (data.hasData) {
                print('ooooooooooooooooooooooooooooooo');
                print(data.data);
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                      Image.asset(
                        'assets/images/log.png',
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(height: 48.0),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phone,
                          decoration: InputDecoration(
                            labelText: ' رقم الهاتف',
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
                            hintText: 'رقم الهاتف',
                            hintStyle: TextStyle(
                              fontFamily: 'Arbf',
                              color: hexToColor('#ed1c6f'),
                            ),
                          )),
                      SizedBox(height: 8.0),
                      TextFormField(
                        obscureText: isShown,
                        controller: password,
                        decoration: InputDecoration(
                          labelText: ' كلمه السر',
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
                          hintText: ' كلمه السر',
                          suffixIcon: InkWell(
                              onTap: () {
                                isShown = !isShown;
                                setState(() {});
                              },
                              child: Icon(isShown
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined)),
                          hintStyle: TextStyle(
                            fontFamily: 'Arbf',
                            color: hexToColor('#ed1c6f'),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      login
                          ? Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                onPressed: () async {
                                  if (phone.text != null &&
                                      password.text != null) {
                                    login = true;
                                    setState(() {});
                                    await _pushNotificationManagger
                                        .init()
                                        .then((valueee) async {
                                      print(
                                          'fireeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
                                      print(valueee);
                                      print(
                                          'fireeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
                                      await _allNetworking.Login(
                                              phone: phone.text,
                                              password: password.text,
                                              firebase_token: valueee,
                                              lang: 'ar')
                                          .then((value) async {
                                        if (value.status) {
                                          await box.write('phone',
                                              value.result.agentData.phone);
                                          await box.write(
                                              'firebase_token', valueee);
                                          await box.write('name',
                                              value.result.agentData.name);
                                          await box.write('token',
                                              value.result.agentData.token);
                                          await box.write('email',
                                              value.result.agentData.email);
                                          await box.write(
                                              'id', value.result.agentData.id);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      Statisticss()),
                                              (Route<dynamic> route) => false);
                                        } else {
                                          Get.snackbar('', value.message);
                                        }
                                        login = false;
                                        setState(() {});
                                      });
                                    });
                                  }
                                },
                                padding: EdgeInsets.all(12),
                                color: hexToColor('#00abeb'),
                                child: Text('تسجيل الدخول',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                      //  forgotLabel
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen(),
                                ));
                          },
                          child: Text(
                            "نسيت كلمة السر؟",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.red,
                                fontFamily: 'GE-Snd-Book'),
                          ),
                        ),
                      ),
                      if (data.data.loginId == 1)
                        InkWell(
                            onTap: () async {
                              await box.write('phone', "0123456789");
                              await box.write('firebase_token', "11");
                              await box.write('name', "Naser");

                              await box.write('email', "naser@gmai.com");

                              await box.write('id', "11");

                              await box.write('token', data.data.tokenId);

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => Statisticss()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "تخطي",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            ))
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
