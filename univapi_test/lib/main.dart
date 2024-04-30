import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Model untuk menyimpan data universitas
class University {
  final String name;
  final String? stateProvince;
  final List<String> domains;
  final List<String> webPages;
  final String alphaTwoCode;
  final String country;

  University({
    required this.name,
    this.stateProvince,
    required this.domains,
    required this.webPages,
    required this.alphaTwoCode,
    required this.country,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      stateProvince: json['state-province'],
      domains: List<String>.from(json['domains']),
      webPages: List<String>.from(json['web_pages']),
      alphaTwoCode: json['alpha_two_code'],
      country: json['country'],
    );
  }
}

Future<List<University>> fetchUniversities() async {
  final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=Indonesia'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => University.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load universities');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<University>> futureUniversities;

  @override
  void initState() {
    super.initState();
    futureUniversities = fetchUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Indonesian Universities'),
        ),
        body: FutureBuilder<List<University>>(
          future: futureUniversities,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final university = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              university.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text('State/Province: '),
                                Text(university.stateProvince ?? 'N/A'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Domains: '),
                                Text(university.domains.join(', ')),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Web Pages: '),
                                Text(university.webPages.join(', ')),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Alpha Two Code: '),
                                Text(university.alphaTwoCode),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Country: '),
                                Text(university.country),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
