class University {
  List<String>? domains;
  String? alphaTwoCode;
  String? country;
  List<String>? webPages;
  String? name;
  String? stateProvince;

  University({this.domains, this.alphaTwoCode, this.country, this.webPages, this.name, this.stateProvince});

  University.fromJson(Map<String, dynamic> json) {
    domains = json['domains'].cast<String>();
    alphaTwoCode = json['alpha_two_code'];
    country = json['country'];
    webPages = json['web_pages'].cast<String>();
    name = json['name'];
    stateProvince = json['state-province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domains'] = this.domains;
    data['alpha_two_code'] = this.alphaTwoCode;
    data['country'] = this.country;
    data['web_pages'] = this.webPages;
    data['name'] = this.name;
    data['state-province'] = this.stateProvince;
    return data;
  }
}
