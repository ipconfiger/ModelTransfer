# coding=utf8
__author__ = ""

from sqlalchemy import Column, String, Integer, Index, Text, Boolean, BigInteger
from sqlalchemy.ext.declarative import declarative_base, declared_attr
from sqlalchemy.dialects.postgresql import UUID
import uuid
import time
import re


class ModelBase:
    @declared_attr
    def __tablename__(self):
        return "_".join(re.findall("[A-Z][^A-Z]*", self.__name__)).lower()

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid1, unique=True, nullable=False)
    create_ts = Column(BigInteger, index=True, default=time.time_ns, nullable=False)
    update_ts = Column(BigInteger, index=True, default=time.time_ns(), nullable=False)


Base = declarative_base(cls=ModelBase)


class Student(Base):
    """学生"""
    name = Column(Text, doc="姓名")
    gender = Column(Integer, doc="性别")


class Teacher(Base):
    """老师"""
    name = Column(Text, doc="姓名")
    subject = Column(Text, doc="学科")
    classes_id = Column(UUID(as_uuid=True), index=True, nullable=False), doc="年级"


class Classes(Base):
    """班级"""
    name = Column(Text, doc="班级名")
    teacher_id = Column(UUID(as_uuid=True), index=True, nullable=False), doc="班主任"


class StudentOfClasses(Base):
    """年级->学生列表"""
    classes_id = Column(UUID(as_uuid=True), index=True, nullable=False, doc="年级")
    students_id = Column(UUID(as_uuid=True), index=True, nullable=False, doc="学生列表")

