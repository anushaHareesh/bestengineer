class DatatChartModel {
  List<UserCntCnfrmd>? userCntCnfrmd;

  DatatChartModel({this.userCntCnfrmd});

  DatatChartModel.fromJson(Map<String, dynamic> json) {
    if (json['user_cnt_cnfrmd'] != null) {
      userCntCnfrmd = <UserCntCnfrmd>[];
      json['user_cnt_cnfrmd'].forEach((v) {
        userCntCnfrmd!.add(new UserCntCnfrmd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userCntCnfrmd != null) {
      data['user_cnt_cnfrmd'] =
          this.userCntCnfrmd!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCntCnfrmd {
  String? measure;
  String? domain;

  UserCntCnfrmd({this.measure, this.domain});

  UserCntCnfrmd.fromJson(Map<String, dynamic> json) {
    measure = json['measure'].toDouble();
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['measure'] = this.measure;
    data['domain'] = this.domain;
    return data;
  }
}
