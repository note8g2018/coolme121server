import 'coolme121server.dart';
import 'package:mongo_dart/mongo_dart.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class Coolme121serverChannel extends ApplicationChannel {
  // ignore: close_sinks
  final StreamController<Map<String, dynamic>> controller = StreamController<Map<String, dynamic>>();
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));


      const String url =
          'mongodb://note8g2018:123456789@localhost:27017/flutter?authSource=admin';
      final Db db = Db(url);
      await db.open();
      final DbCollection collectionArticle = db.collection('articles');
      var cursor = collectionArticle.createCursor({"author": "zaq12wsx2"});
    for (var doc = await cursor.nextObject(); doc != null; doc = await cursor.nextObject())
    {
      controller.add(doc);
    }



  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });

    router
        .route("/checkusername")
        .link(() => ValidateUserNameController())
        .link(() => UserNameController());

    router
        .route("/checkemail")
        .link(() => ValidateEmailController())
        .link(() => EmailController());

    router
        .route("/reg")
        .link(() => ValidateRegController())
        .link(() => CheckRegController())
        .link(() => RegController());

    router
        .route('/login')
        .link(() => CheckLoginController())
        .link(() => LoginController());

    router
        .route('/loginPerson')
        .link(() => LoginPersonController());

    router.route('/logout').link(() => LogoutController());

    router.route('/article').link(() => ArticleController());

    router.route('/articleall').link(() => ArticleAllController());

    router.route("/articlealls").linkFunction((req) async {
      return Response.ok(controller.stream)
        ..bufferOutput = false
        ..contentType = ContentType(
            "text", "event-stream", charset: "utf-8");
    });

    return router;
  }
}