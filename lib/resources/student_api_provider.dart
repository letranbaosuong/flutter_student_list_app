import 'dart:convert';
import 'package:apidemo/models/student_model.dart';
import 'package:requests/requests.dart';

//// import 'package:requests/requests.dart' show Requests, Response, RequestBodyEncoding;

class StudentApiProvider {
  // final _baseUrl2 = 'https://192.168.1.100:45455/api/student/';
  final _baseUrlLoc = 'https://192.168.1.8:45455/api/student/';
  Map<String, String> _header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
  };
  Future<List<StudentModel>> fetchStudents() async {
    Response response;
    response = await Requests.get(_baseUrlLoc, verify: false);
    if (response.statusCode == 200) {
      Iterable listResponse = json.decode(response.content());
      List<StudentModel> students = List<StudentModel>.from(
          listResponse.map((student) => StudentModel.fromJson(student)));
      return students;
    } else {
      throw Exception('Lỗi api_provider.dart >>> fetchStudents()');
    }
  }

  Future<bool> postStudent(StudentModel student) async {
    var myStudent = student.toJson();
    var studentBody = json.encode(myStudent);
    var res = await Requests.post(
      _baseUrlLoc,
      headers: _header,
      body: studentBody,
      bodyEncoding: RequestBodyEncoding.PlainText,
      verify: false,
    );

    return Future.value(res.statusCode == 200 ? true : false);
  }

  Future<bool> deteleStudent(int id) async {
    var res = await Requests.delete(
      _baseUrlLoc + '?id=' + id.toString(),
      headers: _header,
      verify: false,
    );

    return Future.value(res.statusCode == 200 ? true : false);
  }
}
