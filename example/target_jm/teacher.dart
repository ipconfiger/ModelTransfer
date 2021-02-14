import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:uuid/uuid.dart';

part 'teacher.jorm.dart';

class Teacher {
      String uuid;
    String name;
    String subject;
    String classes_id;
      int createTs;
      int updateTs;

    Teacher();

    Teacher,make({
        this.uuid,
        this.name;
        this.subject;
        this.classes_id;
    }): this.uuid = this.uuid??Uuid().v1(),
        this.createTs = DateTime.now().millisecondsSinceEpoch,
        this.updateTs = DateTime.now().millisecondsSinceEpoch;

}

@GenBean()
class TeacherBean extends Bean<Teacher> with _TeacherBean {
    TeacherBean(Adapter adapter) : super(adapter);

    @override
    String get tableName => "teacher";

    /// Select Teacher by uuid
    Future<Teacher> getById(String uuid) async {
        return await findOne(finder.where(this.uuid.eq(uuid)));
    }

    Future deleteByUuid(String uuid) async {
        return await removeWhere(this.uuid.eq(uuid));
    }

    Future<int> updateTeacher(Teacher mod) async {
        final upt = Update(tableName).where(this.uuid.eq(mod.uuid));
        upt.set(this.name, mod.name);
        upt.set(this.subject, mod.subject);
        upt.set(this.classes, mod.classes);
        upt.set(this.updateTs, DateTime.now().millisecondsSinceEpoch);
        return await adapter.update(upt);
    }

    Future<int> insertOrUpdate(Teacher mod) async {
        final ext = await this.getById(mod.uuid);
        if (ext == null){
            return await this.insert(mod);
        }else{
            return await this.updateTitle(uuid, title);
        }

    }

    Future<List<Teacher>> fetchList(Expression exps, String orderField, [bool ascending = false]) async {
        return await findMany(
                finder.where(exps).orderBy(orderField, ascending));
    }

}
