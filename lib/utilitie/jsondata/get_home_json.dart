class Get_home_json {
  String? message;
  int? codenum;
  bool? status;
  Result? result;

  Get_home_json({this.message, this.codenum, this.status, this.result});

  Get_home_json.fromJson(Map<String, dynamic> json) {
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
  int? totalProduct;
  String? totalViews;
  String? datePackege;
  String? startDate;
  String? endDate;
  int? keyUpdate;
  String? totalPoints;
  String? totalSelling;
  String? totalOrders;
  String? serviceCoupon;
  int? type;
  String? showOrder;
  int? totalListLocations;
  String? totalRate;
  String? locationDisplay;
  String? showRate;
  String? locationTitle;
  String? rateTitle;
  String? copounDisplay;
  String? scanDisplay;
  String? pointsDisplay;
  String? offersDisplay;
  String? branchesDisplay;

  Result(
      {this.totalProduct,
        this.totalViews,
        this.datePackege,
        this.startDate,
        this.endDate,
        this.keyUpdate,
        this.totalPoints,
        this.totalSelling,
        this.totalOrders,
        this.serviceCoupon,
        this.type,
        this.showOrder,
        this.totalListLocations,
        this.totalRate,
        this.locationDisplay,
        this.showRate,
        this.locationTitle,
        this.rateTitle,
        this.copounDisplay,
        this.scanDisplay,
        this.pointsDisplay,
        this.offersDisplay,
        this.branchesDisplay});

  Result.fromJson(Map<String, dynamic> json) {
    totalProduct = json['total_product'];
    totalViews = json['total_views'];
    datePackege = json['date_packege'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    keyUpdate = json['key_update'];
    totalPoints = json['total_points'];
    totalSelling = json['total_selling'];
    totalOrders = json['total_orders'];
    serviceCoupon = json['service_coupon'];
    type = json['type'];
    showOrder = json['show_order'];
    totalListLocations = json['total_list_locations'];
    totalRate = json['total_rate'];
    locationDisplay = json['location_display'];
    showRate = json['show_rate'];
    locationTitle = json['location_title'];
    rateTitle = json['rate_title'];
    copounDisplay = json['copoun_display'];
    scanDisplay = json['scan_display'];
    pointsDisplay = json['points_display'];
    offersDisplay = json['offers_display'];
    branchesDisplay = json['branches_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_product'] = this.totalProduct;
    data['total_views'] = this.totalViews;
    data['date_packege'] = this.datePackege;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['key_update'] = this.keyUpdate;
    data['total_points'] = this.totalPoints;
    data['total_selling'] = this.totalSelling;
    data['total_orders'] = this.totalOrders;
    data['service_coupon'] = this.serviceCoupon;
    data['type'] = this.type;
    data['show_order'] = this.showOrder;
    data['total_list_locations'] = this.totalListLocations;
    data['total_rate'] = this.totalRate;
    data['location_display'] = this.locationDisplay;
    data['show_rate'] = this.showRate;
    data['location_title'] = this.locationTitle;
    data['rate_title'] = this.rateTitle;
    data['copoun_display'] = this.copounDisplay;
    data['scan_display'] = this.scanDisplay;
    data['points_display'] = this.pointsDisplay;
    data['offers_display'] = this.offersDisplay;
    data['branches_display'] = this.branchesDisplay;
    return data;
  }
}
