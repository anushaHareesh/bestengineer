class ProductListModel {
  List<ProductList>? productList;

  ProductListModel({this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    if (json['product_list'] != null) {
      productList = <ProductList>[];
      json['product_list'].forEach((v) {
        productList!.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productList != null) {
      data['product_list'] = this.productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String? productId;
  String? productName;
  String? batchCode;
  String? sRate1;
  String? sRate2;
  String? description;
  String? tax_perc;


  ProductList(
      {this.productId,
      this.productName,
      this.batchCode,
      this.sRate1,
      this.sRate2,
      this.description,this.tax_perc});

  ProductList.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    batchCode = json['batch_code'];
    sRate1 = json['s_rate_1'];
    sRate2 = json['s_rate_2'];
    description = json['description'];
    tax_perc = json['tax_perc'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['batch_code'] = this.batchCode;
    data['s_rate_1'] = this.sRate1;
    data['s_rate_2'] = this.sRate2;
    data['description'] = this.description;
    data['tax_perc'] = this.tax_perc;


    return data;
  }
}
