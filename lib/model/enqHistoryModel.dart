class EnqHistoryModel {
  List<EnqList>? enqList;

  EnqHistoryModel({this.enqList});

  EnqHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['enq_list'] != null) {
      enqList = <EnqList>[];
      json['enq_list'].forEach((v) {
        enqList!.add(new EnqList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.enqList != null) {
      data['enq_list'] = this.enqList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EnqList {
  String? enqId;
  String? enqCode;
  String? ownerName;
  String? companyName;
  String? custId;
  String? addedOn;
  String? verify_status;
  String? l_color;

  EnqList(
      {this.enqId,
      this.enqCode,
      this.ownerName,
      this.companyName,
      this.custId,
      this.addedOn,
      this.verify_status,
      this.l_color});

  EnqList.fromJson(Map<String, dynamic> json) {
    enqId = json['enq_id'];
    enqCode = json['enq_code'];
    ownerName = json['owner_name'];
    companyName = json['company_name'];
    custId = json['cust_id'];
    addedOn = json['added_on'];
    verify_status = json['verify_status'];
    l_color = json['l_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enq_id'] = this.enqId;
    data['enq_code'] = this.enqCode;
    data['owner_name'] = this.ownerName;
    data['company_name'] = this.companyName;
    data['cust_id'] = this.custId;
    data['added_on'] = this.addedOn;
    data['verify_status'] = this.verify_status;
    data['l_color'] = this.l_color;

    return data;
  }
}
