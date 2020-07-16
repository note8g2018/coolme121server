import 'package:mongo_dart/mongo_dart.dart' as mongo;

class UserNameDB
{
  static Future<bool> checkUserName(String userName) async
  {
    mongo.Db db;
    const String url =
        'mongodb://note8g2018:123456789@localhost:27017/flutter?authSource=admin';
//    const String url =
//        'mongodb://admin:123456789@coolme.me:27017/flutter?authSource=admin';
    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collection = db.collection('person');
    final Map<String, dynamic> userNameJson = await collection
        .findOne({'userName': userName});
    return userNameJson?.isNotEmpty?? false;
  }
}
