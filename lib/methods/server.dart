import 'package:http/http.dart';

class Server {
  String rootURL = "http://192.168.95.231";
  String route(String routename) {
    return "$rootURL/$routename";
  }

  Uri createURL(String url) {
    return Uri.parse(url);
  }

  Future<bool> newAccountRequest({
    required String name,
    required String organisation,
    required String mail,
    required String password,
  }) async {
    Uri target = createURL(route("new-client"));
    Response result = await post(
      target,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        'name': name,
        'organization': organisation,
        'deviceId': "4356456546",
        'password': password,
      },
    );
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Server.newUser({
    required String name,
    required String organisation,
    required String mail,
    required String password,
  }) {
    newAccountRequest(
        name: name, organisation: organisation, mail: mail, password: password);
  }
}
