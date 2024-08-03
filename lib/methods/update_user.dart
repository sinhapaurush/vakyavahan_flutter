import 'package:shared_preferences/shared_preferences.dart';
import './server.dart';

/// This function is used for sending upser information update request on the server.
Future<bool> updateUser(String name, String org) async {
  Server instance = Server();
  SharedPreferences sp = await SharedPreferences.getInstance();
  String? auth = sp.getString("auth");
  String? client = sp.getString("client");
  String? existingName = sp.getString("username");
  String? existingOrg = sp.getString("org");

  if (auth != null && client != null && name.length > 2 && org.length > 3) {
    if (existingOrg != org || existingName != name) {
      Map result = await instance.post("update-profile", "application/json", {
        'name': name,
        'org': org,
        'auth': auth,
        'client': client,
      });
      if (result['status'] == 200) {
        sp.setString("username", name);
        sp.setString("org", org);
        return true;
      }
    } else {
      return true;
    }
  }
  return false;
}
