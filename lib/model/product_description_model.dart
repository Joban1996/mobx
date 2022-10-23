class ProductDescriptionModel {
  Products? products;

  ProductDescriptionModel({this.products});

  ProductDescriptionModel.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Products {
  List<Items>? items;
  PageInfo? pageInfo;

  Products({this.items, this.pageInfo});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    pageInfo = json['page_info'] != null
        ? new PageInfo.fromJson(json['page_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class Items {
  String? name;
  String? sku;
  int? brand;
  String? modelName;
  String? colour;
  int? memoryStorageCapacity;
  Null? itemWeight;
  Null? productDimensions;
  Null? displayTechnology;
  Null? batteryPowerRating;
  Null? countryOfManufacture;
  Null? formFactor;
  Null? os;
  Null? otherCameraFeatures;
  Null? connectivityTechnologies;
  int? reviewCount;
  String? stockStatus;
  Image? image;
  Image? smallImage;
  List<Image>? mediaGallery;
  Description? description;
  Description? shortDescription;
  PriceRange? priceRange;

  Items(
      {this.name,
        this.sku,
        this.brand,
        this.modelName,
        this.colour,
        this.memoryStorageCapacity,
        this.itemWeight,
        this.productDimensions,
        this.displayTechnology,
        this.batteryPowerRating,
        this.countryOfManufacture,
        this.formFactor,
        this.os,
        this.otherCameraFeatures,
        this.connectivityTechnologies,
        this.reviewCount,
        this.stockStatus,
        this.image,
        this.smallImage,
        this.mediaGallery,
        this.description,
        this.shortDescription,
        this.priceRange});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sku = json['sku'];
    brand = json['brand'];
    modelName = json['model_name'];
    colour = json['colour'];
    memoryStorageCapacity = json['memory_storage_capacity'];
    itemWeight = json['item_weight'];
    productDimensions = json['product_dimensions'];
    displayTechnology = json['display_technology'];
    batteryPowerRating = json['battery_power_rating'];
    countryOfManufacture = json['country_of_manufacture'];
    formFactor = json['form_factor'];
    os = json['os'];
    otherCameraFeatures = json['other_camera_features'];
    connectivityTechnologies = json['connectivity_technologies'];
    reviewCount = json['review_count'];
    stockStatus = json['stock_status'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    smallImage = json['small_image'] != null
        ? new Image.fromJson(json['small_image'])
        : null;
    if (json['media_gallery'] != null) {
      mediaGallery = <Image>[];
      json['media_gallery'].forEach((v) {
        mediaGallery!.add(Image.fromJson(v));
      });
    }
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    shortDescription = json['short_description'] != null
        ? new Description.fromJson(json['short_description'])
        : null;
    priceRange = json['price_range'] != null
        ? new PriceRange.fromJson(json['price_range'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['brand'] = this.brand;
    data['model_name'] = this.modelName;
    data['colour'] = this.colour;
    data['memory_storage_capacity'] = this.memoryStorageCapacity;
    data['item_weight'] = this.itemWeight;
    data['product_dimensions'] = this.productDimensions;
    data['display_technology'] = this.displayTechnology;
    data['battery_power_rating'] = this.batteryPowerRating;
    data['country_of_manufacture'] = this.countryOfManufacture;
    data['form_factor'] = this.formFactor;
    data['os'] = this.os;
    data['other_camera_features'] = this.otherCameraFeatures;
    data['connectivity_technologies'] = this.connectivityTechnologies;
    data['review_count'] = this.reviewCount;
    data['stock_status'] = this.stockStatus;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.smallImage != null) {
      data['small_image'] = this.smallImage!.toJson();
    }
    if (this.mediaGallery != null) {
      data['media_gallery'] =
          this.mediaGallery!.map((v) => v.toJson()).toList();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    if (this.shortDescription != null) {
      data['short_description'] = this.shortDescription!.toJson();
    }
    if (this.priceRange != null) {
      data['price_range'] = this.priceRange!.toJson();
    }
    return data;
  }
}

class Image {
  String? url;
  String? label;

  Image({this.url, this.label});

  Image.fromJson(Map<String, dynamic> json) {
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

class Description {
  String? html;

  Description({this.html});

  Description.fromJson(Map<String, dynamic> json) {
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['html'] = this.html;
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

class PageInfo {
  int? pageSize;

  PageInfo({this.pageSize});

  PageInfo.fromJson(Map<String, dynamic> json) {
    pageSize = json['page_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_size'] = this.pageSize;
    return data;
  }
}