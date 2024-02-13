class Get_all_user_coupons_json {
  String? message;
  int? messageid;
  bool? status;
  dynamic total;
  Result? result;

  Get_all_user_coupons_json(
      {this.message, this.messageid, this.status, this.total, this.result});

  Get_all_user_coupons_json.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    messageid = json['Messageid'];
    status = json['status'];
    total = json['total'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Messageid'] = this.messageid;
    data['status'] = this.status;
    data['total'] = this.total;
    if (this.result != null) {
      data['result'] = this.result?.toJson();
    }
    return data;
  }
}

class Result {
  List<AllVisitoe>? allVisitoe;
  dynamic totalPoints;

  Result({this.allVisitoe});

  Result.fromJson(Map<String, dynamic> json) {
    totalPoints = json['total_points'];
    if (json['all_visitoe'] != null) {
      allVisitoe =<AllVisitoe>[];
      json['all_visitoe'].forEach((v) {
        allVisitoe?.add(new AllVisitoe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allVisitoe != null) {
      data['all_visitoe'] = this.allVisitoe?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllVisitoe {
  String? userName;
  String? date;
  dynamic serviceCoupon;
  String? userPhone;
  String? visitorId;


  AllVisitoe(
      {this.userName,
        this.date,
        this.serviceCoupon,
        this.userPhone,

        this.visitorId});

  AllVisitoe.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    date = json['date'];
    serviceCoupon = json['service_coupon'];
    userPhone = json['user_phone'];
    visitorId = json['visitor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['date'] = this.date;
    data['service_coupon'] = this.serviceCoupon;
    data['user_phone'] = this.userPhone;
    data['visitor_id'] = this.visitorId;
    return data;
  }
}
