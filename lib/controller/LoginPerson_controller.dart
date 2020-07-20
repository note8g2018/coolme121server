import 'package:coolme121server/coolme121server.dart';

class LoginPersonController extends ResourceController
{
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    final Map<String, dynamic> data = await request.body.decode();
    //final Person person = Person.fromJson(await request.body.decode());
    final Person person = await CheckDB.loginPerson(
      data["userName"] as String,
      data["passWord"] as String,
    );

    return Response.ok(jsonEncode(person));
  }
}