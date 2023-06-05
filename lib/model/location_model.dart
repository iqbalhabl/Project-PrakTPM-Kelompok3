import 'package:http/http.dart' as http;
import 'dart:convert';

class Location {
  String? id;
  String? lokasi;

  Location({this.id, this.lokasi});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lokasi = json['lokasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lokasi'] = lokasi;
    return data;
  }

  static Future<List<Location>> fetchLocation(String? query) async {
    var data = [];
    List<Location> results = [];
    final response = await http
        .get(Uri.parse('https://api.myquran.com/v1/sholat/kota/semua'));
    data = json.decode(response.body);
    results =
        data.map((locationJson) => Location.fromJson(locationJson)).toList();
    if (query != null) {
      results = results
          .where((element) =>
              element.lokasi!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    return results;
  }
}
