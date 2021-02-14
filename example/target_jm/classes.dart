import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:uuid/uuid.dart';

part 'classes.jorm.dart';

class Classes {
      String uuid;
    String name;
    String teacher_id;
      int createTs;
      int updateTs;

    Classes();

    Classes,make({
        this.uuid,
        this.name;
        this.teacher_id;
    }): this.uuid = this.uuid??Uuid().v1(),
        this.createTs = DateTime.now().millisecondsSinceEpoch,
        this.updateTs = DateTime.now().millisecondsSinceEpoch;

}

@GenBean()
class ClassesBean extends Bean<Classes> with _ClassesBean {
    ClassesBean(Adapter adapter) : super(adapter);

    @override
    String get tableName => "classes";

    /// Select Classes by uuid
    Future<Classes> getById(String uuid) async {
        return await findOne(finder.where(this.uuid.eq(uuid)));
    }

    Future deleteByUuid(String uuid) async {
        return await removeWhere(this.uuid.eq(uuid));
    }

    Future<int> updateClasses(Classes mod) async {
        final upt = Update(tableName).where(this.uuid.eq(mod.uuid));
        upt.set(this.name, mod.name);
        upt.set(this.teacher, mod.teacher);
        upt.set(this.students, mod.students);
        upt.set(this.updateTs, DateTime.now().millisecondsSinceEpoch);
        return await adapter.update(upt);
    }

    Future<int> insertOrUpdate(Classes mod) async {
        final ext = await this.getById(mod.uuid);
        if (ext == null){
            return await this.insert(mod);
        }else{
            return await this.updateTitle(uuid, title);
        }

    }

    Future<List<Classes>> fetchList(Expression exps, String orderField, [bool ascending = false]) async {
        return await findMany(
                finder.where(exps).orderBy(orderField, ascending));
    }

}
