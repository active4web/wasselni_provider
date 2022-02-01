import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:commercial_app/netWORK/contsants.dart';
import 'package:commercial_app/utilitie/jsondata/agent_login_JSON.dart';
import 'package:commercial_app/utilitie/jsondata/cancel_order_json.dart';
import 'package:commercial_app/utilitie/jsondata/check_coupon_json.dart';
import 'package:commercial_app/utilitie/jsondata/create_coupon_json.dart';
import 'package:commercial_app/utilitie/jsondata/galler_jason.dart';
import 'package:commercial_app/utilitie/jsondata/gate_list_location_json.dart';
import 'package:commercial_app/utilitie/jsondata/gate_list_rate_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_Waiting_Orders_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_branches_JSON.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_gallery_offers_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_order_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_user_coupons_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_visitor_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_all_visitor_points_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_current_orders_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_home_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_list_notifications_JSON.dart';
import 'package:commercial_app/utilitie/jsondata/get_order_details_json.dart';
import 'package:commercial_app/utilitie/jsondata/get_previous_orders_json.dart';
import 'package:commercial_app/utilitie/jsondata/preparation_edit_branch_JSON.dart';
import 'package:commercial_app/utilitie/jsondata/preparation_edit_offer_JSON.dart';
import 'package:commercial_app/utilitie/jsondata/preparation_edit_product_JSON.dart';
import 'package:commercial_app/utilitie/jsondata/preparation_points_json.dart';
import 'package:commercial_app/utilitie/jsondata/preparation_profile_json.dart';
import 'package:commercial_app/utilitie/jsondata/tags_model.dart';
import 'package:commercial_app/utilitie/jsondata/ticket_json.dart';
import 'package:commercial_app/utilitie/jsondata/tickets_json.dart';
import 'package:commercial_app/utilitie/jsondata/ios_login_json.dart';
import 'package:commercial_app/utilitie/jsondata/tickets_types_json.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../notification_helper.dart';

class AllNetworking {
  var paseurl = baseUrl;

  //Response response;
  Dio dio = new Dio();

