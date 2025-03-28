class MeetingResponse {
  bool? success;
  String? message;
  List<MeetingData>? data;

  MeetingResponse({this.success, this.message, this.data});

  factory MeetingResponse.fromJson(Map<String, dynamic> json) {
    return MeetingResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List?)
          ?.map((item) => MeetingData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class MeetingData {
  int? id;
  int? idInvestor;
  int? idUmkm;
  String? judul;
  String? lokasiMeeting;
  String? tanggal;
  String? statusVerifikasi;
  String? createdAt;
  String? updatedAt;

  MeetingData({
    this.id,
    this.idInvestor,
    this.idUmkm,
    this.judul,
    this.lokasiMeeting,
    this.tanggal,
    this.statusVerifikasi,
    this.createdAt,
    this.updatedAt,
  });

  factory MeetingData.fromJson(Map<String, dynamic> json) {
    return MeetingData(
      id: json['id'],
      idInvestor: json['id_investor'],
      idUmkm: json['id_umkm'],
      judul: json['judul'],
      lokasiMeeting: json['lokasi_meeting'],
      tanggal: json['tanggal'],
      statusVerifikasi: json['status_verifikasi'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_investor': idInvestor,
      'id_umkm': idUmkm,
      'judul': judul,
      'lokasi_meeting': lokasiMeeting,
      'tanggal': tanggal,
      'status_verifikasi': statusVerifikasi,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
