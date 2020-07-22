import 'coolme121server.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class Coolme121serverChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
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

    return router;
  }
}