import json
import psycopg2
from order_generator import OrderGenerator


class ProcessOrder(OrderGenerator):

    def __init__(self, order):
        self.orderid = order.orderid
        self.customerid = order.customerid
        self.qty = order.qty
        self.ordertype = order.ordertype
        self.retailprice = order.retailprice
        self.orderdate = order.orderdate

    def dbconnect(self):
        creds = open('credentials.json')
        file = json.load(creds)
        print('opening db connection')
        conn = psycopg2.connect(
            host=file['host'],
            database=file['database'],
            user=file['user'],
            password=file['password'])
        cur = conn.cursor()
        return cur, conn

    def execute_query(self):
        print(self.ordertype)
        querystring = f"INSERT INTO ORDERS (order_id, customer_id, quantity, type, retail_price, order_date) VALUES ({self.orderid}, {self.customerid}, {self.qty}, '{self.ordertype}', {self.retailprice}, '{self.orderdate}');"
        print(querystring)
        cur, conn = self.dbconnect()
        cur.execute(querystring)
        conn.commit()
        conn.close()
        print('db connection closed')

order = OrderGenerator()
val = order.createorder()
print(type(val))
object2 = ProcessOrder(order).execute_query()
