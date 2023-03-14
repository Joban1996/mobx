class CartOtherData {
  Cart? cart;

  CartOtherData({this.cart});

  CartOtherData.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    return data;
  }
}

class Cart {
  String? email;
  BillingAddress? billingAddress;
  List<ShippingAddresses>? shippingAddresses;
  List<AvailablePaymentMethods>? availablePaymentMethods;
  AvailablePaymentMethods? selectedPaymentMethod;
  Null? appliedCoupons;
  Prices? prices;

  Cart(
      {this.email,
        this.billingAddress,
        this.shippingAddresses,
        this.availablePaymentMethods,
        this.selectedPaymentMethod,
        this.appliedCoupons,
        this.prices});

  Cart.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    if (json['shipping_addresses'] != null) {
      shippingAddresses = <ShippingAddresses>[];
      json['shipping_addresses'].forEach((v) {
        shippingAddresses!.add(new ShippingAddresses.fromJson(v));
      });
    }
    if (json['available_payment_methods'] != null) {
      availablePaymentMethods = <AvailablePaymentMethods>[];
      json['available_payment_methods'].forEach((v) {
        availablePaymentMethods!.add(new AvailablePaymentMethods.fromJson(v));
      });
    }
    selectedPaymentMethod = json['selected_payment_method'] != null
        ? new AvailablePaymentMethods.fromJson(json['selected_payment_method'])
        : null;
    appliedCoupons = json['applied_coupons'];
    prices =
    json['prices'] != null ? new Prices.fromJson(json['prices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.shippingAddresses != null) {
      data['shipping_addresses'] =
          this.shippingAddresses!.map((v) => v.toJson()).toList();
    }
    if (this.availablePaymentMethods != null) {
      data['available_payment_methods'] =
          this.availablePaymentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.selectedPaymentMethod != null) {
      data['selected_payment_method'] = this.selectedPaymentMethod!.toJson();
    }
    data['applied_coupons'] = this.appliedCoupons;
    if (this.prices != null) {
      data['prices'] = this.prices!.toJson();
    }
    return data;
  }
}

class BillingAddress {
  String? city;
  Country? country;
  String? firstname;
  String? lastname;
  String? postcode;
  Country? region;
  List<String>? street;
  String? telephone;

  BillingAddress(
      {this.city,
        this.country,
        this.firstname,
        this.lastname,
        this.postcode,
        this.region,
        this.street,
        this.telephone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    firstname = json['firstname'];
    lastname = json['lastname'];
    postcode = json['postcode'];
    region =
    json['region'] != null ? new Country.fromJson(json['region']) : null;
    street = json['street'].cast<String>();
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['postcode'] = this.postcode;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    return data;
  }
}

class Country {
  String? code;
  String? label;

  Country({this.code, this.label});

  Country.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['label'] = this.label;
    return data;
  }
}

class ShippingAddresses {
  String? firstname;
  String? lastname;
  List<String>? street;
  String? city;
  Country? region;
  Country? country;
  String? telephone;
  List<AvailableShippingMethods>? availableShippingMethods;
  SelectedShippingMethod? selectedShippingMethod;

  ShippingAddresses(
      {this.firstname,
        this.lastname,
        this.street,
        this.city,
        this.region,
        this.country,
        this.telephone,
        this.availableShippingMethods,
        this.selectedShippingMethod});

  ShippingAddresses.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    street = json['street'].cast<String>();
    city = json['city'];
    region =
    json['region'] != null ? new Country.fromJson(json['region']) : null;
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    telephone = json['telephone'];
    if (json['available_shipping_methods'] != null) {
      availableShippingMethods = <AvailableShippingMethods>[];
      json['available_shipping_methods'].forEach((v) {
        availableShippingMethods!.add(new AvailableShippingMethods.fromJson(v));
      });
    }
    selectedShippingMethod = json['selected_shipping_method'] != null
        ? new SelectedShippingMethod.fromJson(json['selected_shipping_method'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['street'] = this.street;
    data['city'] = this.city;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['telephone'] = this.telephone;
    if (this.availableShippingMethods != null) {
      data['available_shipping_methods'] =
          this.availableShippingMethods!.map((v) => v.toJson()).toList();
    }
    if (this.selectedShippingMethod != null) {
      data['selected_shipping_method'] = this.selectedShippingMethod!.toJson();
    }
    return data;
  }
}

class AvailableShippingMethods {
  Amount? amount;
  bool? available;
  String? carrierCode;
  String? carrierTitle;
  String? errorMessage;
  String? methodCode;
  String? methodTitle;
  Amount? priceExclTax;
  Amount? priceInclTax;

