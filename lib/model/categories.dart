class Categories {
  String id;
  String name;
  String desc;
  String image;
  String shortName;

  Categories({this.id, this.name, this.desc, this.image, this.shortName});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    image = json['image'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['short_name'] = this.shortName;
    return data;
  }
}
