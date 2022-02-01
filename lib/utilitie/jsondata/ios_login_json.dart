class Ios_login_json {
  String message;
  int codenum;
  bool status;
  int loginId;
  String tokenId;

  Ios_login_json(
      {this.message, this.codenum, this.status, this.loginId, this.tokenId});

  Ios_login_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    codenum = json['codenum'];
    status = json['status'];
    loginId = json['login_id'];
    tokenId = json['token_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['codenum'] = this.codenum;
    data['status'] = this.status;
    data['login_id'] = this.loginId;
    data['token_id'] = this.tokenId;
    return data;
  }
}
