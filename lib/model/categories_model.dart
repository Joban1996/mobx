class CategoriesModel {
  Categories? categories;

  CategoriesModel({this.categories});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    return data;
  }
}

class Categories {
  int? totalCount;
  List<Items>? items;
  PageInfo? pageInfo;

  Categories({this.totalCount, this.items, this.pageInfo});

  Categories.fromJson(Map<String, dynamic> json) {
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
  String? uid;
  int? level;
  String? name;
  String? path;
  String? childrenCount;
  List<Children>? children;

  Items(
      {this.uid,
        this.level,
        this.name,
        this.path,
        this.childrenCount,
        this.children});

  Items.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    level = json['level'];
    name = json['name'];
    path = json['path'];
    childrenCount = json['children_count'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['level'] = this.level;
    data['name'] = this.name;
    data['path'] = this.path;
    data['children_count'] = this.childrenCount;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? uid;
  int? level;
  String? name;
  String? path;

  Children({this.uid, this.level, this.name, this.path});

  Children.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    level = json['level'];
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['level'] = this.level;
    data['name'] = this.name;
    data['path'] = this.path;
    return data;
  }
}

class PageInfo {
  int? currentPage;
  int? pageSize;
  int? totalPages;

  PageInfo({this.currentPage, this.pageSize, this.totalPages});

  PageInfo.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    pageSize = json['page_size'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['page_size'] = this.pageSize;
    data['total_pages'] = this.totalPages;
    return data;
  }
}