import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:coolme121server/coolme121server.dart';

class CheckDB
{
  static const String url =
      'mongodb://note8g2018:123456789@localhost:27017/flutter?authSource=admin';
//  static const String url =
//        'mongodb://admin:123456789@coolme.me:27017/flutter?authSource=admin';

  static Future<bool> UserName(String userName) async
  {
    mongo.Db db;

    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collection = db.collection('person');
    final Map<String, dynamic> userNameJson = await collection
        .findOne({'userName': userName});
    return userNameJson?.isNotEmpty?? false;
  }

  static Future<bool> Email(String email) async
  {
    mongo.Db db;
//    const String url =
//        'mongodb://note8g2018:123456789@localhost:27017/flutter?authSource=admin';
//    const String url =
//        'mongodb://admin:123456789@coolme.me:27017/flutter?authSource=admin';
    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collection = db.collection('person');
    final Map<String, dynamic> userNameJson = await collection
        .findOne({'email': email});
    return userNameJson?.isNotEmpty?? false;
  }

  static Future<bool> RegCheck(String userName, String email) async
  {
    mongo.Db db;
//    const String url =
//        'mongodb://note8g2018:123456789@localhost:27017/flutter?authSource=admin';
//    const String url =
//        'mongodb://admin:123456789@coolme.me:27017/flutter?authSource=admin';
    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collection = db.collection('person');
    final Map<String, dynamic> userNameJson = await collection
        .findOne({'userName': userName, 'email': email});
    return userNameJson?.isNotEmpty?? false;
  }

  static Future<void> RegSave(String userName, String email, String passWord,
      String ipAddress) async
  {
    mongo.Db db;
//    const String url =
//        'mongodb://note8g2018:123456789@localhost:27017/flutter?authSource=admin';
//    const String url =
//        'mongodb://admin:123456789@coolme.me:27017/flutter?authSource=admin';
    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collection = db.collection('person');
    final result = await collection.save({
      'userName': userName,
      'email': email,
      'passWord': passWord,
      'ipAddress': ipAddress,
      'registrationTimeUTC': DateTime.now().toUtc(),
      'isLogin': true,
    });
    print(result);

//    final Map<String, dynamic> userNameJson = await collection
//        .findOne({'userName': userName, 'email': email});
//    return userNameJson?.isNotEmpty?? false;
  }

  static Future<bool> checkLogin(String userName, String passWord) async
  {
    mongo.Db db;

    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collection = db.collection('person');
    final Map<String, dynamic> personJson = await collection
        .findOne({'userName': userName, 'passWord': passWord});
    return personJson?.isNotEmpty ?? false;
  }

  static Future<void> login(String userName, String passWord) async
  {
    mongo.Db db;

    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collection = db.collection('person');
    final Map<String, dynamic> personJson = await collection.findAndModify(
      query: {'userName': userName, 'passWord': passWord},
      returnNew: true,
      update: mongo.modify.set("isLogin", true),
    );
    //return Person.fromJson(personJson);
  }

  static Future<Person> loginPerson(String userName, String passWord) async
  {
    mongo.Db db;

    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collection = db.collection('person');
    final Map<String, dynamic> personJson = await collection.findAndModify(
      query: {'userName': userName, 'passWord': passWord},
      returnNew: true,
      update: mongo.modify.set("isLogin", true),
    );
//    Person pp = Person.fromJson(personJson);
//    print(pp);
    return Person.fromJson(personJson);
  }

  static Future<bool> logout(Person person) async {
    mongo.Db db;

    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collection = db.collection('person');
    final Map<String, dynamic> personJson = await collection.findAndModify(
      query: {'userName': person.userName, 'passWord': person.passWord},
      returnNew: true,
      update: mongo.modify.set("isLogin", false),
    );
    return true;
  }
}
