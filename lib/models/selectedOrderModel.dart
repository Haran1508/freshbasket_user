class SelectedOrder {
  String? orderid;
  String? deliveryAddress;
  String? amount;
  String? status;
  String? placedtime;
  int? acceptedtime;
  int? packedtime;
  int? outfordeliverytime;
  int? deliveredtime;
  int? cancelledtime;
  List<Orderdetails>? orderdetails;

  SelectedOrder(
      {this.orderid,
      this.deliveryAddress,
      this.amount,
      this.status,
      this.placedtime,
      this.acceptedtime,
      this.packedtime,
      this.outfordeliverytime,
      this.deliveredtime,
      this.cancelledtime,
      this.orderdetails});

  SelectedOrder.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    deliveryAddress = json['deliveryAddress'];
    amount = json['amount'];
    status = json['status'];
    placedtime = json['placedtime'];
    acceptedtime = json['acceptedtime'];
    packedtime = json['packedtime'];
    outfordeliverytime = json['outfordeliverytime'];
    deliveredtime = json['deliveredtime'];
    cancelledtime = json['cancelledtime'];
    if (json['orderdetails'] != null) {
      orderdetails = <Orderdetails>[];
      json['orderdetails'].forEach((v) {
        orderdetails!.add(new Orderdetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    data['deliveryAddress'] = this.deliveryAddress;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['placedtime'] = this.placedtime;
    data['acceptedtime'] = this.acceptedtime;
    data['packedtime'] = this.packedtime;
    data['outfordeliverytime'] = this.outfordeliverytime;
    data['deliveredtime'] = this.deliveredtime;
    data['cancelledtime'] = this.cancelledtime;
    if (this.orderdetails != null) {
      data['orderdetails'] = this.orderdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orderdetails {
  int? productcode;
  String? productname;
  String? count;
  String? productprice;

  Orderdetails(
      {this.productcode, this.productname, this.count, this.productprice});

  Orderdetails.fromJson(Map<String, dynamic> json) {
    productcode = json['productcode'];
    productname = json['productname'];
    count = json['count'];
    productprice = json['productprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productcode'] = this.productcode;
    data['productname'] = this.productname;
    data['count'] = this.count;
    data['productprice'] = this.productprice;
    return data;
  }
}
