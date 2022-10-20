# 数据库操作的util文件
import traceback
import pymysql
import setting as st
conn = pymysql.connect(**st.MYSQL_CONFIG)
cursor = conn.cursor()

def query(sql):
    """ 查询 """
    cursor.execute(sql)
    res = cursor.fetchall()
    return res


def update(sql):
    """ 查询 """
    cursor.execute(sql)
    conn.commit()


def delete(sql):
    """ 查询 """
    pass


def insert(sql):
    """ 查询 """
    conn.commit()
    pass