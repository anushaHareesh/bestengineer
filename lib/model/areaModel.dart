class AreaModel {
  List<AreaList>? areaList;

  AreaModel({this.areaList});

  AreaModel.fromJson(Map<String, dynamic> json) {
    if (json['area_list'] != null) {
      areaList = <AreaList>[];
      json['area_list'].forEach((v) {
        areaList!.add(new AreaList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.areaList != null) {
      data['area_list'] = this.areaList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreaList {
  String? areaId;
  String? areaName;

  AreaList({this.areaId, this.areaName});

  AreaList.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    areaName = json['area_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    return data;
  }
}
