import 'package:mongo_dart/mongo_dart.dart';

class Person
{
  Person({
    this.userName,
    this.email,
    this.id,
    this.passWord,
    this.isLogin = false,
    this.result,
    this.method,
    this.desc,
  });

  factory Person.fromJson(dynamic jsonObj)
  {
    String id;
    if(jsonObj["_id"] == null)
    {
      id = null;
    }
    else if(jsonObj["_id"].runtimeType == String)
    {
      id = jsonObj["_id"] as String;
    }
    else
    {
      //final ObjectId kk = jsonObj["_id"] as ObjectId;
      //id = kk.toHexString();
      id = (jsonObj["_id"] as ObjectId).toHexString();
    }
    return Person(
      id: id,
      userName: jsonObj["userName"] as String,
      email: jsonObj["email"] as String,
      isLogin: jsonObj["isLogin"] as bool,
      passWord: jsonObj["passWord"] as String,
//    userNameList: (jsonObj["userNameList"] as Iterable).map((v)=> v.toString()).toList(),
//    passWordList: (jsonObj["passWordList"] as Iterable).map((v)=> v.toString()).toList(),
      result: jsonObj["result"] as bool,
      method: jsonObj["method"] as String,
      desc: jsonObj["desc"] as String,
    );
  }

  final String id;
  final String userName;
  final String email;
  String passWord;
  bool isLogin;
  bool result;
  String method;
  String desc;

  Map<String, dynamic> toJson()
  {
    return {
      "_id": id,
      "userName": userName,
      "email": email,
      "passWord": passWord,
//      "userNameList": userNameList,
//      "passWordList": passWordList,
      "isLogin": isLogin,
      "result": result,
      "method": method,
      "desc": desc,
    };
  }

}
