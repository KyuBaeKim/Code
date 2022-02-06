from dataclasses import dataclass
from turtle import st
from datetime import datetime
from database import con

@dataclass
class Members :
    userid : str
    password : str
    name : str
    birth : datetime
    email : str
    gender : str
    address : str
    phone : str
    create_date : datetime
    update_date: datetime
    
    @classmethod #인스턴스와 관계없기 때문에
    def all(cls):
        sql = 'select * from members'
        cursor = con.cursor()
        cursor.execute(sql)
        result = cursor.fetchall()
        result = list(map(lambda r: cls(*r),result))
        cursor.close()
        return result
    
    @classmethod
    def get(cls, pk):
        sql = f"select * from members where userid = '{pk}'"
        cursor = con.cursor()
        cursor.execute(sql)
        result = cursor.fetchone()
        if result : 
            result = cls(*result)
        cursor.close()
        return result
    
    # 메서드명 : login
    # 매개변수 : userid, password
    # 매개변수로 전달받은 userid의 password가
    # DB내용과 일치하면(LOGIN 성공)
    # 해당 user의 MEMBER 인스턴스 리턴
    # 아니면 (LOGIN 실패)
    # NONE을 리턴
    # 호출한 쪽에서 로그인 성공 여부 출력
    @classmethod
    def login(cls, userid, password):
        sql = f"""
        select *
        from members
        where userid='{userid}' and password =password('{password}')
        """
        cursor = con.cursor()
        cursor.execute(sql)
        result = cursor.fetchone()
        if result:
            result = cls(*result)
        cursor.close()
        return result
          