import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:coolme121server/coolme121server.dart';

abstract class ArticleDB
{
  static const String url =
      'mongodb://note8g2018:123456789@localhost:27017/flutter?authSource=admin';
//  static const String url =
//        'mongodb://admin:123456789@coolme.me:27017/flutter?authSource=admin';

  static Future<bool> putNew(Article article) async
  {
    mongo.Db db;

    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collectionPerson = db.collection('person');
    final mongo.DbCollection collectionArticle = db.collection('articles');
    final Map<String, dynamic> userNameJson = await collectionPerson
        .findOne({'userName': article.author, 'isLogin': true,});
    //return userNameJson?.isNotEmpty?? false;
    if(userNameJson.isNotEmpty)
      {
        article.writeTimeUTC = DateTime.now().toUtc();
        final result = await collectionArticle.save(
          article.toJson()
        );
      if(result["ok"] == 1.0)
        {
          return true;
        }
      else
        {
          return false;
        }
      }
  }
}