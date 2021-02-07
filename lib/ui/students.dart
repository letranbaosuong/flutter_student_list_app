import 'package:apidemo/models/student_model.dart';
import 'package:apidemo/ui/add_student.dart';
import 'package:flutter/material.dart';
import 'package:apidemo/blocs/student_bloc.dart';

class Students extends StatefulWidget {
  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final _studentBloc = StudentBloc.getInstance();

  @override
  void initState() {
    super.initState();
    _studentBloc.initFetchStudents();
  }

  @override
  void dispose() {
    _studentBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: StreamBuilder(
        stream: _studentBloc.students,
        builder:
            (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot) {
          if (snapshot.hasData) {
            return _buildStudentList(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  Widget _buildStudentList(List<StudentModel> students) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              leading: displayByGender(students[index].getGender),
              title: Text(students[index].getFirstName),
              onTap: () {
                navigatorToStudent(students[index]);
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('StudentList'),
    );
  }

  void navigatorToStudent(StudentModel student) async {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return AddStudent(
        student: student,
      );
    }));
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      child: Icon(Icons.person_add),
      onPressed: () {
        navigatorToStudent(StudentModel('', '', 1));
      },
    );
  }

  Widget displayByGender(int gender) {
    var male = Icon(Icons.person, color: Colors.blue);
    var feMale = Icon(Icons.pregnant_woman, color: Colors.pink);
    var orther = Icon(Icons.battery_unknown, color: Colors.green);
    return gender == 1
        ? male
        : gender == 2
            ? feMale
            : orther;
  }
}
