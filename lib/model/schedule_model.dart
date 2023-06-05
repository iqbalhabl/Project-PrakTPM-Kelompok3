import 'package:http/http.dart' as http;
import 'dart:convert';

class Schedule {
  bool? status;
  Data? data;

  Schedule({this.status, this.data});

  Schedule.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? id;
  String? lokasi;
  String? daerah;
  Koordinat? koordinat;
  Jadwal? jadwal;

  Data({this.id, this.lokasi, this.daerah, this.koordinat, this.jadwal});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lokasi = json['lokasi'];
    daerah = json['daerah'];
    koordinat = json['koordinat'] != null
        ? Koordinat.fromJson(json['koordinat'])
        : null;
    jadwal = json['jadwal'] != null ? Jadwal.fromJson(json['jadwal']) : null;
  }
}

class Koordinat {
  double? lat;
  double? lon;
  String? lintang;
  String? bujur;

  Koordinat({this.lat, this.lon, this.lintang, this.bujur});

  Koordinat.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    lintang = json['lintang'];
    bujur = json['bujur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['lintang'] = lintang;
    data['bujur'] = bujur;
    return data;
  }
}

class Jadwal {
  String? tanggal;
  String? imsak;
  String? subuh;
  String? terbit;
  String? dhuha;
  String? dzuhur;
  String? ashar;
  String? maghrib;
  String? isya;
  String? date;

  Jadwal(
      {this.tanggal,
      this.imsak,
      this.subuh,
      this.terbit,
      this.dhuha,
      this.dzuhur,
      this.ashar,
      this.maghrib,
      this.isya,
      this.date});

  static List<Jadwal> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Jadwal.fromJson(json)).toList();
  }

  Jadwal.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    imsak = json['imsak'];
    subuh = json['subuh'];
    terbit = json['terbit'];
    dhuha = json['dhuha'];
    dzuhur = json['dzuhur'];
    ashar = json['ashar'];
    maghrib = json['maghrib'];
    isya = json['isya'];
    date = json['date'];
  }

  static Future<List<Jadwal>> fetchJadwal(String? kodeKota) async {
    List<Jadwal> results = [];
    final response = await http.get(Uri.parse(
        'https://api.myquran.com/v1/sholat/jadwal/$kodeKota/2023/08'));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    print('response body : $jsonData');
    if (jsonData.containsKey('data')) {
      final jadwalList = jsonData['data']['jadwal'] as List<dynamic>;
      results =
          jadwalList.map((jadwalJson) => Jadwal.fromJson(jadwalJson)).toList();
    }
    print('results : $results');
    return results;
  }
}
