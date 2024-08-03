import 'dart:convert';
import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Server {
  final String baseURI = "http://192.168.1.9:5000";

  String uriEncoded(Map<String, String> body) {
    String resultantContent =
        body.entries.map((item) => "${item.key}=${item.value}").join("&");
    return resultantContent;
  }

  Future<String> deviceId() async {
    String deviceId;
    try {
      DeviceInfoPlugin infoPlugin = DeviceInfoPlugin();
      var androidInfo = await infoPlugin.androidInfo;
      deviceId = androidInfo.id;
    } catch (e) {
      deviceId = "dummyidisherefornonandroidosfordebugging";
    }
    return deviceId;
  }

  Future<Map<dynamic, dynamic>> post(
      String routeName, String contentType, Map<String, String> body) async {
    try {
      Uri apiEndPoint = Uri.parse("$baseURI/$routeName");
      http.Response resp = await http.post(
        apiEndPoint,
        headers: {"Content-Type": contentType},
        body: contentType == "application/json"
            ? jsonEncode(body)
            : uriEncoded(body),
      );
      return jsonDecode(resp.body);
    } catch (e) {
      return {"status": 500, "message": "Internal Error"};
    }
  }
}

// newAccountRequest

Server serverInstance = Server();
Future<bool> newAccountRequest(String name, String org) async {
  String devId = "dummyidisherefornonandroidosfordebug";
    Map response = await serverInstance.post(
      "new-user",
      "application/json",
      {"name": name, "org": org, "deviceid": devId},
    );
  if (response['status'] == 200) {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("auth", response['authtoken']);
    sp.setString("client", response['clienttoken']);
    sp.setString("username", name);
    sp.setString("org", org);
    String dummyData = """
                        [
                          {
                            "message":"Hello",
                            "phone":"232434535",
                            "time":"18 Aug 2024"
                          },
                          {
                            "message":"word",
                            "phone":"56456532",
                            "time":"18 Aug 2024"
                          }
                        ]
                      """;
    sp.setString("message", dummyData);
    return true;
  }
  return false;
}
