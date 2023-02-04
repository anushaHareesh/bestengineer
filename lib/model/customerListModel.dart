class CustomerListModel {
  List<CustomerList>? customerList;

  CustomerListModel({this.customerList});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    if (json['customer_list'] != null) {
      customerList = <CustomerList>[];
      json['customer_list'].forEach((v) {
        customerList!.add(new CustomerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerList != null) {
      data['customer_list'] =
          this.customerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerList {
  String? customerId;
  String? companyName;
  String? companyAdd1;
  String? phone1;
  String? landmark;
  String? ownerName;

  CustomerList(
      {this.customerId,
      this.companyName,
      this.companyAdd1,
      this.phone1,
      this.landmark,
      this.ownerName});

  CustomerList.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    companyName = json['company_name'];
    companyAdd1 = json['company_add1'];
    phone1 = json['phone_1'];
    landmark = json['landmark'];
    ownerName = json['owner_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['company_name'] = this.companyName;
    data['company_add1'] = this.companyAdd1;
    data['phone_1'] = this.phone1;
    data['landmark'] = this.landmark;
    data['owner_name'] = this.ownerName;
    return data;
  }
}
