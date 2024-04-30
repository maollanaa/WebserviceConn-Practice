import 'dart:convert';

void main() {
  // Data JSON transkrip
  String jsonTranskrip = '''{
    "nama": "Rakha Maulana",
    "nim": "22082010077",
    "jurusan": "Sistem Informasi",
    "semester": [
      {
        "semester": 1,
        "mata_kuliah": [
          {
            "nama": "Matematika Komputasi",
            "sks": 3,
            "nilai": 4.0
          },
          {
            "nama": "Pengetahuan Bisnis",
            "sks": 3,
            "nilai": 3.6
          },
          {
            "nama": "Bahasa Pemorgraman",
            "sks": 3,
            "nilai": 3.6
          }
        ]
      },
      {
        "semester": 2,
        "mata_kuliah": [
          {
            "nama": "Basis Data",
            "sks": 3,
            "nilai": 3.7
          },
          {
            "nama": "Rekayasa Perangkat Lunaka",
            "sks": 3,
            "nilai": 4.0
          },
          {
            "nama": "Analisis Proses Bisnis",
            "sks": 3,
            "nilai": 3.8
          }
        ]
      }
    ]
  }''';

  // Decode JSON
  Map<String, dynamic> data = jsonDecode(jsonTranskrip);

  // Menghitung total SKS dan jumlah nilai * SKS
  double totalSks = 0;
  double totalNilaiSks = 0;

  for (var semester in data['semester']) {
    for (var matkul in semester['mata_kuliah']) {
      int sks = matkul['sks'];
      double nilai = matkul['nilai'];

      totalSks += sks;
      totalNilaiSks += sks * nilai;
    }
  }

  // Menghitung IPK
  double ipk = totalNilaiSks / totalSks;

  print('IPK Rakha Maulana: ${ipk.toStringAsFixed(2)}');
}