import 'package:shared_preferences/shared_preferences.dart';
import './server.dart';

Future<bool> verifyExistingLoginCredentials() async {
  Server backend = Server();
  SharedPreferences sp = await SharedPreferences.getInstance();

  String auth = sp.getString("auth")!;
  String client = sp.getString("client")!;
  Map result = await backend.post(
      "verify-user", "application/json", {"auth": auth, "client": client});
  if (result['status'] == 200) {
    return true;
  }
  await sp.clear();
  return false;
}
