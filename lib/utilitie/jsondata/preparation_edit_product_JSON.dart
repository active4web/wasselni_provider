class Preparation_edit_product_JSON {
  String? message;
  int? messageid;
  bool? status;
  Result? result;

  Preparation_edit_product_JSON(
      {this.message, this.messageid, this.status, this.result});

  Preparation_edit_product_JSON.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    messageid = json['Messageid'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Messageid'] = this.messageid;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result?.toJson();
    }
    return data;
  }
}

class Result {
  List<AllProducts>? allProducts;

  Result({this.allProducts});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_products'] != null) {
      allProducts = <AllProducts>[];
      json['all_products'].forEach((v) {
        allProducts?.add(new AllProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allProducts != null) {
      data['all_products'] = this.allProducts?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllProducts {
  String? productImage;
  String? productName;
  String? productNameEn;
  String? nameTr;
  String? productDescription;
  String? productDescriptionEn;
  String? descriptionTr;
  String? stock;
  String? productId;
  String? newPrice;

  AllProducts(
      {this.productImage,
        this.productName,
        this.productNameEn,
        this.nameTr,
        this.productDescription,
        this.productDescriptionEn,
        this.descriptionTr,
        this.stock,
        this.productId,
        this.newPrice});

  AllProducts.fromJson(Map<String, dynamic> json) {
    productImage = json['product_image'];
    productName = json['product_name'];
    productNameEn = json['product_name_en'];
    nameTr = json['name_tr'];
    productDescription = json['product_description'];
    productDescriptionEn = json['product_description_en'];
    descriptionTr = json['description_tr'];
    stock = json['stock'];
    productId = json['product_id'];
    newPrice = json['new_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image'] = this.productImage;
    data['product_name'] = this.productName;
    data['product_name_en'] = this.productNameEn;
    data['name_tr'] = this.nameTr;
    data['product_description'] = this.productDescription;
    data['product_description_en'] = this.productDescriptionEn;
    data['description_tr'] = this.descriptionTr;
    data['stock'] = this.stock;
    data['product_id'] = this.productId;
    data['new_price'] = this.newPrice;
    return data;
  }
}
