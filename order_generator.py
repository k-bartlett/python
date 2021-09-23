class OrderGenerator():
    def __init__(self):
        pass

    def createorder(self):
        payload = {
            "order_id": 23,
            "customer_id": 1,
            "type": "pepperoni",
            "qty": 1,
            "retail_price": 12,
            "order_date": "2022-01-10 12:00:00"
        }

        self.orderid = payload['order_id']
        self.customerid = payload['customer_id']
        self.ordertype = payload['type']
        self.qty = payload['qty']
        self.retailprice = payload['retail_price']
        self.orderdate = payload['order_date']
        return self.orderid, self.customerid, self.ordertype, self.qty, self.retailprice, self.orderdate



