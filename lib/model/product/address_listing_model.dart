class AddressListingModel {
  Customer? customer;

  AddressListingModel({this.customer});

  AddressListingModel.fromJson(Map<String, dynamic> json) {
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
  String? firstname;
  String? lastname;
  Null? suffix;
  String? email;
  List<Addresses>? addresses;

  Customer(
      {this.firstname, this.lastname, this.suffix, this.email, this.addresses});

  Customer.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    suffix = json['suffix'];
    email = json['email'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['suffix'] = this.suffix;
    data['email'] = this.email;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  String? firstname;
  String? lastname;
  List<String>? street;
  String? city;
  Region? region;
  String? postcode;
  String? countryCode;
  String? telephone;

  Addresses(
      {this.firstname,
        this.lastname,
        this.street,
        this.city,
        this.region,
        this.postcode,
        this.countryCode,
        this.telephone});

  Addresses.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    street = json['street'].cast<String>();
    city = json['city'];
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
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
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    data['postcode'] = this.postcode;
    data['country_code'] = this.countryCode;
    data['telephone'] = this.telephone;
    return data;
  }
}

class Region {
  String? regionCode;
  String? region;

  Region({this.regionCode, this.region});

  Region.fromJson(Map<String, dynamic> json) {
    regionCode = json['region_code'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_code'] = this.regionCode;
    data['region'] = this.region;
    return data;
  }
}