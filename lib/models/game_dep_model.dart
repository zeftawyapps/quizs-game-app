class GameDepModel{

  // set properties is game_dep_id, game_dep_name , score , currect_answer , wrong_answer , total_question
  String ? game_dep_id ;
  String ? game_dep_name ;
  int ? score ;
  int ? currect_answer ;
  int ? wrong_answer ;
  int ? total_question ;
  // set constructor
  GameDepModel({this.game_dep_id , this.game_dep_name , this.score , this.currect_answer , this.wrong_answer , this.total_question});
  // set factory method json
 factory GameDepModel.fromJson(Map<String , dynamic> json){
   return GameDepModel(
     game_dep_id: json['game_dep_id'] == null ? null : json['game_dep_id'],
     game_dep_name: json['game_dep_name'] == null ? null : json['game_dep_name'],
     score: json['score'] == null ? null : json['score'],
     currect_answer: json['currect_answer'] == null ? null : json['currect_answer'],
     wrong_answer: json['wrong_answer'] == null ? null : json['wrong_answer'],
     total_question: json['total_question'] == null ? null : json['total_question'],
   );
 }
  // set method to json
  Map<String , dynamic> toJson(){
    var map = <String , dynamic>{};
    map['game_dep_id'] = game_dep_id ;
    map['game_dep_name'] = game_dep_name ;
    map['score'] = score ;
    map['currect_answer'] = currect_answer ;
    map['wrong_answer'] = wrong_answer ;
    map['total_question'] = total_question ;
    return map ;
  }
 // to records
  List<GameDepModel> toList(List<Map<String , dynamic>> json){
    return json.map((e) => GameDepModel.fromJson(e)).toList();
  }

}