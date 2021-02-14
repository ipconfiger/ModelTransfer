class Student {
  // consts fields
  static const NAMEKEY = "name";
  static const GENDERKEY = "gender";
  static const CLASSESKEY = "classes";

  String name;
  int gender;
  Classes classes;

  // constructors
  Student();

  Student.make({this.name, this.gender, this.classes});

  Student fromMap(Map map) {
    this.name = map[NAMEKEY]
    this.gender = map[GENDERKEY]
    this.classes = Classes().fromMap(map[CLASSESKEY])
    return this;
  }

  Map asMap() {
      NAMEKEY: this.name,
      GENDERKEY: this.gender,
      CLASSESKEY: this.classes.asMap()
    return {
    }
  }


class Teacher {
  // consts fields
  static const NAMEKEY = "name";
  static const SUBJECTKEY = "subject";
  static const CLASSESKEY = "classes";

  String name;
  String subject;
  Classes classes;

  // constructors
  Teacher();

  Teacher.make({this.name, this.subject, this.classes});

  Teacher fromMap(Map map) {
    this.name = map[NAMEKEY]
    this.subject = map[SUBJECTKEY]
    this.classes = Classes().fromMap(map[CLASSESKEY])
    return this;
  }

  Map asMap() {
      NAMEKEY: this.name,
      SUBJECTKEY: this.subject,
      CLASSESKEY: this.classes.asMap()
    return {
    }
  }


class Classes {
  // consts fields
  static const NAMEKEY = "name";
  static const TEACHERKEY = "teacher";
  static const STUDENTSKEY = "students";

  String name;
  Teacher teacher;
  List<Student> students;

  // constructors
  Classes();

  Classes.make({this.name, this.teacher, this.students});

  Classes fromMap(Map map) {
    this.name = map[NAMEKEY]
    this.teacher = Teacher().fromMap(map[TEACHERKEY])
    this.students = <students>[];
    for (final map in map[STUDENTSKEY]) {
        this.students.add(Student().fromMap(map))
    }
    return this;
  }

  Map asMap() {
      NAMEKEY: this.name,
      TEACHERKEY: this.teacher.asMap()
      final studentsList = <Map>[];
      for (final item in studentsList) {
        studentsList.add(item.asMap());
      }
    return {
    }
  }

