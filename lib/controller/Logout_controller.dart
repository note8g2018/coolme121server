import 'package:coolme121server/coolme121server.dart';

class LogoutController extends ResourceController {
  @override
  Future<RequestOrResponse> handle(Request request) async {
    final Person person = Person.fromJson(await request.body.decode());
    final bool result = await CheckDB.logout(person);

    return Response.ok(jsonEncode(result));
  }
}