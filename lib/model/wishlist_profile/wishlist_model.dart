class WishListModel {
  Wishlist? wishlist;

  WishListModel({this.wishlist});

  WishListModel.fromJson(Map<String, dynamic> json) {
    wishlist = json['wishlist'] != null
        ? new Wishlist.fromJson(json['wishlist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.toJson();
    }
    return data;
  }
}

class Wishlist {
  int? itemsCount;
  String? name;
  String? sharingCode;
  String? updatedAt;
  List<Items>? items;

  Wishlist(
      {this.itemsCount,
        this.name,
        this.sharingCode,
        this.updatedAt,
        this.items});

  Wishlist.fromJson(Map<String, dynamic> json) {
    itemsCount = json['items_count'];
    name = json['name'];
    sharingCode = json['sharing_code'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items_count'] = this.itemsCount;
    data['name'] = this.name;
    data['sharing_code'] = this.sharingCode;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? qty;
  Null? description;
  String? addedAt;
  Product? product;

  Items({this.id, this.qty, this.description, this.addedAt, this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    description = json['description'];
    addedAt = json['added_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['description'] = this.description;
    data['added_at'] = this.addedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? sku;
  String? name;
  SmallImage? smallImage;
  PriceRange? priceRange;

  Product({this.sku, this.name, this.smallImage, this.priceRange});

  Product.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    name = json['name'];
    smallImage = json['small_image'] != null
        ? new SmallImage.fromJson(json['small_image'])
        : null;
    priceRange = json['price_range'] != null
        ? new PriceRange.fromJson(json['price_range'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['name'] = this.name;
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
  RegularPrice? regularPrice;
  RegularPrice? finalPrice;
  Discount? discount;

  MinimumPrice({this.regularPrice, this.finalPrice, this.discount});

  MinimumPrice.fromJson(Map<String, dynamic> json) {
    regularPrice = json['regular_price'] != null
        ? new RegularPrice.fromJson(json['regular_price'])
        : null;
    finalPrice = json['final_price'] != null
        ? new RegularPrice.fromJson(json['final_price'])
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

class RegularPrice {
  int? value;
  String? currency;

  RegularPrice({this.value, this.currency});

  RegularPrice.fromJson(Map<String, dynamic> json) {
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