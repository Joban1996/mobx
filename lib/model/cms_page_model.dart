class CmsPageModel {
  CmsPage? cmsPage;

  CmsPageModel({this.cmsPage});

  CmsPageModel.fromJson(Map<String, dynamic> json) {
    cmsPage =
    json['cmsPage'] != null ? new CmsPage.fromJson(json['cmsPage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cmsPage != null) {
      data['cmsPage'] = this.cmsPage!.toJson();
    }
    return data;
  }
}

class CmsPage {
  String? identifier;
  String? urlKey;
  String? title;
  String? content;
  String? contentHeading;

  CmsPage(
      {this.identifier,
        this.urlKey,
        this.title,
        this.content,
        this.contentHeading});

  CmsPage.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    urlKey = json['url_key'];
    title = json['title'];
    content = json['content'];
    contentHeading = json['content_heading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['url_key'] = this.urlKey;
    data['title'] = this.title;
    data['content'] = this.content;
    data['content_heading'] = this.contentHeading;
    return data;
  }
}