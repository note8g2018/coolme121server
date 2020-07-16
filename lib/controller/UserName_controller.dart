import 'package:coolme121server/coolme121server.dart';

class UserNameController extends ResourceController
{
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    final Map<String, dynamic> data = await request.body.decode();
    //final Person person = Person.fromJson(await request.body.decode());
    final bool isTaken = await UserNameDB.checkUserName(data["userName"] as String);
    final TravelMessage travelMessage = TravelMessage();
    if (isTaken)
    {
      travelMessage.result = false;
      travelMessage.description = "This UserName is Taken";
      return Response.ok(jsonEncode(travelMessage));
    }
    travelMessage.result = true;
    travelMessage.description = null;

    return Response.ok(jsonEncode(travelMessage));
  }
}