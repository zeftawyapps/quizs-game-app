import 'package:shared_preferences/shared_preferences.dart';

// class AppSharedPreferences{
//   static shardPrefranceInit()async{
//    return  await    SharedPreferences.getInstance();}
//
//   void   IsUserRejised(Function(String email , String pass ) isRegistAction , Function() NotRegistAction  ) async  {
//     var data = await    SharedPreferences.getInstance();
//     bool isRejset = data.getBool(SharedPrefranceData.USER_ISREJESTED)?? false ;
//     if (isRejset){
//       String email = data.getString(SharedPrefranceData.USER_EMAIL)??"";
//       String pass = data.getString(SharedPrefranceData.USER_PASS )??"";
//       isRegistAction(email ,pass  );
//     } else {
//       NotRegistAction();
//     }
//   }
//   Future<String > getUid() async{
//     var value =   await  SharedPreferences.getInstance();
//     return value.  getString(SharedPrefranceData.USER_UID) ?? "";
//
//   }
//   void setDataInShardRefrace ({String? email, String? pass , String? uid })async {
//     var data = await    SharedPreferences.getInstance();
//     await data.setBool(SharedPrefranceData.USER_ISREJESTED, true  );
//     await   data.setString(SharedPrefranceData.USER_EMAIL,email ?? ""  );
//     await   data.setString(SharedPrefranceData.USER_PASS,pass?? ""  );
//     await   data.setString(SharedPrefranceData.USER_UID,uid ?? ""  );
//
//
//
//   }
//
//
// }