import 'package:coolme121server/coolme121server.dart';

class ValidateEmailController extends ResourceController
{
  @override
  Future<RequestOrResponse> handle(Request request) async
  {
    final Map<String, dynamic> data = await request.body.decode();
    //final Person person = Person.fromJson(await request.body.decode());
    final bool isValid = ValidateDate.email(data["email"] as String);
    if (isValid) {
      return request;
    }

    final TravelMessage travelMessage = TravelMessage();
    travelMessage.result = false;
    travelMessage.description = "The Email is not Valid";

    return Response.ok(jsonEncode(travelMessage));
  }
}