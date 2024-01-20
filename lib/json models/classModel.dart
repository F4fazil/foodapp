class DataProductModel {
  String? name;
  String? path;

  DataProductModel({this.name, this.path});

  DataProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    return data;
  }
}

class product {
  String? name;
  String? path;
  String? description;
  String? price;

  product({this.name, this.path, this.description, this.price});

  product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    data['description'] = description;
    data['price'] = price;
    return data;
  }
}
class recommended {
  String? name;
  String? path;
  String? description;
  String? price;

  recommended({this.name, this.path, this.description, this.price});

  recommended.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    data['description'] = description;
    data['price'] = price;
    return data;
  }
}

