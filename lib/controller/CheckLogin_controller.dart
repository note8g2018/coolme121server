import 'package:coolme121server/coolme121server.dart';

class CheckLoginController extends ResourceController
{
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    final Map<String, dynamic> data = await request.body.decode();
    //final Person person = Person.fromJson(await request.body.decode());
    final bool isCorrect = await CheckDB.checkLogin(
      data["userName"] as String,
      data["passWord"] as String,
    );
    final TravelMessage travelMessage = TravelMessage();
    if (isCorrect)
    {
      return request;
    }
    travelMessage.result = false;
    travelMessage.description = "The userName or passWord or Both are not correct";

    return Response.ok(jsonEncode(travelMessage));
  }
}