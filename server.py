from select import kqueue
from flask import Flask, request, url_for, render_template
import setting as st
import utils_sql as us
import utils_others as uo

app = Flask(__name__)


@app.route('/')
def home_page():
    """ 主页面 """
    return "hello"


@app.route('/login', methods=["GET",'POST'])
def login():
    """
    get:获取人员的登陆信息
    return:返回人员的id、username、token
    """
    # 设置返回值
    return_value = {
        "status_code":200,      # 状态码
        "msg":{
            "error_msg":"",     # 错误信息
            "token":"",         # token值
            "user_id":"",       # 用户id
            "name":"",          # 姓名
            "is_headdepart":"",         # 是否系主任
            "is_headteacher":"",        # 是否班主任
            "is_inspector":"",          # 是否检查员
            "permission_level":""       # 权限等级
        }
    }
    
    # 如果使用get方法发送请求，则返回错误信息
    if request.method == "GET":
        return_value["status_code"] = 404
        return_value['msg']['error_msg'] = "请使用POST请求访问！"
        return return_value

    # 从参数中获取检查员的"username"、"password"
    username = request.form.get("username")
    password = request.form.get("password")
    
    if not username or not password:
        return_value["status_code"] = 404
        return_value['msg']['error_msg'] = "用户名或密码为空！"
        return return_value

    # 判断传递过来的username和password是否正确
    # 查询id、name、是否系主任、是否检查员、是否系主任、权限等级
    query_sql = f"select id,name,is_headdepart,is_inspector,is_headteacher,permission_level from {st.TABLE_人员表} where username='{username}' and password='{password}'"
    res = us.query(query_sql)
    if not res:
        return_value["status_code"] = 404
        return_value['msg']['error_msg'] = f"用户名或密码有误！"
        return return_value
    
    # 补充完成返回值，并返回
    token = uo.create_token()
    return_value = {
        "status_code":200,          # 状态码
        "msg":{
            "error_msg":"",         # 错误信息
            "token":token,          # token值
            "user_id":res[0][0],    # 用户id
            "name":res[0][1],       # 姓名
            "is_headdepart":res[0][2],         # 是否系主任
            "is_inspector":res[0][3],          # 是否检查员
            "is_headteacher":res[0][4],        # 是否班主任
            "permission_level":res[0][5]       # 权限等级
        }
    }

    # 将token保存到数据库
    update_sql = f"update {st.TABLE_人员表} set token = '{token}' where id = {res[0][0]}"
    res = us.modify(update_sql)
    return return_value


@app.route('/receive_inspect_res',methods=["GET","POST"])
def receive_res():
    """ 接收检查结果，并保存数据库 """
    pass


if __name__ == "__main__":
    app.run(host='0.0.0.0',port=4321,debug=True)