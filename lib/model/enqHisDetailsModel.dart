class EnqHisDetails {
  List<Master>? master;
  List<Detail>? detail;

  EnqHisDetails({this.master, this.detail});

  EnqHisDetails.fromJson(Map<String, dynamic> json) {
    if (json['master'] != null) {
      master = <Master>[];
      json['master'].forEach((v) {
        master!.add(new Master.fromJson(v));
      });
    }
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.master != null) {
      data['master'] = this.master!.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Master {
  String? ownerName;
  String? companyName;
  String? custId;
  String? contactNum;
  String? custInfo;
  String? landmark;
  String? priorityLevel;

  Master(
      {this.ownerName,
      this.companyName,
      this.custId,
      this.contactNum,
      this.custInfo,
      this.landmark,
      this.priorityLevel});

  Master.fromJson(Map<String, dynamic> json) {
    ownerName = json['owner_name'];
    companyName = json['company_name'];
    custId = json['cust_id'];
    contactNum = json['contact_num'];
    custInfo = json['cust_info'];
    landmark = json['landmark'];
    priorityLevel = json['priority_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner_name'] = this.ownerName;
    data['company_name'] = this.companyName;
    data['cust_id'] = this.custId;
    data['contact_num'] = this.contactNum;
    data['cust_info'] = this.custInfo;
    data['landmark'] = this.landmark;
    data['priority_level'] = this.priorityLevel;
    return data;
  }
}

class Detail {
  String? enqId;
  String? productId;
  String? productName;
  String? qty;
  String? productInfo;

  Detail(
      {this.enqId,
      this.productId,
      this.productName,
      this.qty,
      this.productInfo});

  Detail.fromJson(Map<String, dynamic> json) {
    enqId = json['enq_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    qty = json['qty'];
    productInfo = json['product_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enq_id'] = this.enqId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['qty'] = this.qty;
    data['product_info'] = this.productInfo;
    return data;
  }
}