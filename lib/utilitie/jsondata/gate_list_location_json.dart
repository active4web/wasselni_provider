class Gate_list_location_json {
  String? message;
  int? codenum;
  bool? status;
  Result? result;

  Gate_list_location_json(
      {this.message, this.codenum, this.status, this.result});

  Gate_list_location_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    codenum = json['codenum'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['codenum'] = this.codenum;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result?.toJson();
    }
    return data;
  }
}

class Result {
  List<AllListLocation>? allListLocation;

  Result({this.allListLocation});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_list_location'] != null) {
      allListLocation = <AllListLocation>[];
      json['all_list_location'].forEach((v) {
        allListLocation?.add(new AllListLocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allListLocation != null) {
      data['all_list_location'] =
          this.allListLocation?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllListLocation {
  String? username;
  String? phone;
  String? lat;
  String? lag;
  String? comment;
  int? locationId;

  AllListLocation(
      {this.username,
        this.phone,
        this.lat,
        this.lag,
        this.comment,
        this.locationId});

  AllListLocation.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
    lat = json['lat'];
    lag = json['lag'];
    comment = json['comment'];
    locationId = json['location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['lat'] = this.lat;
    data['lag'] = this.lag;
    data['comment'] = this.comment;
    data['location_id'] = this.locationId;
    return data;
  }
}
