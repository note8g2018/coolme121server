import 'package:coolme121server/coolme121server.dart';

class ArticleController extends ResourceController {
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    final Article article = Article.fromJson(await request.body.decode());
    final bool result = await ArticleDB.putNew(article);

    return Response.ok(jsonEncode(result));
  }
}