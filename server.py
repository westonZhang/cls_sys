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
    return:返回人员的id、username、token、类型
    """
    # 设置返回值
    return_value = {"status_code":200,"msg":{"error_msg":"","token":"","id":"","name":"","ptype":""}}
    
    # 如果使用get方法发送请求，则返回错误信息
    if request.method == "GET":
        return_value["status_code"] = 404
        return_value['msg']['error_msg'] = "请使用POST请求访问！"
        return return_value

    # 从参数中获取检查员的"username"、"password"
    info = request.form
    username = info.get("username")
    password = info.get("password")
    ptype = info.get("ptype")  # 人员类型
    
    if not username or not password:
        return_value["status_code"] = 404
        return_value['msg']['error_msg'] = "用户名或密码为空！"
        return return_value

    # 判断传递过来的username和password是否正确
    # 查询id，name
    # 根据ptype判断从哪张表查找数据
    if ptype == st.ptype_班主任:
        return_value['msg']['ptype'] = "班主任"
        query_sql = f"select id,name from {st.TABLE_班主任表} where username='{username}' and password='{password}'"
    elif ptype == st.ptype_系主任:
        return_value['msg']['ptype'] = "系主任"
        query_sql = f"select id,name from {st.TABLE_系主任表} where username='{username}' and password='{password}'"
    elif ptype == st.ptype_检查员:
        return_value['msg']['ptype'] = "检查员"
        query_sql = f"select id,name from {st.TABLE_检查员表} where username='{username}' and password='{password}'"
    else:
        return_value["status_code"] = 404
        return_value['msg']['error_msg'] = "“人员类型”参数有误，bzr/xzr/jcy三选一！"
        return return_value

    res = us.query(query_sql)
    if not res:
        return_value["status_code"] = 404
        return_value['msg']['error_msg'] = f"用户名或密码有误！或者【{return_value['msg']['ptype']}】中查无此人！"
        return return_value
    
    # 补充完成返回值，并返回
    token = uo.create_token()
    return_value['msg']['token'] = token
    return_value['msg']['id'] = res[0][0]
    return_value['msg']['name'] = res[0][1]

    # 将token保存到数据库
    update_sql = f"update {st.TABLE_检查员表} set token = '{token}' where id = {res[0][0]}"
    res = us.update(update_sql)
    return return_value


@app.route('/receive_inspect_res',methods=["GET","POST"])
def receive_res():
    """ 接收检查结果，并保存数据库 """
    pass


if __name__ == "__main__":
    app.run(host='0.0.0.0',port=4321,debug=True)