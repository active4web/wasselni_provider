class Get_all_products_JSON {
  String message;
  int messageid;
  bool status;
  int total;
  Result result;

  Get_all_products_JSON(
      {this.message, this.messageid, this.status, this.total, this.result});

  Get_all_products_JSON.fromJson(Map<String, dynamic> json) {
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
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<AllProducts> allProducts;

  Result({this.allProducts});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_products'] != null) {
      allProducts = new List<AllProducts>();
      json['all_products'].forEach((v) {
        allProducts.add(new AllProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allProducts != null) {
      data['all_products'] = this.allProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllProducts {
  String productImage;
  String productName;
  String stock;
  String productNameEn;
  String nameTr;
  String productId;
  String price;

  AllProducts(
      {this.productImage,
        this.productName,
        this.stock,
        this.productNameEn,
        this.nameTr,
        this.productId,
        this.price});

  AllProducts.fromJson(Map<String, dynamic> json) {
    productImage = json['product_image'];
    productName = json['product_name'];
    stock = json['stock'];
    productNameEn = json['product_name_en'];
    nameTr = json['name_tr'];
    productId = json['product_id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image'] = this.productImage;
    data['product_name'] = this.productName;
    data['stock'] = this.stock;
    data['product_name_en'] = this.productNameEn;
    data['name_tr'] = this.nameTr;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    return data;
  }
}
