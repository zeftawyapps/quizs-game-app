import 'dart:async';

import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/interface/sources/dep/i_dep_http_source.dart';
import 'package:quiz_module/medules_test.dart';
import 'package:quiz_module/model/depratment.dart';
import 'package:quiz_module/model/quiz_model.dart';
import 'package:quiz_module/reposetory/quiz_firebase_repo.dart';
import 'package:quiz_module/source/department_firebase_source.dart';
import 'package:quiz_module/source/https/dep_http_source.dart';
import 'package:quiz_module/source/quiz_firebase_source.dart';
 import 'package:quiz_module/utilis/models/base_data_model.dart';

class QuizBloc {
   String quession ="question";
  String choise1 ="choise1";
  String choise2 ="choise2";
  String choise3 ="choise3";
  String choise4 ="choise4";
  String answer ="answer";
  String depDocid ="depId";
QuizModuleBaseBloc<QuizBaseModel> bloc = QuizModuleBaseBloc<QuizBaseModel>();
  QuizModuleBaseBloc<List<QuizBaseModel>> bloclist = QuizModuleBaseBloc<List<QuizBaseModel>>();

QuizRepo? quizRepo ;
void addQuizs({required Map<String, dynamic> map}) async {
  quizRepo = QuizRepo(   inputSource:  QuizFirebaseSource.inputs(quiz:QuizBaseModel(depId: map[depDocid],
      question: map[quession] ,
      choose1: map[choise1] , choose2: map[choise2] , choose3: map[choise3] , choose4: map[choise4] ,

      answer: map['answer']  )));


  bloc.loadingState();
  Timer(Duration(seconds: 1), () {
    bloc.successState( QuizBaseModel.fromJson(map, ""));
  });
  var result =await quizRepo!.addData();
  result.pick(onData: (v) {
    bloc.successState( QuizBaseModel.fromJson(v.map, v.depId));
  }, onError: (error) {
    bloc.failedState(error, () {});
  });
}
   void editQuizs({required Map<String, dynamic> map ,required   String id }) async {
     quizRepo = QuizRepo(  inputSource:  QuizFirebaseSource.inputs(quiz:QuizBaseModel(depId: map[depDocid],
         question: map[quession] ,
         choose1: map[choise1] , choose2: map[choise2] , choose3: map[choise3] , choose4: map[choise4] ,

         answer: map['answer']  )));


     bloc.loadingState();
     Timer(Duration(seconds:1), () {
       bloc.successState( QuizBaseModel.fromJson(map, ""));
     });
     var result =await quizRepo!.updateData(id);
     result.pick(onData: (v) {
       bloc.successState( QuizBaseModel.fromJson(v.map, v.depId));
     }, onError: (error) {
       bloc.failedState(error, () {});
     });
   }

void getQuizs(String depDocaId )async{
  quizRepo = QuizRepo(depHttpSoucre: QuizGameHttpSource() );
  bloclist.loadingState();
 var result = await  quizRepo!.getQuiz(depDocaId);
 result.pick(onData: (v) {
    bloclist.successState( v as List<QuizBaseModel>);
  }, onError: (error) {
    bloclist.failedState(error, () {});
  });
}
   void getQuizsDashboard(String depDocaId )async{
     quizRepo = QuizRepo(inputSource: QuizFirebaseSource(depDocaId)  );
     bloclist.loadingState();
     var result = await  quizRepo!.getData(null );
     result.pick(onData: (v) {
       bloclist.successState( v as List<QuizBaseModel>);
     }, onError: (error) {
       bloclist.failedState(error, () {});
     });
   }
 Future<bool> deleteQuizs(String? id, String depId)async   {

    quizRepo = QuizRepo( inputSource: QuizFirebaseSource( depId  ));

    bloc.loadingState();
    var result =await  quizRepo!.deleteData(id!);
    result.pick(onData: (v) {
      bloc.successState( QuizBaseModel.fromJson(v.map, v.depId));
      return true;
    }, onError: (error) {
      bloc.failedState(error, () {});
      return false;
    });
    return false;
  }


}
