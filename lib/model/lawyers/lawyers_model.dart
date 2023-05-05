class LawyersModel {
  int? id;
  String? uuid;
  String? name;
  String? address;
  String? state;
  String? fieldOfExpertise;
  String? bio;
  String? level;
  String? hoursLogged;
  String? phoneNo;
  String? email;
  String? profilPicture;
  String? rating;
  String? ranking;
  LawyersModel(
      {this.id,
      this.uuid,
      this.name,
      this.address,
      this.state,
      this.fieldOfExpertise,
      this.bio,
      this.level,
      this.hoursLogged,
      this.phoneNo,
      this.email,
      this.profilPicture,
      this.ranking,
      this.rating});

  factory LawyersModel.fomJson(Map<String, dynamic> json) => LawyersModel(
      name: json['name'],
      id: json["id"],
      uuid: json["uuid"],
      address: json["address"],
      state: json["state"],
      fieldOfExpertise: json["field_of_expertise"],
      bio: json["bio"],
      level: json["level"],
      hoursLogged: json["hours_logged"],
      phoneNo: json["phone_no"],
      email: json["email"],
      profilPicture: json["profile_picture"],
      ranking: json["ranking"],
      rating: json["rating"]);
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uuid": uuid,
      "name": name,
      "address": address,
      "state": state,
      "field_of_expertise": fieldOfExpertise,
      "bio": bio,
      "level": level,
      "hours_logged": hoursLogged,
      "phone_no": phoneNo,
      "email": email,
      "profile_picture": profilPicture,
      "rating": rating,
      "ranking": ranking
    };
  }
}
