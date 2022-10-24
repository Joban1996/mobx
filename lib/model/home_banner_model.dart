class HomeBannerModel {
  CmsBlocks? cmsBlocks;

  HomeBannerModel({this.cmsBlocks});

  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    cmsBlocks = json['cmsBlocks'] != null
        ? new CmsBlocks.fromJson(json['cmsBlocks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cmsBlocks != null) {
      data['cmsBlocks'] = this.cmsBlocks!.toJson();
    }
    return data;
  }
}

class CmsBlocks {
  List<Items>? items;

  CmsBlocks({this.items});

  CmsBlocks.fromJson(Map<String, dynamic> json) {
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
  String? identifier;
  String? title;
  String? content;

  Items({this.identifier, this.title, this.content});

  Items.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}