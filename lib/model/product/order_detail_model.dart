class OrderDetailModel {
  Customer? customer;

  OrderDetailModel({this.customer});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? totalCount;
  List<Items>? items;

  Orders({this.totalCount, this.items});

  Orders.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  ShippingAddress? shippingAddress;
  String? number;
  String? orderDate;
  String? status;
  List<PaymentMethods>? paymentMethods;
  List<Items1>? items;
  String? carrier;
  Total? total;

  Items(
      {this.id,
        this.shippingAddress,
        this.number,
        this.orderDate,
        this.status,
        this.paymentMethods,
        this.items,
        this.carrier,
        this.total});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    number = json['number'];
    orderDate = json['order_date'];
    status = json['status'];
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = <Items1>[];
      json['items'].forEach((v) {
        items!.add(new Items1.fromJson(v));
      });
    }
    carrier = json['carrier'];
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    data['number'] = this.number;
    data['order_date'] = this.orderDate;
    data['status'] = this.status;
    if (this.paymentMethods != null) {
      data['payment_methods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['carrier'] = this.carrier;
    if (this.total != null) {
      data['total'] = this.total!.toJson();
    }
    return data;
  }
}

class ShippingAddress {
  String? firstname;
  String? lastname;
  List<String>? street;
  String? city;
  String? postcode;
  String? countryCode;
  String? telephone;

  ShippingAddress(
      {this.firstname,
        this.lastname,
        this.street,
        this.city,
        this.postcode,
        this.countryCode,
        this.telephone});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    street = json['street'].cast<String>();
    city = json['city'];
    postcode = json['postcode'];
    countryCode = json['country_code'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['street'] = this.street;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['country_code'] = this.countryCode;
    data['telephone'] = this.telephone;
    return data;
  }
}

class PaymentMethods {
  String? name;
  String? type;

  PaymentMethods({this.name, this.type});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class Items1 {
  String? productName;
  String? productSku;
  ProductSalePrice? productSalePrice;
  int? quantityOrdered;
  int? quantityInvoiced;
  int? quantityShipped;

  Items1(
      {this.productName,
        this.productSku,
        this.productSalePrice,
        this.quantityOrdered,
        this.quantityInvoiced,
        this.quantityShipped});

  Items1.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productSku = json['product_sku'];
    productSalePrice = json['product_sale_price'] != null
        ? new ProductSalePrice.fromJson(json['product_sale_price'])
        : null;
    quantityOrdered = json['quantity_ordered'];
    quantityInvoiced = json['quantity_invoiced'];
    quantityShipped = json['quantity_shipped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_sku'] = this.productSku;
    if (this.productSalePrice != null) {
      data['product_sale_price'] = this.productSalePrice!.toJson();
    }
    data['quantity_ordered'] = this.quantityOrdered;
    data['quantity_invoiced'] = this.quantityInvoiced;
    data['quantity_shipped'] = this.quantityShipped;
    return data;
  }
}

class ProductSalePrice {
  num? value;
  String? currency;

  ProductSalePrice({this.value, this.currency});

  ProductSalePrice.fromJson(Map<String, dynamic> json) {
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

class Total {
  BaseGrandTotal? baseGrandTotal;
  BaseGrandTotal? grandTotal;
  TotalTax? totalTax;
  ProductSalePrice? subtotal;
  TotalTax? totalShipping;
  ShippingHandling? shippingHandling;
  List<Discounts>? discounts;

  Total(
      {this.baseGrandTotal,
        this.grandTotal,
        this.totalTax,
        this.subtotal,
        this.totalShipping,
        this.shippingHandling,
        this.discounts});

  Total.fromJson(Map<String, dynamic> json) {
    baseGrandTotal = json['base_grand_total'] != null
        ? new BaseGrandTotal.fromJson(json['base_grand_total'])
        : null;
    grandTotal = json['grand_total'] != null
        ? new BaseGrandTotal.fromJson(json['grand_total'])
        : null;
    totalTax = json['total_tax'] != null
        ? new TotalTax.fromJson(json['total_tax'])
        : null;
    subtotal = json['subtotal'] != null
        ? new ProductSalePrice.fromJson(json['subtotal'])
        : null;
    totalShipping = json['total_shipping'] != null
        ? new TotalTax.fromJson(json['total_shipping'])
        : null;
    shippingHandling = json['shipping_handling'] != null
        ? new ShippingHandling.fromJson(json['shipping_handling'])
        : null;
    if (json['discounts'] != null) {
      discounts = <Discounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(new Discounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.baseGrandTotal != null) {
      data['base_grand_total'] = this.baseGrandTotal!.toJson();
    }
    if (this.grandTotal != null) {
      data['grand_total'] = this.grandTotal!.toJson();
    }
    if (this.totalTax != null) {
      data['total_tax'] = this.totalTax!.toJson();
    }
    if (this.subtotal != null) {
      data['subtotal'] = this.subtotal!.toJson();
    }
    if (this.totalShipping != null) {
      data['total_shipping'] = this.totalShipping!.toJson();
    }
    if (this.shippingHandling != null) {
      data['shipping_handling'] = this.shippingHandling!.toJson();
    }
    if (this.discounts != null) {
      data['discounts'] = this.discounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BaseGrandTotal {
  num? value;
  String? currency;

  BaseGrandTotal({this.value, this.currency});

  BaseGrandTotal.fromJson(Map<String, dynamic> json) {
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

class TotalTax {
  num? value;

  TotalTax({this.value});

  TotalTax.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class ShippingHandling {
  TotalTax? amountIncludingTax;
  TotalTax? amountExcludingTax;
  TotalTax? totalAmount;

  ShippingHandling(
      {this.amountIncludingTax, this.amountExcludingTax, this.totalAmount});

  ShippingHandling.fromJson(Map<String, dynamic> json) {
    amountIncludingTax = json['amount_including_tax'] != null
        ? new TotalTax.fromJson(json['amount_including_tax'])
        : null;
    amountExcludingTax = json['amount_excluding_tax'] != null
        ? new TotalTax.fromJson(json['amount_excluding_tax'])
        : null;
    totalAmount = json['total_amount'] != null
        ? new TotalTax.fromJson(json['total_amount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amountIncludingTax != null) {
      data['amount_including_tax'] = this.amountIncludingTax!.toJson();
    }
    if (this.amountExcludingTax != null) {
      data['amount_excluding_tax'] = this.amountExcludingTax!.toJson();
    }
    if (this.totalAmount != null) {
      data['total_amount'] = this.totalAmount!.toJson();
    }
    return data;
  }
}

class Discounts {
  BaseGrandTotal? amount;
  String? label;

  Discounts({this.amount, this.label});

  Discounts.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] != null
        ? new BaseGrandTotal.fromJson(json['amount'])
        : null;
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    data['label'] = this.label;
    return data;
  }
}