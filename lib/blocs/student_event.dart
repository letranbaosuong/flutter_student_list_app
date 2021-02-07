import 'package:apidemo/models/student_model.dart';

abstract class StudentEvent {}

class FetchStudents extends StudentEvent {}

class PostStudent extends StudentEvent {
  final StudentModel student;

  PostStudent(this.student);
}

class DeteleStudent extends StudentEvent {
  final int id;

  DeteleStudent(this.id);
}
