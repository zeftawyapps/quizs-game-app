import 'package:users_module/modele/base_model/base_user_module.dart';

class AppuserModel extends UsersBaseModel {
  static const  String  ageKey = "age" ;
 int ? level  ;
 String ? address ;
 String ? phone ;
 int ? type = 0 ;
 String ? image ;
 int? score = 0 ;
 int? totalMoney = 200 ;

  AppuserModel ({this.totalMoney , this.score ,    this.level ,String? address   ,    String? id ,    String? name ,    String? email  })
      :super (email: email , uid:  id , name:  name );

  AppuserModel.   formJson(Map<String , dynamic> json ){
    uid = json['uid']== null ? null  : json['uid'] ;
    name = json['name']== null ? null  : json['name'] ;
    email = json['email']== null ? null  : json['email'] ;
    address = json['address'] == null ? null : json['address'];
    phone = json['phone'] == null ? null : json['phone'];
    type = json['type'] == null ? 0 : json['type'];
    level = json['level'] == null ? null : json['level'];
    image = json['imguri'] == null ? null : json['imguri'];
    score = json['scores'] == null ? 0 : json['scores'];
    totalMoney = json['mony'] == null ? 200 : json['mony'];

  }
  Map<String, dynamic> toJson() {
    final _data =  super.map;
    _data['id'] = uid ;
    _data['name'] = name ;
    _data['email'] = email ;
    _data['address'] = address ;
    _data['phone'] = phone ;
    _data['type'] = type??0 ;
    _data['level'] = level ;
    _data['imguri'] = image ;
    _data['scores'] = score ;
    _data['mony'] = totalMoney ;
    return _data ;
  }
}