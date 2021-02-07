import 'dart:convert';

import 'package:apidemo/models/student_model.dart';
import 'package:requests/requests.dart';

class APIService {
  static String studentUrl = 'https://192.168.1.100:45455/api/student/';
  static Future fetchStudent() async {
    return await Requests.get(studentUrl, verify: false);
  }

  static Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
  };
  static Future<bool> postStudent(StudentModel student) async {
    try {
      var myStudent = student.toJson();
      var studentBody = json.encode(myStudent);
      var res = await Requests.post(
        studentUrl,
        headers: header,
        body: studentBody,
        bodyEncoding: RequestBodyEncoding.PlainText,
        verify: false,
      );

      return Future.value(res.statusCode == 200 ? true : false);
    } catch (e) {
      print('loi api_service.dart postStudent : $e');
    }

    return false;
  }

  static Future<bool> deleteStudent(int id) async {
    var res = await Requests.delete(
      studentUrl + '?id=' + id.toString(),
      headers: header,
      verify: false,
    );
    return Future.value(res.statusCode == 200 ? true : false);
  }
}
