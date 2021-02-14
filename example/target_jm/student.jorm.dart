// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _StudentBean implements Bean<Student> {
    final uuid = StrField('uuid');
    final createTs = IntField('create_ts');
    final updateTs = IntField('update_ts');
    final name = IntField('name');
    final gender = IntField('gender');
    final classes = IntField('classes');
    Map<String, Field> _fields;

    Map<String, Field> get fields => _fields ??= {
        uuid.name: uuid,
        createTs.name: createTs,
        updateTs.name: updateTs,
        name.name: name,
        gender.name: gender,
        classes.name: classes,
      };

    Student fromMap(Map map) {
        Student model = Student();
        model.uuid = adapter.parseValue(map['uuid']);
        model.createTs = adapter.parseValue(map['create_ts']);
        model.updateTs = adapter.parseValue(map['update_ts']);
        model.name = adapter.parseValue(map['name']);
        model.gender = adapter.parseValue(map['gender']);
        model.classes = adapter.parseValue(map['classes']);
        return model;
    }

    List<SetColumn> toSetColumns(Student model,
            {bool update = false, Set<String> only, bool onlyNonNull = false}) {
        List<SetColumn> ret = [];

        if (only == null && !onlyNonNull) {
            ret.add(uuid.set(model.uuid));
            ret.add(createTs.set(model.createTs));
            ret.add(updateTs.set(model.updateTs));
            ret.add(name.set(model.name));
            ret.add(gender.set(model.gender));
            ret.add(classes.set(model.classes));
        } else if (only != null) {
            if (only.contains(uuid.name)) ret.add(uuid.set(model.uuid));
            if (only.contains(createTs.name)) ret.add(createTs.set(model.createTs));
            if (only.contains(updateTs.name)) ret.add(updateTs.set(model.updateTs));
            if (only.contains(name.name)) ret.add(name.set(model.name));
            if (only.contains(gender.name)) ret.add(gender.set(model.gender));
            if (only.contains(classes.name)) ret.add(classes.set(model.classes));
        } else
        /* if (onlyNonNull) */ {
            if (model.uuid != null) {
                ret.add(uuid.set(model.uuid));
            }
            if (model.createTs != null) {
                ret.add(createTs.set(model.createTs));
            }
            if (model.updateTs != null) {
                ret.add(updateTs.set(model.updateTs));
            }
            if (model.name != null) {
                ret.add(name.set(model.name));
            }
            if (model.gender != null) {
                ret.add(gender.set(model.gender));
            }
            if (model.classes != null) {
                ret.add(classes.set(model.classes));
            }
        }
        return ret;
    }

    Future<void> createTable({bool ifNotExists = false}) async {
        final st = Sql.create(tableName, ifNotExists: ifNotExists);
        st.addStr(uuid.name, isNullable: false);
        st.addInt(createTs.name, isNullable: false);
        st.addInt(updateTs.name, isNullable: false);
        st.addStr(name.name, isNullable: false);
        st.addInt(gender.name, isNullable: false);
        st.addStr(classes.name, isNullable: false);
        return adapter.createTable(st);
    }

    Future<dynamic> insert(Student model,
            {bool cascade = false,
            bool onlyNonNull = false,
            Set<String> only}) async {
        final Insert insert = inserter
                .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        return adapter.insert(insert);
    }

    Future<void> insertMany(List<Student> models,
            {bool onlyNonNull = false, Set<String> only}) async {
        final List<List<SetColumn>> data = models
                .map((model) =>
                        toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
                .toList();
        final InsertMany insert = inserters.addAll(data);
        await adapter.insertMany(insert);
        return;
    }

    Future<dynamic> upsert(Student model,
            {bool cascade = false,
            Set<String> only,
            bool onlyNonNull = false,
            isForeignKeyEnabled = false}) async {
        final Upsert upsert = upserter
                .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        return adapter.upsert(upsert);
    }

    Future<void> upsertMany(List<Student> models,
            {bool onlyNonNull = false,
            Set<String> only,
            isForeignKeyEnabled = false}) async {
        final List<List<SetColumn>> data = [];
        for (var i = 0; i < models.length; ++i) {
            var model = models[i];
            data.add(
                    toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
        }
        final UpsertMany upsert = upserters.addAll(data);
        await adapter.upsertMany(upsert);
        return;
    }

    Future<void> updateMany(List<Student> models,
            {bool onlyNonNull = false, Set<String> only}) async {
        final List<List<SetColumn>> data = [];
        final List<Expression> where = [];
        for (var i = 0; i < models.length; ++i) {
            var model = models[i];
            data.add(
                    toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
            where.add(null);
        }
        final UpdateMany update = updaters.addAll(data, where);
        await adapter.updateMany(update);
        return;
    }

}
