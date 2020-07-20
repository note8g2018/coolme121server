import 'package:coolme121server/coolme121server.dart';

class LoginController extends ResourceController
{
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    final Map<String, dynamic> data = await request.body.decode();
    //final Person person = Person.fromJson(await request.body.decode());
    await CheckDB.login(
      data["userName"] as String,
      data["passWord"] as String,
    );
    final TravelMessage travelMessage = TravelMessage();

    travelMessage.result = true;
    travelMessage.description = null;

    return Response.ok(jsonEncode(travelMessage));
  }
}