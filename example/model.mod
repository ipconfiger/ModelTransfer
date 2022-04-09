Student:                     # 学生
  - name:str                 # 姓名
  - gender:int               # 性别
  - classes:List[Classes]    # 年级


Teacher:                     # 老师
  - name:str                 # 姓名
  - subject:str              # 学科
  - classes:Classes          # 年级



Classes:                     # 班级
  - name:str                 # 班级名
  - teacher:Teacher          # 班主任
  - students:List[Student]   # 学生列表
  - files:List[str]          # 文件列表