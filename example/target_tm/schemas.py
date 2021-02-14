# coding=utf8
__author__ = ''

from pydantic import BaseModel, Field
from typing import List, Any

class Student(BaseModel):
    name: str = Field("", title="姓名")
    gender: int = Field(0, title="性别")
    classes: "Classes" = Field(None, title="年级")


class Teacher(BaseModel):
    name: str = Field("", title="姓名")
    subject: str = Field("", title="学科")
    classes: "Classes" = Field(None, title="年级")


class Classes(BaseModel):
    name: str = Field("", title="班级名")
    teacher: "Teacher" = Field(None, title="班主任")
    students: List[Student] = Field([], title="学生列表")

