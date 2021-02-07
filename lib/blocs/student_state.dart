import 'package:apidemo/models/student_model.dart';

abstract class StudentState {}

class FetchStudentsState extends StudentState {
  final List<StudentModel> students;

  FetchStudentsState(this.students);
}
