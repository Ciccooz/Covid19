import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Data>> fetchDataList() async {
  final response = await http.get('https://corona.lmao.ninja/v2/countries');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    return parsed.map<Data>((json) => Data.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get Data');
  }
}

class Data {
  final String country;
  final int cases;
  final int deaths;
  final int recovered;

  Data({
    this.country,
    this.cases,
    this.deaths,
    this.recovered
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      country: json['country'] as String,
      cases: json['cases'] as int,
      deaths: json['deaths'] as int,
      recovered: json['recovered'] as int
    );
  }
}
