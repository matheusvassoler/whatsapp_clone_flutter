class Contact {
  String phone;
  String name;
  String picture;

  Contact(
      {this.phone,
        this.name,
        this.picture});

  Contact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['picture'] = this.picture;
    return data;
  }
}