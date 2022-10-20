from flask import Flask, request, url_for, render_template
import setting as st
import utils_sql as us
import utils_others as uo



app = Flask(__name__)


@app.route('/')
def home_page():
    """ 主页面 """
    return "hello"


@app.route('/inspector_login', methods=["GET",'POST'])
def inspector_login():
    """
    get:获取检查员登陆信息
    return:返回检察员的id、username、token
    """
    # 设置返回值
    return_value = {"status":200,"msg":{"error_msg":"","token":"","id":"","name":""}}
    
    # 如果使用get方法发送请求，则返回错误信息
    if request.method == "GET":
        return_value["status"] = 404
        return_value['msg']['error_msg'] = "请使用POST请求访问！"
        return return_value

    # 从参数中获取检查员的“username”、“passwd”
    info = request.form
    username = info.get("username")
    passwd = info.get("passwd") if info.get("passwd") else info.get("password")

    # 判断传递过来的username和passwd是否正确
    # 查询id，name
    query_sql = f"select id,name from {st.TABLE_检查员表} where username='{username}' and passwd='{passwd}'"
    res = us.query(query_sql)
    if not res:
        return_value["status"] = 404
        return_value['msg']['error_msg'] = "用户名或密码有误！"
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
    app.run(debug=True)