import 'package:commercial_app/myWidget/myDrawer.dart';
import 'package:commercial_app/netWORK/allnetworking.dart';
import 'package:commercial_app/scr/notificationdetailsScr.dart';
import 'package:commercial_app/utilitie/jsondata/get_list_notifications_JSON.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class NotificationScr extends StatefulWidget {
  @override
  _NotificationScrState createState() => _NotificationScrState();
}

class _NotificationScrState extends State<NotificationScr> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  ScrollController _scrollController;
  String token;
  String phone;
  int limit = 10;
  int sizelist = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    phone = box.read('phone');
    token = box.read('token');
    print('oooooooooooooooooooooooooooooooo');
    print(token);
    print('oooooooooooooooooooooooooooooooo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mydrawer(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text('التنبيهات'),
      ),
      body: StreamBuilder<Get_list_notifications_JSON>(
          stream: _allNetworking
              .get_list_notifications(
              phone: phone, token_id: token, limit: limit, page_number: 0)
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    itemCount: snapshot.data.result.allNotifications.length,
                    itemBuilder: (cont, pos) {
                      return GestureDetector(onTap: (){

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotifictionDetSCR( snapshot.data.result
                              .allNotifications[pos])),
                        );
                      },
                        child: Card(color:  snapshot.data.result
                            .allNotifications[pos].isRead==1?Colors.black12:Colors.grey
                     ,   elevation: 8,
                          child: Container(
                            //height: 100,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(snapshot.data.result
                                          .allNotifications[pos].createdAt),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(onTap: () {
                                        print ('ggggggggggggggggggggggggggg');
                                        _allNetworking.delete_notification(
                                            token_id: token,
                                             id_notify:               snapshot.data.result
                                                .allNotifications[pos].id).then((value) {
                                                  print(value.data);
                                                  setState(() {

                                                  });
                                        });
                                      }, child: Icon(Icons.delete)),

                                    ),
                                  ],
                                ),
                                GestureDetector(onTap: (){

                                },
                                  child:  Text(
                                          snapshot.data.result.allNotifications[pos]
                                              .title) ,
                                )
                              ,  snapshot.data.result
                                    .allNotifications[pos].isRead==1?Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(alignment: Alignment.bottomLeft,child: Text( ' تم قراءة الرسالة')),
                                    ):Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(alignment: Alignment.bottomLeft,child: Text( 'لم يتم  قراءة الرسالة')),
                                )   ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }


  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (sizelist > 8) {
        limit = limit + 20;
        setState(() {

        });
        // getallp(
        //     limit: limit.toString().toString(),
        //     page_number: 0.toString(),
        //     token_id: token,
        //     phone: phone);
      }
    }
  }
}
