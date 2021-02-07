class StudentModel {
  int _id;
  String _firstName;
  String _lastName;
  int _gender;

  StudentModel(this._firstName, this._lastName, this._gender);

  int get getId => _id;
  String get getFirstName => _firstName;
  String get getLastName => _lastName;
  int get getGender => _gender;

  set firstName(String newFirstName) {
    _firstName = newFirstName;
  }

  set lastName(String newLastName) {
    _lastName = newLastName;
  }

  set gender(int newGender) {
    _gender = newGender;
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['gender'] = _gender;

    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }

  StudentModel.fromJson(dynamic o) {
    this._id = o['id'];
    this.firstName = o['firstName'];
    this.lastName = o['lastName'];
    this.gender = o['gender'];
  }
}
