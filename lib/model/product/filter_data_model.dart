class FilterDataModel {
  Products? products;

  FilterDataModel({this.products});

  FilterDataModel.fromJson(Map<String, dynamic> json) {
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
  int? totalCount;
  List<Aggregations>? aggregations;

  Products({this.totalCount, this.aggregations});

  Products.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['aggregations'] != null) {
      aggregations = <Aggregations>[];
      json['aggregations'].forEach((v) {
        aggregations!.add(new Aggregations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.aggregations != null) {
      data['aggregations'] = this.aggregations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Aggregations {
  String? attributeCode;
  String? label;
  int? count;
  List<Options>? options;

  Aggregations({this.attributeCode, this.label, this.count, this.options});

  Aggregations.fromJson(Map<String, dynamic> json) {
    attributeCode = json['attribute_code'];
    label = json['label'];
    count = json['count'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_code'] = this.attributeCode;
    data['label'] = this.label;
    data['count'] = this.count;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? count;
  String? label;
  String? value;

  Options({this.count, this.label, this.value});

  Options.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}