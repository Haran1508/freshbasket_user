class GeneralSettings {
  List<String>? deliveryDates;
  List<TimeSlots>? timeSlots;
  List<PaymentModes>? paymentModes;

  GeneralSettings({this.deliveryDates, this.timeSlots, this.paymentModes});

  GeneralSettings.fromJson(Map<String, dynamic> json) {
    deliveryDates = json['deliveryDates'].cast<String>();
    if (json['timeSlots'] != null) {
      timeSlots = <TimeSlots>[];
      json['timeSlots'].forEach((v) {
        timeSlots!.add(new TimeSlots.fromJson(v));
      });
    }
    if (json['paymentModes'] != null) {
      paymentModes = <PaymentModes>[];
      json['paymentModes'].forEach((v) {
        paymentModes!.add(new PaymentModes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryDates'] = this.deliveryDates;
    if (this.timeSlots != null) {
      data['timeSlots'] = this.timeSlots!.map((v) => v.toJson()).toList();
    }
    if (this.paymentModes != null) {
      data['paymentModes'] = this.paymentModes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlots {
  String? timeId;
  String? timing;

  TimeSlots({this.timeId, this.timing});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    timeId = json['timeId'].toString();
    timing = json['timing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeId'] = this.timeId.toString();
    data['timing'] = this.timing;
    return data;
  }
}

class PaymentModes {
  int? payId;
  String? paymentMode;

  PaymentModes({this.payId, this.paymentMode});

  PaymentModes.fromJson(Map<String, dynamic> json) {
    payId = json['payId'];
    paymentMode = json['paymentMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payId'] = this.payId;
    data['paymentMode'] = this.paymentMode;
    return data;
  }
}
