import 'package:apidemo/blocs/student_bloc.dart';
import 'package:apidemo/models/student_model.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  final StudentModel student;

  const AddStudent({Key key, this.student}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState(this.student);
}

class _AddStudentState extends State<AddStudent> {
  final _studentBloc = StudentBloc.getInstance();
  StudentModel student;
  _AddStudentState(this.student);
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var textStyle = TextStyle();
  final _gendersDropdownList = ['Nam', 'Nữ', 'Khác'];
  final connectionIssuesSnackBar =
      SnackBar(content: Text('Không cập nhật được!'));

  @override
  Widget build(BuildContext context) {
    firstNameController.text = student.getFirstName;
    lastNameController.text = student.getLastName;
    textStyle = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          TextFormField(
            controller: firstNameController,
            style: textStyle,
            onChanged: (val) => updateFirstName(val),
            decoration: InputDecoration(
              labelText: 'First Name',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          TextFormField(
            controller: lastNameController,
            style: textStyle,
            onChanged: (val) => updateLastName(val),
            decoration: InputDecoration(
              labelText: 'Last Name',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.025),
            child: DropdownButton<String>(
              items: _gendersDropdownList.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              style: textStyle,
              value: retrieveGender(student.getGender),
              onChanged: (String value) => updateGender(value),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  saveStudent();
                },
                child: updateSaveText(),
              ),
              student.getId == null
                  ? Container()
                  : Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        RaisedButton(
                          onPressed: () {
                            deleteStudent(student.getId);
                          },
                          child: Text('Detele'),
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Student'),
    );
  }

  String retrieveGender(int value) {
    return _gendersDropdownList[value - 1];
  }

  void updateGender(String value) {
    setState(() {
      switch (value) {
        case 'Nam':
          student.gender = 1;
          break;
        case 'Nữ':
          student.gender = 2;
          break;
        case 'Khác':
          student.gender = 3;
          break;
        default:
      }
    });
  }

  void saveStudent() {
    _studentBloc.postStudent(student);
    Navigator.pop(context);
  }

  void deleteStudent(int id) {
    _studentBloc.deleteStudent(id);
    Navigator.pop(context);
  }

  void updateFirstName(String newFirstName) {
    student.firstName = newFirstName.trim();
  }

  void updateLastName(String newLastName) {
    student.lastName = newLastName.trim();
  }

  Widget updateSaveText() {
    return student.getId == null ? Text('Save') : Text('Update');
  }
}
