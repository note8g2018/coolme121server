import 'package:coolme121server/coolme121server.dart';

class ValidateRegController extends ResourceController
{
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    //final Person person = Person.fromJson(await request.body.decode());
    final Map<String, dynamic> data = await request.body.decode();
    final bool isValid = ValidateDate.validateReg(
      data["userName"] as String,
      data["email"] as String,
      data["passWord"] as String,
    );
    if (isValid) {
      return request;
    }
    final TravelMessage travelMessage = TravelMessage();
    travelMessage.result = false;
    travelMessage.description = "The Data is not Valid";

    return Response.ok(jsonEncode(travelMessage));
  }
}