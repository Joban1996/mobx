class SearchDataModel {
  Products? products;

  SearchDataModel({this.products});

  SearchDataModel.fromJson(Map<String, dynamic> json) {
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
  List<Items>? items;
  PageInfo? pageInfo;

  Products({this.totalCount, this.items, this.pageInfo});

  Products.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
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
    data['total_count'] = this.totalCount;
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
  int? specialPrice;

  Items({this.name, this.sku, this.specialPrice});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sku = json['sku'];
    specialPrice = json['special_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['special_price'] = this.specialPrice;
    return data;
  }
}

class PageInfo {
  int? pageSize;
  int? currentPage;

  PageInfo({this.pageSize, this.currentPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    pageSize = json['page_size'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_size'] = this.pageSize;
    data['current_page'] = this.currentPage;
    return data;
  }
}