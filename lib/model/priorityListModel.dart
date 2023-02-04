class PriorityListModel {
  List<PriorityLevel>? priorityLevel;

  PriorityListModel({this.priorityLevel});

  PriorityListModel.fromJson(Map<String, dynamic> json) {
    if (json['priority_level'] != null) {
      priorityLevel = <PriorityLevel>[];
      json['priority_level'].forEach((v) {
        priorityLevel!.add(new PriorityLevel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.priorityLevel != null) {
      data['priority_level'] =
          this.priorityLevel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PriorityLevel {
  String? lId;
  String? level;
  String? lColor;

  PriorityLevel({this.lId, this.level, this.lColor});

  PriorityLevel.fromJson(Map<String, dynamic> json) {
    lId = json['l_id'];
    level = json['level'];
    lColor = json['l_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['l_id'] = this.lId;
    data['level'] = this.level;
    data['l_color'] = this.lColor;
    return data;
  }
}
