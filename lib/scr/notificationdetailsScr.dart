import 'package:commercial_app/utilitie/jsondata/get_list_notifications_JSON.dart';
import 'package:flutter/material.dart';

class NotifictionDetSCR extends StatefulWidget {
  AllNotifications _allNotifications;

  NotifictionDetSCR(this._allNotifications);

  @override
  _NotifictionSCRState createState() => _NotifictionSCRState();
}

class _NotifictionSCRState extends State<NotifictionDetSCR> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: true,
      child: Scaffold(appBar: AppBar(centerTitle: true,title:Text(widget._allNotifications.title) ,),body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(widget._allNotifications.createdAt),
         Text(widget._allNotifications.body,style: TextStyle(fontSize: 18),), ],),
      )),),
    );
  }
}