  Future<Agent_login_JSON> Login({
    @required String phone,
    @required String password,
    @required String firebase_token,
    @required String lang,
  }) async {
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "password": password,
      "phone": phone,
      "firebase_token": firebase_token,
      "lang": lang,
    });
    Agent_login_JSON data;
    await dio
        .post(
      paseurl + '/provider/agent_login',
      data: formData,
    )
        .then((value) {
      print(value.data);
      data = Agent_login_JSON.fromJson(value.data);
    });

    print(data);
    return data;
  }

  Future<http.Response> Get_all_products({
    @required String phone,
    @required String token_id,
    @required String limit,
    @required String page_number,
  }) async {
    http.Response response = await http.post(
      Uri.parse(paseurl + '/provider/get_all_products'),
      body: {
        "mode": "formdata",
        "key": "1234567890",
        "token_id": token_id,
        "limit": limit,
        "page_number": page_number,
      },
    );

    return response;
  }

  Future<http.Response> delete_product({
    @required String token_id,
    @required String product_id,
  }) async {
    http.Response response = await http.post(
      Uri.parse(paseurl + '/provider/delete_product'),
      body: {
        "mode": "formdata",
        "key": "1234567890",
        "token_id": token_id,
        "product_id": product_id,
      },
    );

    return response;
  }

  Future<Response> add_product(
      {@required String phone,
      @required String stock,
      @required String token_id,
      @required String name_tr,
      @required String description_tr,
      @required String title,
      @required String title_en,
      @required String current_price,
      @required String old_price,
      @required String description_ar,
      @required String description_en,
      @required File file}) async {
    Response response;
    String fileName = file.path.split('/').last;

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id, "name_tr": name_tr,
      "description_tr": description_tr,
      "title": title,
      "title_en": title_en,
      "stock": stock,
      "current_price": current_price,
      "old_price": old_price,
      "description_ar": description_ar,
      "description_en": description_en,
      "file": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: new MediaType('image', 'png')),
    });
    response =
        await dio.post(paseurl + '/provider/add_product', data: formData);
    return response;
  }

  Future<Preparation_edit_product_JSON> preparation_edit_product({
    @required String token_id,
    @required int product_id,
  }) async {
    Preparation_edit_product_JSON data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_product": product_id,
    });

    await dio
        .post(
      paseurl + '/provider/preparation_edit_product',
      data: formData,
    )
        .then((value) {
      data = Preparation_edit_product_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_product({
    @required String token_id,
    @required String stock,
    @required String title,
    @required String title_en,
    @required String current_price,
    @required String old_price,
    @required String description_ar,
    @required String description_tr,
    @required String description_en,
    @required String name_tr,
    @required File file,
    @required int id_product,
  }) async {
    Response response;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890", "stock": stock,
      "token_id": token_id,
      "title": title,
      "title_en": title_en, "description_tr": description_tr,
      "name_tr": name_tr,
      "current_price": current_price,
      "id_product": id_product,

      "old_price": old_price,
      "description_ar": description_ar,
      "description_en": description_en,
      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
    });
    response =
        await dio.post(paseurl + '/provider/edit_product', data: formData);
    return response;
  }

  Future<http.Response> get_offers({
    @required String token_id,
    @required String limit,
    @required String page_number,
  }) async {
    http.Response response = await http.post(
      Uri.parse(paseurl + '/provider/get_offers'),
      body: {
        "mode": "formdata",
        "key": "1234567890",
        "token_id": token_id,
        "limit": limit,
        "page_number": page_number,
      },
    );

    return response;
  }

  Future<Response> add_offer({
    @required String phone,
    @required String name_tr,
    @required String description_tr,
    @required String token_id,
    @required String title,
    @required String title_en,
    @required String current_price,
    @required String old_price,
    @required String description_ar,
    @required String description_en,
    @required String end_date,
    @required String start_date,
    @required File file,
    @required File file1,
    @required File file2,
    @required File file3,
    @required File file4,
    @required File file5,
  }) async {
    Response response;
    String fileName = file.path.split('/').last ?? "";

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "title_en": title_en, "name_tr": name_tr,
      "description_tr": description_tr,
      "current_price": current_price,

      "end_date": end_date,
      "start_date": start_date,

      "old_price": old_price,
      "description_ar": description_ar,
      "description_en": description_en,
      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : "",
      "img": file1 != null
          ? await MultipartFile.fromFile(file1.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : "",
      "img1": file2 != null
          ? await MultipartFile.fromFile(file2.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : "",
      "img2": file3 != null
          ? await MultipartFile.fromFile(file3.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : "",
      "img3": file4 != null
          ? await MultipartFile.fromFile(file4.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : "",
      "img4": file5 != null
          ? await MultipartFile.fromFile(file5.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : "",
    });
    response = await dio.post(paseurl + '/provider/add_offer', data: formData);
    return response;
  }

  Future<Response> delete_offers({
    @required String token_id,
    @required int product_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "offer_id": product_id,
    });
    response = await dio.post(
      paseurl + '/provider/delete_offers',
      data: formData,
    );

    return response;
  }

  Future<Preparation_edit_offer_JSON> preparation_edit_details({
    @required String token_id,
    @required int offer_id,
  }) async {
    Preparation_edit_offer_JSON data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "offer_id": offer_id,
    });

    await dio
        .post(
      paseurl + '/provider/preparation_edit_details',
      data: formData,
    )
        .then((value) {
      data = Preparation_edit_offer_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_offer({
    @required String token_id,
    @required String name_tr,
    @required String description_tr,
    @required String title,
    @required String title_en,
    @required String current_price,
    @required String old_price,
    @required String description_ar,
    @required String end_date,
    @required String start_date,
    @required String description_en,
    @required File file,
    @required int id_product,
  }) async {
    Response response;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,

      "name_tr": name_tr,
      "description_tr": description_tr,

      "title": title,
      "title_en": title_en,
      "current_price": current_price,
      "offer_id": id_product,

      "end_date": end_date,
      "start_date": start_date,

      "old_price": old_price,
      "description_ar": description_ar,
      "description_en": description_en,
      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
    });
    response = await dio.post(paseurl + '/provider/edit_offer', data: formData);
    return response;
  }

  Future<Get_all_branches_JSON> get_all_branches({
    @required String token_id,
  }) async {
    Get_all_branches_JSON data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });

    await dio
        .post(
      paseurl + '/provider/get_all_branches',
      data: formData,
    )
        .then((value) {
      data = Get_all_branches_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> add_branch({
    @required String token_id,
    @required String name_tr,
    @required String description_tr,
    @required String title,
    @required String titlen_en,
    @required String phone,
    @required String whatsapp,
    @required String address_tr,
    @required String description,
    @required String description_en,
    @required String phone_second,
    @required String phone_third,
    @required String city_id,
    @required File file,
    @required String location,
    @required String address,
    @required String address_en,
    @required double lat,
    @required double lag,
  }) async {
    Response data;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "location": location,

      "address_tr": address_tr,

      "name_tr": name_tr,
      "description_tr": description_tr,

      //==============
      "lat": lat,
      "lag": lag,
      //==============
      "address": address,
      "address_en": address_en,

      "title": title,
      "titlen_en": titlen_en,
      "phone": phone,
      "whatsapp": whatsapp,

      "description": description,
      "description_en": description_en,
      "phone_second": phone_second,
      "phone_third": phone_third,
      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
      "city_id": city_id,
    });

    await dio
        .post(
      paseurl + '/provider/add_branch',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Response> delete_branch({
    @required String token_id,
    @required int id_branch,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_branch": id_branch,
    });
    response = await dio.post(
      paseurl + '/provider/delete_branch',
      data: formData,
    );

    return response;
  }

  Future<Preparation_edit_branch_JSON> preparation_edit_branch({
    @required String token_id,
    @required int id_branch,
  }) async {
    Preparation_edit_branch_JSON data;
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_branch": id_branch,
    });
    response = await dio
        .post(
      paseurl + '/provider/preparation_edit_branch',
      data: formData,
    )
        .then((value) {
      data = Preparation_edit_branch_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_branch({
    @required int id_branch,
    @required String token_id,
    @required String title,
    @required String address_tr,
    @required String name_tr,
    @required String description_tr,
    @required String titlen_en,
    @required String phone,
    @required String whatsapp,
    @required String description,
    @required String description_en,
    @required String phone_second,
    @required String phone_third,
    @required File file,
    @required String location,
    @required String address,
    @required String address_en,
    @required double lat,
    @required double lag,
  }) async {
    Response data;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "location": location,
      //==============
      "lat": lat, "address_tr": address_tr, "name_tr": name_tr,
      "lag": lag,

      "id_branch": id_branch,
      "title": title,
      "titlen_en": titlen_en,
      "phone": phone,
      "whatsapp": whatsapp,

      "address_en": address_en,
      "address": address,

      "name_tr": name_tr,
      "description_tr": description_tr,

      "description": description,
      "description_en": description_en,
      "phone_second": phone_second,
      "phone_third": phone_third,
      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
    });

    await dio
        .post(
      paseurl + '/provider/edit_branch',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Get_list_notifications_JSON> get_list_notifications({
    @required String phone,
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_list_notifications_JSON data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_list_notifications',
      data: formData,
    )
        .then((value) {
      data = Get_list_notifications_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_notification({
    @required String token_id,
    @required int id_notify,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_notify": id_notify,
    });
    response = await dio.post(
      paseurl + '/provider/delete_notification',
      data: formData,
    );

    return response;
  }

  Future<Tickets_json> tickets({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Tickets_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/tickets',
      data: formData,
    )
        .then((value) {
      data = Tickets_json.fromJson(value.data);
    });

    return data;
  }

  Future<Ticket_json> ticket({
    @required String token_id,
    @required int ticket_id,
  }) async {
    Ticket_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "ticket_id": ticket_id,
    });
    await dio
        .post(
      paseurl + '/provider/ticket',
      data: formData,
    )
        .then((value) {
      data = Ticket_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> new_ticket({
    @required String token_id,
    @required int ticket_type_id,
    @required String title,
    @required String content,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "ticket_type_id": ticket_type_id,
      "title": title,
      "content": content,
    });
    await dio
        .post(
      paseurl + '/provider/new_ticket',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Tickets_types_json> tickets_types({
    @required String token_id,
  }) async {
    Tickets_types_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/tickets_types',
      data: formData,
    )
        .then((value) {
      response = Tickets_types_json.fromJson(value.data);
    });

    return response;
  }

  Future<Response> new_reply({
    @required String token_id,
    @required int ticket_id,
    @required String content,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "ticket_id": ticket_id,
      "content": content,
    });
    response = await dio.post(
      paseurl + '/provider/new_reply',
      data: formData,
    );

    return response;
  }

  Future<Response> add_photography_requests({
    @required String token_id,
    @required String title,
    @required String content,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "content": content,
    });
    await dio
        .post(
      paseurl + '/provider/add_photography_requests',
      data: formData,
    )
        .then((value) {
          print(value.data);
      response = value;
    });

    return response;
  }

  Future<Preparation_profile_json> preparation_profile({
    @required String token_id,
  }) async {
    Preparation_profile_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/preparation_profile',
      data: formData,
    )
        .then((value) {
      response = Preparation_profile_json.fromJson(value.data);
    });

    return response;
  }

  Future<Response> edit_profile({
    @required String token_id,
    @required String password,
    @required String name_ar,
    @required String name_en,
    @required String description_tr,
    @required String name_tr,
    @required String address_tr,
    @required String phone,
    @required String whatsapp,
    @required String floar_num,
    @required String description,
    @required String description_en,
    @required String phone_second,
    @required String phone_third,
    @required File main_img,
    @required String location,
//========================
    @required String instagram,
    @required String twitter,
    @required String facebook,
    @required String website,
    @required String email,
    @required String address,
    @required String addressEn,
    @required double lat,
    @required double lag,
  }) async {
    Response data;
    String fileName;
    if (main_img != null) {
      fileName = main_img.path.split('/').last;
    }
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "location": location,
      //==============

      "name_tr": name_tr,
      "address_tr": address_tr,
      "description_tr": description_tr,

      "lat": lat,
      "lag": lag,
      "instagram": instagram,
      "twitter": twitter,
      "facebook": facebook,
      "website": website,
      "email": email,
      "name_ar": name_ar,
      "name_en": name_en,
      "phone": phone,
      "whatsapp": whatsapp,
      "address": address,
      "addressEn": addressEn,
      "floar_num": floar_num,
      "description": description,
      "description_en": description_en,
      "phone_second": phone_second,
      "password": password,
      "phone_third": phone_third,
      "main_img": main_img != null
          ? await MultipartFile.fromFile(main_img.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : null,
    });

    await dio
        .post(
      paseurl + '/provider/edit_profile',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Create_coupon_json> create_coupon({
    @required String token_id,
    @required int type,
  }) async {
    Create_coupon_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "type": type,
    });
    await dio
        .post(
      paseurl + '/provider/create_coupon',
      data: formData,
    )
        .then((value) {
      response = Create_coupon_json.fromJson(value.data);
      print(value.data);
    });

    return response;
  }

  Future<Get_home_json> get_home({
    @required String token_id,
    @required String lang,
  }) async {
    print('start get data');
    Get_home_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/provider/get_home',
      data: formData,
    )
        .then((value) {
      print(value.data);
      response = Get_home_json.fromJson(value.data);
    }).catchError((e) {
      print(e.toString());
    });

    return response;
  }

  Future<Get_list_gallery_json> get_list_gallery({
    @required String token_id,
  }) async {
    Get_list_gallery_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/get_list_gallery',
      data: formData,
    )
        .then((value) {
      response = Get_list_gallery_json.fromJson(value.data);
    });

    return response;
  }

  Future<Response> delete_image({
    @required String token_id,
    @required int img_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "img_id": img_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_image',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Response> add_img({
    @required String token_id,
    @required File file,
  }) async {
    Response response;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,

      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
    });
    response = await dio.post(paseurl + '/provider/add_img', data: formData);
    return response;
  }

  Future<Get_all_visitor_json> get_all_visitor({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_visitor_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_visitor',
      data: formData,
    )
        .then((value) {
      data = Get_all_visitor_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_visitor({
    @required String token_id,
    @required String visitor_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "visitor_id": visitor_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_visitor',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Get_all_order_json> get_all_order({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_order_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_order',
      data: formData,
    )
        .then((value) {
      data = Get_all_order_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_all_user_coupons_json> get_all_user_coupons({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_user_coupons_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_user_coupons',
      data: formData,
    )
        .then((value) {
      data = Get_all_user_coupons_json.fromJson(value.data);
    });

    return data;
  }
  Future<Get_all_user_coupons_json> get_all_qr_points({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_user_coupons_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_points_qr',
      data: formData,
    )
        .then((value) {
      data = Get_all_user_coupons_json.fromJson(value.data);
    });
    return data;
  }

  Future<Get_all_user_coupons_json> filter_points({
    @required String token_id,
    @required String startDate,
    @required String endDate,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_user_coupons_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "start_date": startDate,
      "end_date": endDate,
      "limit": limit,
      "page_number": page_number,

    });
    await dio
        .post(
      paseurl + '/provider/search_date_qr',
      data: formData,
    )
        .then((value) {
          print(value.data);
      data = Get_all_user_coupons_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_user_coupon({
    @required String token_id,
    @required String coupon_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "coupon_id": coupon_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_user_coupon',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Response> check_coupon({
    @required String token_id,
    @required String coupon,
    @required int actionKey,
  }) async {
    Response data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "action_key": actionKey,
      "coupon": coupon,
    });
    await dio
        .post(
      paseurl + '/provider/check_coupon',
      data: formData,
    )
        .then((value) {
      data = value;
      print(value.data);
    });

    return data;
  }

  Future<Preparation_points_json> preparation_points({
    @required String token_id,
  }) async {
    Preparation_points_json data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/preparation_points',
      data: formData,
    )
        .then((value) {
      data = Preparation_points_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_points({
    @required String token_id,
    @required String total_points,
    @required String total_points_qr,
  }) async {
    Response data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "total_points": total_points,
      "total_points_qr": total_points_qr,
    });
    await dio
        .post(
      paseurl + '/provider/edit_points',
      data: formData,
    )
        .then((value) {
      data = value;
    }).catchError((error){
      print(error.toString());
    });

    return data;
  }

  Future<Get_all_user_coupons_json> check_phone({
    @required String token_id,
    @required String phone,
  }) async {
    var data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "phone": phone,
    });
    await dio
        .post(
      paseurl + '/provider/check_phone',
      data: formData,
    )
        .then((value) {
          print(value.data);
      data = Get_all_user_coupons_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> logout({
    @required String token_id,
    @required String firebase_token,
  }) async {
    Response data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "firebase_token": firebase_token,
    });
    await dio
        .post(
      paseurl + '/provider/logout',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Response> save_QR({
    @required String token_id,
    @required String file,
  }) async {
    Response response;
    String fileName = 'o';

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "file": file
    });
    response = await dio.post(paseurl + '/provider/save_QR', data: formData);
    return response;
  }

  Future<Get_all_visitor_points_json> get_all_visitor_points({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_visitor_points_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_visitor_points',
      data: formData,
    )
        .then((value) {
      data = Get_all_visitor_points_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_points({
    @required String token_id,
    @required String visitor_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "visitor_id": visitor_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_points',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Response> empty_points({
    @required String total_points,
    @required String phone,
    @required String token_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "total_points": total_points,
      "phone": phone,
    });
    await dio
        .post(
      paseurl + '/provider/empty_points',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Ios_login_json> ios_login() async {
    Ios_login_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
    });
    await dio
        .post(paseurl + '/pages/ios_login',
            // "https://wasselni.ps/pages/ios_login",
            data: formData)
        .then((value) {
      print('oooooooooooooooooooooooooooooooooooooooooo');
      print(value.data);
      data = Ios_login_json.fromJson(value.data);
    }).catchError((e) {
      print(e.toString());
    });

    return data;
  }

  Future<Get_current_orders_json> get_current_orders(
      {@required String token_id}) async {
    Get_current_orders_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(paseurl + '/provider/get_current_orders',
            // "https://wasselni.ps/pages/ios_login",
            data: formData)
        .then((value) {
      print('oooooooooooooooooooooooooooooooooooooooooo');
      print(value.data);
      data = Get_current_orders_json.fromJson(value.data);
    }).catchError((e) {
      print(e.toString());
    });

    return data;
  }

  Future<Get_Waiting_Orders_json> get_waiting_orders({
    @required String token_id,
  }) async {
    Get_Waiting_Orders_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/get_waiting_orders',
      data: formData,
    )
        .then((value) {
          print(value.data);
      data = Get_Waiting_Orders_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Response> update_order({
    @required String token_id,
    @required String id_order,
    @required int key_action,
  }) async {
    Response data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_order": id_order,
      "key_action": key_action,
    });
    await dio
        .post(
      paseurl + '/provider/update_order',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Get_order_details_json> get_order_details({
    @required int id_order,
    @required String token_id,
  }) async {
    Get_order_details_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "id_order": id_order,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/get_order_details',
      data: formData,
    )
        .then((value) {
      data = Get_order_details_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Get_previous_orders_json> get_previous_orders({
    @required String token_id,
  }) async {
    Get_previous_orders_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/get_previous_orders',
      data: formData,
    )
        .then((value) {
      data = Get_previous_orders_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Cancel_order_json> delete_order({
    @required String token_id,
    @required int order_id,
  }) async {
    Cancel_order_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_order": order_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_order',
      data: formData,
    )
        .then((value) {
      data = Cancel_order_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Gate_list_rate_json> gate_list_rate({
    @required String token_id,
  }) async {
    Gate_list_rate_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/gate_list_rate',
      data: formData,
    )
        .then((value) {
          print(value.data);
      data = Gate_list_rate_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Gate_list_location_json> gate_list_location({
    @required String token_id,
  }) async {
    Gate_list_location_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/gate_list_location',
      data: formData,
    )
        .then((value) {
      print(value);
      data = Gate_list_location_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Get_all_gallery_offers_json> get_all_gallery_offers({
    @required String token_id,
    @required int limit,
    @required int page_number,
    @required int offer_id,
  }) async {
    Get_all_gallery_offers_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
      "offer_id": offer_id
    });
    await dio
        .post(
      paseurl + '/provider/get_all_gallery_offers',
      data: formData,
    )
        .then((value) {
      data = Get_all_gallery_offers_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future delete_img_gallery_offer({
    @required String token_id,
    @required String img_id,
  }) async {
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "img_id": img_id,
    });
    await dio
        .post(
          paseurl + '/provider/delete_img_gallery_offer',
          data: formData,
        )
        .then((value) {});
    //  print(data.result.contactInfo[0].);
  }

  Future add_gallery_offer(
      {@required String token_id,
      @required int offer_id,
      @required File file}) async {
    Response response;
    String fileName = file.path.split('/').last;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "offer_id": offer_id,
      "file": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: new MediaType('image', 'png')),
    });
    await dio
        .post(
          paseurl + '/provider/add_gallery_offer',
          data: formData,
        )
        .then((value) {});
  }

  Future<Response> editPassword(
      {String phone,
      String password,
      String confirmPassword,
      String lang}) async {
    Response data;

    FormData formData = FormData.fromMap({
      "key": "1234567890",
      "phone": phone,
      "password": password,
      "lang": lang,
      "confirmpassword": confirmPassword,
    });
    await dio
        .post(
      paseurl + '/provider/change_password',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  final box = GetStorage();
  Future<Response> forgetPassword({String phone, String lang}) async {
    Response data;

    FormData formData =
        FormData.fromMap({"key": "1234567890", "phone": phone, "lang": lang});
    await dio
        .post(
      paseurl + '/provider/forget_password',
      data: formData,
    )
        .then((value) {
      data = value;
      print(data.data.toString());
      if (data.data["status"]) {
        NotificationHelper().initializeNotification();
        NotificationHelper().requestIOSPermissions();
        NotificationHelper()
            .displayNotification(title: "Code", body: data.data["result"])
            .then((value) {
          box.write('code', data.data["result"]);
        });
      }
    });

    return data;
  }

  Future<TagsModel> getAllTags({
    @required String token_id,
    @required String pageNumber,
    @required String limit,
  }) async {
    TagsModel data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": pageNumber,
    });
    await dio
        .post(
      paseurl + '/provider/gate_list_tags',
      data: formData,
    )
        .then((value) {
      data = TagsModel.fromJson(value.data);
      print(value);
    });
    return data;
  }

  Future editTags({
    @required String token_id,
    @required String tagName,
    @required int tagId,
  }) async {
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "tage_name": tagName,
      "tag_id": tagId,
    });
    await dio
        .post(
          paseurl + '/provider/edit_tag',
          data: formData,
        )
        .then((value) {});
    //  print(data.result.contactInfo[0].);
  }

  Future deleteTags({
    @required String token_id,
    @required int tagId,
  }) async {
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "tag_id": tagId,
    });
    await dio
        .post(
      paseurl + '/provider/delete_tag',
      data: formData,
    )
        .then((value) {
      print(value);
    });
    // print(value);
  }

  Future addTags({
    @required String token_id,
    @required String tagName,
  }) async {
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "tag_name": tagName,
    });
    await dio
        .post(
          paseurl + '/provider/add_tag',
          data: formData,
        )
        .then((value) {});
    //  print(data.result.contactInfo[0].);
  }

  Future getTagsDetails({
    @required String token_id,
    @required int tagId,
  }) async {
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "tag_id": tagId,
    });
    await dio
        .post(
      paseurl + '/provider/get_tag_details',
      data: formData,
    )
        .then((value) {
      print(value.data);
    });
    //  print(data.result.contactInfo[0].);
  }

  Future deleteRate({
    @required String token_id,
    @required int rateId,
  }) async {
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "rate_id": rateId,
    });
    await dio
        .post(
      paseurl + '/provider/delete_rate',
      data: formData,
    )
        .then((value) {
      print(value.data);
    });
    //  print(data.result.contactInfo[0].);
  }

  Future<Response> addPoints({
    @required String token_id,
    @required String coupon,
  }) async {
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "coupon": coupon,
    });
    Response response = await dio.post(
      paseurl + '/provider/add_points',
      data: formData,
    );
    print(response);
    return response;
    //  print(data.result.contactInfo[0].);
  }
}
