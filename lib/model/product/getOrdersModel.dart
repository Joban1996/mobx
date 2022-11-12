class GetOrdersModel {
  Customer? customer;

  GetOrdersModel({this.customer});

  GetOrdersModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  Orders? orders;

  Customer({this.orders});

  Customer.fromJson(Map<String, dynamic> json) {
    orders =
    json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    return data;
  }
}

class Orders {
  List<Items>? items;

  Orders({this.items});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  List<Items1>? items;
  String? number;
  String? orderDate;
  Total? total;
  String? status;

  Items(
      {this.id,
        this.items,
        this.number,
        this.orderDate,
        this.total,
        this.status});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['items'] != null) {
      items = <Items1>[];
      json['items'].forEach((v) {
        items!.add(new Items1.fromJson(v));
      });
    }
    number = json['number'];
    orderDate = json['order_date'];
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['number'] = this.number;
    data['order_date'] = this.orderDate;
    if (this.total != null) {
      data['total'] = this.total!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Items1 {
  String? productName;
  String? productUrlKey;

  Items1({this.productName, this.productUrlKey});

  Items1.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productUrlKey = json['product_url_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_url_key'] = this.productUrlKey;
    return data;
  }
}

class Total {
  GrandTotal? grandTotal;

  Total({this.grandTotal});

  Total.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'] != null
        ? new GrandTotal.fromJson(json['grand_total'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.grandTotal != null) {
      data['grand_total'] = this.grandTotal!.toJson();
    }
    return data;
  }
}

class GrandTotal {
  num? value;
  String? currency;

  GrandTotal({this.value, this.currency});

  GrandTotal.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['currency'] = this.currency;
    return data;
  }
}