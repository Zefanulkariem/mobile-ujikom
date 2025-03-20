class MapsResponse {
  String? status;
  List<UMKMData>? data;

  MapsResponse({this.status, this.data});

  MapsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UMKMData>[];
      json['data'].forEach((v) {
        data!.add(UMKMData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class UMKMData {
  int id;
  String lat;
  String lon;
  String desa;
  String kecamatan;
  String deskripsi;
  String image;
  String namaPemilik;
  String kelamin;
  String namaUmkm;
  String jenisUmkm;
  String link;
  List<Keuangan> keuangan;

  UMKMData({
    required this.id,
    required this.lat,
    required this.lon,
    required this.desa,
    required this.kecamatan,
    required this.deskripsi,
    required this.image,
    required this.namaPemilik,
    required this.kelamin,
    required this.namaUmkm,
    required this.jenisUmkm,
    required this.link,
    required this.keuangan,
  });

  factory UMKMData.fromJson(Map<String, dynamic> json) {
    return UMKMData(
      id: json['id'],
      lat: json['lat'],
      lon: json['lon'],
      desa: json['desa'],
      kecamatan: json['kecamatan'],
      deskripsi: json['deskripsi'],
      image: json['image'],
      namaPemilik: json['nama_pemilik'],
      kelamin: json['kelamin'],
      namaUmkm: json['nama_umkm'],
      jenisUmkm: json['jenis_umkm'],
      link: json['link'],
      keuangan: (json['keuangan'] as List<dynamic>)
          .map((e) => Keuangan.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'lon': lon,
      'desa': desa,
      'kecamatan': kecamatan,
      'deskripsi': deskripsi,
      'image': image,
      'nama_pemilik': namaPemilik,
      'kelamin': kelamin,
      'nama_umkm': namaUmkm,
      'jenis_umkm': jenisUmkm,
      'link': link,
      'keuangan': keuangan.map((e) => e.toJson()).toList(),
    };
  }
}

class Keuangan {
  String tanggal;
  int income;
  int outcome;
  int profitLoss;
  String statusVerifikasi;

  Keuangan({
    required this.tanggal,
    required this.income,
    required this.outcome,
    required this.profitLoss,
    required this.statusVerifikasi,
  });

  factory Keuangan.fromJson(Map<String, dynamic> json) {
    return Keuangan(
      tanggal: json['tanggal'],
      income: json['income'],
      outcome: json['outcome'],
      profitLoss: json['profit_loss'],
      statusVerifikasi: json['status_verifikasi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'income': income,
      'outcome': outcome,
      'profit_loss': profitLoss,
      'status_verifikasi': statusVerifikasi,
    };
  }
}
