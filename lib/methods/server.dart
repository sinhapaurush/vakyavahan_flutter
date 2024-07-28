import 'dart:convert';
import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;

class Server {
  final String baseURI = "http://192.168.125.207:3002";

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
      print('4');
      return jsonDecode(resp.body);
    } catch (e) {
      print(e.toString());
      return {"status": 500, "message": "Internal Error"};
    }
  }
}

// newAccountRequest

Server serverInstance = Server();
Future<bool> newAccountRequest(String name, String org) async {
  print('here?');
  String devId = "dummyidisherefornonandroidosfordebugging";
  Map response = await serverInstance.post(
    "new-user",
    "application/json",
    {"name": name, "org": org, "deviceid": devId},
  );
  print('6');
  if (response['status'] == 200) {
    return true;
  }
  return false;
}
