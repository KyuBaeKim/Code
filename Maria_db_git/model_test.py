from models import Members

# all() 테스트
members = Members.all()
for m in members:
    print(f'{m.userid}  {m.name}  {m.email}')
    
# get() 테스트
print('마이콜 검색')
user = Members.get('michol')
print(user)


# login 테스트
user = None
user = Members.login('hong','1234')
if user:
    print(f'로그인 성공: {user.userid}({user.name})')
else:
    print("로그인 실패")
    
# input을 사용해서
# 사용자로부터 userid, password를 입력받아
# 로그인 처리하세요
# id, 비밀번호 틀렸을때 최대 3번까지 시도
for _ in range(3):
    userid = input('아이디를 입력하세요 : ')
    password = input('비밀번호를 입력하세요: ')
    user = None
    user = Members.login(userid,password)
    if user :
        break
    else:
        print("로그인 실패 - 다시시도 하세요")
if user:
    print(f'로그인 성공: {user.userid}({user.name})')
else:
    print("로그인 실패")