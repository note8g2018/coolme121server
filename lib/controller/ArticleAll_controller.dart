import 'package:coolme121server/coolme121server.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ArticleAllController extends ResourceController {
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    //final Article article = Article.fromJson(await request.body.decode());
    //final bool result = await ArticleDB.putNew(article);
    const String url =
        'mongodb://note8g2018:123456789@localhost:27017/flutter?authSource=admin';
//  static const String url =
//        'mongodb://admin:123456789@coolme.me:27017/flutter?authSource=admin';
    mongo.Db db;

    db = mongo.Db(url);
    await db.open();
    final mongo.DbCollection collectionArticle = db.collection('articles');
    Stream<List<int>> myStream = collectionArticle.find({})
        .map((item) => jsonEncode(item).codeUnits);

    return Response.ok(myStream)..encodeBody = false;
  }
}