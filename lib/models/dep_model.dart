import 'package:quiz_module/model/depratment.dart';

class QuizDep extends DepartmentBaseModel{
  QuizDep({super.id, required  super.depName, this.isPublish = false , this.sort = 0 ,
  this.mony = 0
  })   ;
  bool isPublish = false;
  int sort = 0;
  int mony = 0;
  factory QuizDep.fromJson(Map<String, dynamic> json, String id) {
    return QuizDep(
      id: id,

      depName: json['depName'] == null ? null : json['depName'],
      isPublish: json['isPublish'] ?? false  ,
      sort: json['sort'] ?? 0,
      mony: json['mony'] ?? 0,
    );
  }
@override
  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map['isPublish'] = isPublish;
    map['sort'] = sort;
    map['mony'] = mony;
    return  map;
  }
}