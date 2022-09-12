class FavoriteModel {
  List<Favorite>? favorite;

  FavoriteModel({this.favorite});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    if (json['favorite'] != null) {
      favorite = <Favorite>[];
      json['favorite'].forEach((v) {
        favorite!.add(new Favorite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favorite != null) {
      data['favorite'] = this.favorite!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favorite {
  String? name;

  Favorite({this.name});

  Favorite.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
