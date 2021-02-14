import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:uuid/uuid.dart';

part 'student.jorm.dart';

class Student {
      String uuid;
    String name;
    int gender;
    String classes_id;
      int createTs;
      int updateTs;

    Student();

    Student,make({
        this.uuid,
        this.name;
        this.gender;
        this.classes_id;
    }): this.uuid = this.uuid??Uuid().v1(),
        this.createTs = DateTime.now().millisecondsSinceEpoch,
        this.updateTs = DateTime.now().millisecondsSinceEpoch;

}

@GenBean()
class StudentBean extends Bean<Student> with _StudentBean {
    StudentBean(Adapter adapter) : super(adapter);

    @override
    String get tableName => "student";

    /// Select Student by uuid
    Future<Student> getById(String uuid) async {
        return await findOne(finder.where(this.uuid.eq(uuid)));
    }

    Future deleteByUuid(String uuid) async {
        return await removeWhere(this.uuid.eq(uuid));
    }

    Future<int> updateStudent(Student mod) async {
        final upt = Update(tableName).where(this.uuid.eq(mod.uuid));
        upt.set(this.name, mod.name);
        upt.set(this.gender, mod.gender);
        upt.set(this.classes, mod.classes);
        upt.set(this.updateTs, DateTime.now().millisecondsSinceEpoch);
        return await adapter.update(upt);
    }

    Future<int> insertOrUpdate(Student mod) async {
        final ext = await this.getById(mod.uuid);
        if (ext == null){
            return await this.insert(mod);
        }else{
            return await this.updateTitle(uuid, title);
        }

    }

    Future<List<Student>> fetchList(Expression exps, String orderField, [bool ascending = false]) async {
        return await findMany(
                finder.where(exps).orderBy(orderField, ascending));
    }

}
