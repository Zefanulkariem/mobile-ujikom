class OperasionalResponse {
  final bool success;
  final Data? data;

  OperasionalResponse({required this.success, this.data});

  factory OperasionalResponse.fromJson(Map<String, dynamic> json) {
    return OperasionalResponse(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class Data {
  final int id;
  final int idUmkm;
  final String jmlKaryawan;
  final String createdAt;
  final String updatedAt;
  final User? user;

  Data({
    required this.id,
    required this.idUmkm,
    required this.jmlKaryawan,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      idUmkm: json['id_umkm'],
      jmlKaryawan: json['jml_karyawan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_umkm': idUmkm,
      'jml_karyawan': jmlKaryawan,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? fotoProfil;
  final String gender;
  final String noTelp;
  final String alamat;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.fotoProfil,
    required this.gender,
    required this.noTelp,
    required this.alamat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      fotoProfil: json['foto_profil'],
      gender: json['gender'],
      noTelp: json['no_telp'],
      alamat: json['alamat'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'foto_profil': fotoProfil,
      'gender': gender,
      'no_telp': noTelp,
      'alamat': alamat,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
