class Gate_list_rate_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Gate_list_rate_json({this.message, this.codenum, this.status, this.result});

  Gate_list_rate_json.fromJson(Map<String, dynamic> json) {
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
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<AllRate> allRate;

  Result({this.allRate});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_rate'] != null) {
      allRate = new List<AllRate>();
      json['all_rate'].forEach((v) {
        allRate.add(new AllRate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allRate != null) {
      data['all_rate'] = this.allRate.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllRate {
  String username;
  String userrate;
  String usercomment;
  int rateId;

  AllRate({this.username, this.userrate, this.usercomment, this.rateId});

  AllRate.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userrate = json['userrate'];
    usercomment = json['usercomment'];
    rateId = json['rate_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['userrate'] = this.userrate;
    data['usercomment'] = this.usercomment;
    data['rate_id'] = this.rateId;
    return data;
  }
}
