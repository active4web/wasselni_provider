import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/scr/login.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class EditPassword extends StatefulWidget {
  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  var phone = TextEditingController();

  var newPassword = TextEditingController();

  var confirmNewPassword = TextEditingController();
  AllNetworking _allNetworking = AllNetworking();

  bool isPassword = true;
  bool confirmPassword = true;

  bool login = false;
  bool isShown = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/log.png",
                  width: 80,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phone,
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
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: isPassword,
                controller: newPassword,
                decoration: InputDecoration(
                  labelText: ' كلمه السر الجديدة',
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
                  hintText: ' كلمه السر الجديدة',
                  suffixIcon: InkWell(
                      onTap: () {
                        isPassword = !isPassword;
                        setState(() {});
                      },
                      child: Icon(isPassword
                          ? Icons.visibility
                          : Icons.visibility_off_outlined)),
                  hintStyle: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: confirmPassword,
                controller: confirmNewPassword,
                decoration: InputDecoration(
                  labelText: ' كلمه السر الجديدة',
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
                  hintText: ' كلمه السر الجديدة',
                  suffixIcon: InkWell(
                      onTap: () {
                        confirmPassword = !confirmPassword;
                        setState(() {});
                      },
                      child: Icon(confirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off_outlined)),
                  hintStyle: TextStyle(
                    fontFamily: 'Arbf',
                    color: hexToColor('#ed1c6f'),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              login
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
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
                          if (phone.text != null &&
                              newPassword.text == confirmNewPassword.text) {
                            login = true;
                            setState(() {});
                            {
                              await _allNetworking
                                  .editPassword(
                                      phone: phone.text,
                                      password: newPassword.text,
                                      confirmPassword: confirmNewPassword.text,
                                      lang: 'ar')
                                  .then((value) async {
                                // Agent_login_JSON data = Agent_login_JSON.fromJson(
                                //     json.decode(value ));

                                if (value?.data["status"]) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => LoginScr()),
                                      (Route<dynamic> route) => false);
                                } else {
                                  Get.snackbar('', value?.data["message"]);
                                }

                                login = false;
                                setState(() {});
                              });
                            }
                            ;
                          }
                        },
                        // padding: EdgeInsets.all(12),
                        // color: hexToColor('#00abeb'),
                        child: Text('تسجيل الدخول',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
