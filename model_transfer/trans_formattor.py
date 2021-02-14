import os
from consts import *


class FormatToTrans(object):
    name = 'tm'

    def __init__(self, modelfile: "ModelFile"):
        self.modelfile = modelfile
        self.store_dir = ''

    def clear_old(self):
        dir_path = os.path.dirname(self.modelfile.model_filepath)
        target_dir = os.path.join(dir_path, f'target_{FormatToTrans.name}')
        if not os.path.exists(target_dir):
            os.mkdir(target_dir)
        self.store_dir = target_dir
        dart_path = os.path.join(self.store_dir, "property_views.dart")
        py_path = os.path.join(self.store_dir, "schemas.py")
        if os.path.exists(dart_path):
            os.remove(dart_path)
        if os.path.exists(py_path):
            os.remove(py_path)

    def type_map(self, fieldwrapper):
        mapper = {
            BUILIN_TYPE_STR: 'String',
            BUILIN_TYPE_INT: 'int',
            BUILIN_TYPE_FLOAT: 'double',
            BUILIN_TYPE_DOUBLE: 'double',
            BUILIN_TYPE_BOOL: 'bool'
        }
        if fieldwrapper.is_list:
            return f"List<{fieldwrapper.field_type}>"
        if fieldwrapper.is_complex:
            return fieldwrapper.field_type
        return mapper[fieldwrapper.field_type]

    def type_default(self, fieldwrapper):
        if fieldwrapper.is_complex:
            if fieldwrapper.is_list:
                return "[]"
            else:
                return "None"
        mapper = {
            BUILIN_TYPE_STR: '""',
            BUILIN_TYPE_INT: '0',
            BUILIN_TYPE_FLOAT: '0.0',
            BUILIN_TYPE_DOUBLE: '0.0',
            BUILIN_TYPE_BOOL: 'Field'
        }
        return mapper[fieldwrapper.field_type]

    def pydanticType(self, fieldwrapper):
        if fieldwrapper.is_list:
            return f"List[{fieldwrapper.field_type}]"
        else:
            if fieldwrapper.is_complex:
                return f"\"{fieldwrapper.field_type}\""
            return fieldwrapper.field_type

    def format(self):
        self.clear_old()
        # dart transform
        dart_lines = []
        for classwrapper in self.modelfile.classes:
            dart_lines.append(f"class {classwrapper.class_name} " + "{")
            dart_lines.append("  // consts fields")
            for fieldwrapper in classwrapper.fields:
                dart_lines.append(f"  static const {fieldwrapper.name.upper()}KEY = \"{fieldwrapper.name.lower()}\";")
            dart_lines.append("")
            for fieldwrapper in classwrapper.fields:
                dart_lines.append(f"  {self.type_map(fieldwrapper)} {fieldwrapper.name};")
            dart_lines.append("")
            dart_lines.append("  // constructors")
            dart_lines.append(f"  {classwrapper.class_name}();")
            dart_lines.append("")
            constrctor_params = ", ".join([f"this.{fieldwrapper.name}" for fieldwrapper in classwrapper.fields])
            dart_lines.append("  %(name)s.make({%(p)s});" % dict(name=classwrapper.class_name, p=constrctor_params))
            dart_lines.append("")
            dart_lines.append("  %s fromMap(Map map) {" % classwrapper.class_name)
            for fieldwrapper in classwrapper.fields:
                if fieldwrapper.is_complex:
                    if fieldwrapper.is_list:
                        dart_lines.append(f"    this.{fieldwrapper.name} = <{fieldwrapper.name}>[];")
                        dart_lines.append(f"    for (final map in map[{fieldwrapper.name.upper()}KEY]) " + "{")
                        dart_lines.append(f"        this.{fieldwrapper.name}.add({fieldwrapper.field_type}().fromMap(map))")
                        dart_lines.append("    }")
                    else:
                        dart_lines.append(f"    this.{fieldwrapper.name} = {fieldwrapper.field_type}().fromMap(map[{fieldwrapper.name.upper()}KEY])")
                else:
                    dart_lines.append(f"    this.{fieldwrapper.name} = map[{fieldwrapper.name.upper()}KEY]")
            dart_lines.append("    return this;")
            dart_lines.append("  }")
            dart_lines.append("")
            dart_lines.append("  Map asMap() {")
            for fieldwrapper in classwrapper.fields:
                if fieldwrapper.is_complex:
                    if fieldwrapper.is_list:
                        dart_lines.append(f"      final {fieldwrapper.name}List = <Map>[];")
                        dart_lines.append(f"      for (final item in {fieldwrapper.name}List) " + "{")
                        dart_lines.append(f"        {fieldwrapper.name}List.add(item.asMap());")
                        dart_lines.append("      }")
                    else:
                        dart_lines.append(f"      {fieldwrapper.name.upper()}KEY: this.{fieldwrapper.name}.asMap()")
                else:
                    dart_lines.append(f"      {fieldwrapper.name.upper()}KEY: this.{fieldwrapper.name},")
            dart_lines.append("    return {")
            dart_lines.append("    }")
            dart_lines.append("  }")
            dart_lines.append("")
            dart_lines.append("")

        dart_path = os.path.join(self.store_dir, "property_views.dart")
        with open(dart_path, 'w') as f:
            f.write("\n".join(dart_lines))

        py_lines = []
        py_lines.append('# coding=utf8')
        py_lines.append("__author__ = ''")
        py_lines.append("")
        py_lines.append("from pydantic import BaseModel, Field")
        py_lines.append("from typing import List, Any")
        py_lines.append("")
        for classwrapper in self.modelfile.classes:
            py_lines.append(f"class {classwrapper.class_name}(BaseModel):")
            for fieldwrapper in classwrapper.fields:
                py_lines.append(f"    {fieldwrapper.name}: {self.pydanticType(fieldwrapper)} = Field({self.type_default(fieldwrapper)}, title=\"{fieldwrapper.comment}\")")
            py_lines.append("")
            py_lines.append("")

        py_path = os.path.join(self.store_dir, "schemas.py")
        with open(py_path, 'w') as f:
            f.write("\n".join(py_lines))

