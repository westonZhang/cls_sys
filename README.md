# 班级量化管理系统

## 一、接口说明文档
### 1. 登陆验证接口
- 请求方式：POST
- 参数：username、password、ptype
    - 说明：
        - username：用户名
        - password：密码
        - ptype：用户类型，用户类型有3类（班主任、系主任、检查员）
            - 班主任：bzr
            - 系主任：xzr
            - 检查员：jcy
    - 举例：
        - 班主任吴洁需要登陆：username="吴洁",password="wujie321",ptype="bzr"
        - 检查员吴洁需要登陆：username="吴洁",password="wujie321",ptype="jcy"
        - 系主任方荣卫需要登陆：username="方荣卫",password="fangrongwei321",ptype="xzr"
        
- 返回结果
    - 正确请求：{"status_code":200,"msg":{"error_msg":"","token":"token值","id":"id值","name":"姓名","ptype":"班主任"}}
    - 错误请求：
        - 1）**参数错误**(即"username"或"password"这两个单词拼写错误，或者它们对应的值为空)：{"status_code":404,"msg":{"error_msg":"用户名或密码为空！","token":"","id":"","name":","ptype":""}}
        - 2) **用户名或密码错误**：{"status_code":404,"msg":{"error_msg":"用户名或密码有误！","token":"","id":"","name":","ptype":""}}