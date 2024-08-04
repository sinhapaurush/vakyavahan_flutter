import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakyavahan/methods/server.dart';

Future<bool> autoLogin(String deviceId) async {
  Server service = Server();
  Map response = await service
      .post("auto-login", "application/json", {"deviceid": deviceId});
  if (response['status'] == 200) {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("auth", response['auth']);
    sp.setString("client", response['client']);
    sp.setString("username", response['name']);
    sp.setString("org", response['org']);
    sp.setString("message", "[]");
    return true;
  }
  return false;
}
