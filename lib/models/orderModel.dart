import 'dart:convert';

class OrderModel {
  int orderid;
  String amount;
  String orderdate;
  String orderstatus;
  OrderModel({
    required this.orderid,
    required this.amount,
    required this.orderdate,
    required this.orderstatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderid': orderid,
      'amount': amount,
      'orderdate': orderdate,
      'orderstatus': orderstatus,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderid: map['orderid']?.toInt() ?? 0,
      amount: map['amount'] ?? '',
      orderdate: map['orderdate'] ?? '',
      orderstatus: map['orderstatus'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
