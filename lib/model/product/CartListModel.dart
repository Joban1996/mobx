class CartListModel {
  Cart? cart;

  CartListModel({this.cart});

  CartListModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  Null? billingAddress;
  List<ShippingAddresses>? shippingAddresses;
  List<Items>? items;
  List<AvailablePaymentMethods>? availablePaymentMethods;
  AvailablePaymentMethods? selectedPaymentMethod;
  List<AppliedCoupons>? appliedCoupons;
  Prices? prices;

  Cart(
      {this.email,
        this.id,
        this.billingAddress,
        this.shippingAddresses,
        this.items,
        this.availablePaymentMethods,
        this.selectedPaymentMethod,
        this.appliedCoupons,
        this.prices});

  Cart.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    billingAddress = json['billing_address'];
    if (json['shipping_addresses'] != null) {
      shippingAddresses = <ShippingAddresses>[];
      json['shipping_addresses'].forEach((v) {
        shippingAddresses!.add(new ShippingAddresses.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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
    if (json['applied_coupons'] != null) {
      appliedCoupons = <AppliedCoupons>[];
      json['applied_coupons'].forEach((v) {
        appliedCoupons!.add(new AppliedCoupons.fromJson(v));
      });
    }
    prices =
    json['prices'] != null ? new Prices.fromJson(json['prices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['billing_address'] = this.billingAddress;
    if (this.shippingAddresses != null) {
      data['shipping_addresses'] =
          this.shippingAddresses!.map((v) => v.toJson()).toList();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.availablePaymentMethods != null) {
      data['available_payment_methods'] =
          this.availablePaymentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.selectedPaymentMethod != null) {
      data['selected_payment_method'] = this.selectedPaymentMethod!.toJson();
    }
    if (this.appliedCoupons != null) {
      data['applied_coupons'] =
          this.appliedCoupons!.map((v) => v.toJson()).toList();
    }
    if (this.prices != null) {
      data['prices'] = this.prices!.toJson();
    }
    return data;
  }
}

class ShippingAddresses {
  String? firstname;
  String? lastname;
  List<String>? street;
  String? city;
  Region? region;
  Region? country;
  String? telephone;
  List<AvailableShippingMethods>? availableShippingMethods;
  Null? selectedShippingMethod;

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
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    country =
    json['country'] != null ? new Region.fromJson(json['country']) : null;
    telephone = json['telephone'];
    if (json['available_shipping_methods'] != null) {
      availableShippingMethods = <AvailableShippingMethods>[];
      json['available_shipping_methods'].forEach((v) {
        availableShippingMethods!.add(new AvailableShippingMethods.fromJson(v));
      });
    }
    selectedShippingMethod = json['selected_shipping_method'];
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
    data['selected_shipping_method'] = this.selectedShippingMethod;
    return data;
  }
}

class Region {
  String? code;
  String? label;

  Region({this.code, this.label});

  Region.fromJson(Map<String, dynamic> json) {
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

class Items {
  String? uid;
  String? id;
  Product? product;
  int? quantity;
  Null? errors;

  Items({this.uid, this.id, this.product, this.quantity, this.errors});

  Items.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['errors'] = this.errors;
    return data;
  }
}

class Product {
  String? uid;
  String? name;
  String? sku;
  SmallImage? smallImage;
  PriceRange? priceRange;

  Product({this.uid, this.name, this.sku, this.smallImage, this.priceRange});

  Product.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    sku = json['sku'];
    smallImage = json['small_image'] != null
        ? new SmallImage.fromJson(json['small_image'])
        : null;
    priceRange = json['price_range'] != null
        ? new PriceRange.fromJson(json['price_range'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['sku'] = this.sku;
    if (this.smallImage != null) {
      data['small_image'] = this.smallImage!.toJson();
    }
    if (this.priceRange != null) {
      data['price_range'] = this.priceRange!.toJson();
    }
    return data;
  }
}

class SmallImage {
  String? url;
  String? label;

  SmallImage({this.url, this.label});

  SmallImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    return data;
  }
}

class PriceRange {
  MinimumPrice? minimumPrice;

  PriceRange({this.minimumPrice});

  PriceRange.fromJson(Map<String, dynamic> json) {
    minimumPrice = json['minimum_price'] != null
        ? new MinimumPrice.fromJson(json['minimum_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.minimumPrice != null) {
      data['minimum_price'] = this.minimumPrice!.toJson();
    }
    return data;
  }
}

class MinimumPrice {
  Amount? regularPrice;
  Amount? finalPrice;
  Discount? discount;

  MinimumPrice({this.regularPrice, this.finalPrice, this.discount});

  MinimumPrice.fromJson(Map<String, dynamic> json) {
    regularPrice = json['regular_price'] != null
        ? new Amount.fromJson(json['regular_price'])
        : null;
    finalPrice = json['final_price'] != null
        ? new Amount.fromJson(json['final_price'])
        : null;
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.regularPrice != null) {
      data['regular_price'] = this.regularPrice!.toJson();
    }
    if (this.finalPrice != null) {
      data['final_price'] = this.finalPrice!.toJson();
    }
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    return data;
  }
}

class Discount {
  int? amountOff;
  num? percentOff;

  Discount({this.amountOff, this.percentOff});

  Discount.fromJson(Map<String, dynamic> json) {
    amountOff = json['amount_off'];
    percentOff = json['percent_off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount_off'] = this.amountOff;
    data['percent_off'] = this.percentOff;
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

class AppliedCoupons {
  String? code;

  AppliedCoupons({this.code});

  AppliedCoupons.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}

class Prices {
  SubtotalExcludingTax? subtotalExcludingTax;
  List<Discounts>? discounts;
  GrandTotal? grandTotal;

  Prices({this.subtotalExcludingTax, this.discounts, this.grandTotal});

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
    grandTotal = json['grand_total'] != null
        ? new GrandTotal.fromJson(json['grand_total'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subtotalExcludingTax != null) {
      data['subtotal_excluding_tax'] = this.subtotalExcludingTax!.toJson();
    }
    if (this.discounts != null) {
      data['discounts'] = this.discounts!.map((v) => v.toJson()).toList();
    }
    if (this.grandTotal != null) {
      data['grand_total'] = this.grandTotal!.toJson();
    }
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

class Discounts {
  Amount1? amount;
  String? label;

  Discounts({this.amount, this.label});

  Discounts.fromJson(Map<String, dynamic> json) {
    amount =
    json['amount'] != null ? new Amount1.fromJson(json['amount']) : null;
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

class Amount1 {
  double? value;

  Amount1({this.value});

  Amount1.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
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