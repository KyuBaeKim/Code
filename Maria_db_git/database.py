import MySQLdb
import sys

try: 
    con = MySQLdb.connect(db='iot_db', host='localhost', user = 'iot', passwd = '8874')
    print('데이터베이스 연결 성공')
except Exception as e:
    print("데이터 베이스 연결 실패했습니다.")
    print(e)
    sys.exit(0)

    