  AvailableShippingMethods(
      {this.amount,
        this.available,
        this.carrierCode,
        this.carrierTitle,
        this.errorMessage,
        this.methodCode,
        this.methodTitle,
        this.priceExclTax,
        this.priceInclTax});

  AvailableShippingMethods.fromJson(Map<String, dynamic> json) {
    amount =
    json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    available = json['available'];
    carrierCode = json['carrier_code'];
    carrierTitle = json['carrier_title'];
    errorMessage = json['error_message'];
    methodCode = json['method_code'];
    methodTitle = json['method_title'];
    priceExclTax = json['price_excl_tax'] != null
        ? new Amount.fromJson(json['price_excl_tax'])
        : null;
    priceInclTax = json['price_incl_tax'] != null
        ? new Amount.fromJson(json['price_incl_tax'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    data['available'] = this.available;
    data['carrier_code'] = this.carrierCode;
    data['carrier_title'] = this.carrierTitle;
    data['error_message'] = this.errorMessage;
    data['method_code'] = this.methodCode;
    data['method_title'] = this.methodTitle;
    if (this.priceExclTax != null) {
      data['price_excl_tax'] = this.priceExclTax!.toJson();
    }
    if (this.priceInclTax != null) {
      data['price_incl_tax'] = this.priceInclTax!.toJson();
    }
    return data;
  }
}

class Amount {
  String? currency;
  int? value;

  Amount({this.currency, this.value});

  Amount.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['value'] = this.value;
    return data;
  }
}

class SelectedShippingMethod {
  Amount? amount;
  String? carrierCode;
  String? carrierTitle;
  String? methodCode;
  String? methodTitle;

  SelectedShippingMethod(
      {this.amount,
        this.carrierCode,
        this.carrierTitle,
        this.methodCode,
        this.methodTitle});

  SelectedShippingMethod.fromJson(Map<String, dynamic> json) {
    amount =
    json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    carrierCode = json['carrier_code'];
    carrierTitle = json['carrier_title'];
    methodCode = json['method_code'];
    methodTitle = json['method_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    data['carrier_code'] = this.carrierCode;
    data['carrier_title'] = this.carrierTitle;
    data['method_code'] = this.methodCode;
    data['method_title'] = this.methodTitle;
    return data;
  }
}

class AvailablePaymentMethods {
  String? code;
  String? title;

  AvailablePaymentMethods({this.code, this.title});

  AvailablePaymentMethods.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    return data;
  }
}

class Prices {
  SubtotalExcludingTax? subtotalExcludingTax;
  List<Discounts>? discounts;
  Amount? grandTotal;
  List<AppliedTaxes>? appliedTaxes;

  Prices({this.subtotalExcludingTax, this.discounts, this.grandTotal,this.appliedTaxes});

  Prices.fromJson(Map<String, dynamic> json) {
    subtotalExcludingTax = json['subtotal_excluding_tax'] != null
        ? new SubtotalExcludingTax.fromJson(json['subtotal_excluding_tax'])
        : null;
    if (json['discounts'] != null) {
      discounts = <Discounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(new Discounts.fromJson(v));
      });
    }
    if (json['applied_taxes'] != null) {
      appliedTaxes = <AppliedTaxes>[];
      json['applied_taxes'].forEach((v) {
        appliedTaxes!.add(new AppliedTaxes.fromJson(v));
      });
    }
    grandTotal = json['grand_total'] != null
        ? new Amount.fromJson(json['grand_total'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subtotalExcludingTax != null) {
      data['subtotal_excluding_tax'] = this.subtotalExcludingTax!.toJson();
    }
    data['discounts'] = this.discounts;
    data['applied_taxes'] = this.appliedTaxes;
    if (this.grandTotal != null) {
      data['grand_total'] = this.grandTotal!.toJson();
    }
    return data;
  }
}

class Discounts {
  SubtotalExcludingTax? amount;
  String? label;

  Discounts({this.amount, this.label});

  Discounts.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] != null
        ? new SubtotalExcludingTax.fromJson(json['amount'])
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

class AppliedTaxes {
  Amount2? amount;
  String? label;

  AppliedTaxes({this.amount, this.label});

  AppliedTaxes.fromJson(Map<String, dynamic> json) {
    amount =
    json['amount'] != null ? new Amount2.fromJson(json['amount']) : null;
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

class Amount2 {
  double? value;

  Amount2({this.value});

  Amount2.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class SubtotalExcludingTax {
  num? value;

  SubtotalExcludingTax({this.value});

  SubtotalExcludingTax.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}