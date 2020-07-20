import 'package:coolme121server/coolme121server.dart';

class CheckRegController extends ResourceController
{
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    final Map<String, dynamic> data = await request.body.decode();
    //final Person person = Person.fromJson(await request.body.decode());
    final bool isTaken = await CheckDB.RegCheck(
      data["userName"] as String,
      data["email"] as String,
    );
    final TravelMessage travelMessage = TravelMessage();
    if (isTaken)
    {
      travelMessage.result = false;
      travelMessage.description = "The UserName or Email or Both are Taken";
      return Response.ok(jsonEncode(travelMessage));
    }
    return request;
//    travelMessage.result = true;
//    travelMessage.description = null;
//
//    return Response.ok(jsonEncode(travelMessage));
  }
}