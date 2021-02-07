import 'dart:async';

import 'package:apidemo/blocs/student_event.dart';
import 'package:apidemo/models/student_model.dart';
import 'package:apidemo/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StudentBloc {
  StudentBloc._internal();
  static final StudentBloc _singleton = StudentBloc._internal();
  static StudentBloc getInstance() => _singleton;
  final _repository = Repository();
  final _studentsFetcher = PublishSubject<List<StudentModel>>();
  final _eventStudentController = StreamController<StudentEvent>.broadcast();
  Stream<List<StudentModel>> get students => _studentsFetcher.stream;

  void initialize() {
    _listenStudent();
  }

  void _listenStudent() {
    _eventStudentController.stream.listen((StudentEvent event) async {
      if (event is FetchStudents) {
      } else if (event is PostStudent) {
        bool value = await _repository.postStudent(event.student);
        print('bloc post > $value');
      } else if (event is DeteleStudent) {
        bool value = await _repository.deleteStudent(event.id);
        print('bloc delete > $value');
      }

      List<StudentModel> students = await _repository.fetchStudents();
      _studentsFetcher.sink.add(students);
      print('bloc fetch');
    });
  }

  void initFetchStudents() {
    _eventStudentController.sink.add(FetchStudents());
  }

  void postStudent(StudentModel student) {
    _eventStudentController.sink.add(PostStudent(student));
  }

  void deleteStudent(int id) {
    _eventStudentController.sink.add(DeteleStudent(id));
  }

  void dispose() {
    _studentsFetcher.close();
    _eventStudentController.close();
  }
}
