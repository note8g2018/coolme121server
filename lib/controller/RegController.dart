import 'package:coolme121server/coolme121server.dart';

class RegController extends ResourceController
{
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    final String ipAddress = request.connectionInfo.remoteAddress.address;
    final Map<String, dynamic> data = await request.body.decode();
    //final Person person = Person.fromJson(await request.body.decode());
    await CheckDB.RegSave(
      data["userName"] as String,
      data["email"] as String,
      data["passWord"] as String,
      ipAddress,
    );
    final TravelMessage travelMessage = TravelMessage();

    travelMessage.result = true;
    travelMessage.description = null;

    return Response.ok(jsonEncode(travelMessage));
  }
}