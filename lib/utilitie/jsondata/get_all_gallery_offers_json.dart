class Get_all_gallery_offers_json {
  String? message;
  int? messageid;
  bool? status;
  int? total;
  Result? result;

  Get_all_gallery_offers_json(
      {this.message, this.messageid, this.status, this.total, this.result});

  Get_all_gallery_offers_json.fromJson(Map<String, dynamic> json) {
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
  List<AllGalleries>? allGalleries;

  Result({this.allGalleries});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_galleries'] != null) {
      allGalleries = <AllGalleries>[];
      json['all_galleries'].forEach((v) {
        allGalleries?.add(new AllGalleries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allGalleries != null) {
      data['all_galleries'] = this.allGalleries?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllGalleries {
  String? offerImage;
  String? imgId;

  AllGalleries({this.offerImage, this.imgId});

  AllGalleries.fromJson(Map<String, dynamic> json) {
    offerImage = json['offer_image'];
    imgId = json['img_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_image'] = this.offerImage;
    data['img_id'] = this.imgId;
    return data;
  }
}
