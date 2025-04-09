class ProfileResponse {
  int? id;
  String? name;
  String? email;
  String? noTelp;
  String? alamat;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  ProfileResponse(
      {this.id,
      this.name,
      this.email,
      this.noTelp,
      this.alamat,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    noTelp = json['no_telp'];
    alamat = json['alamat'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['no_telp'] = noTelp;
    data['alamat'] = alamat;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
