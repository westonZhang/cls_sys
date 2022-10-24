# 数据库操作的util文件
import pymysql
import setting as st


def query(sql):
    """ 查询 """
    try:
        conn = pymysql.connect(**st.MYSQL_CONFIG)
        with conn.cursor() as cursor:
            cursor.execute(sql)
            res = cursor.fetchall()
            return res
    except Exception as e:
        print(f"Query Error! Sql:{sql}, Error:{e}")
        return -1
    finally:
        conn.close()


def modify(sql):
    """ 修改：插入、更新、删除 """
    try:
        conn = pymysql.connect(**st.MYSQL_CONFIG)
        with conn.cursor() as cursor:
            cursor.execute(sql)
            conn.commit()
    except Exception as e:
        conn.rollback()  # 回滚
        print(f"Modify Error! Sql:{sql}, Error:{e}")
        return -1
    finally:
        conn.close()
