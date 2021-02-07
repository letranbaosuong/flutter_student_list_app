import 'package:apidemo/models/student_model.dart';
import 'package:apidemo/resources/student_api_provider.dart';

class Repository {
  final studentApiProvider = StudentApiProvider();
  Future<List<StudentModel>> fetchStudents() =>
      studentApiProvider.fetchStudents();
  Future<bool> postStudent(StudentModel student) =>
      studentApiProvider.postStudent(student);
  Future<bool> deleteStudent(int id) => studentApiProvider.deteleStudent(id);
}
