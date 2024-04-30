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
            "nilai": "A"
          },
          {
            "nama": "Pengetahuan Bisnis",
            "sks": 3,
            "nilai": "A"
          },
          {
            "nama": "Bahasa Pemorgraman",
            "sks": 3,
            "nilai": "B+"
          }
        ]
      },
      {
        "semester": 2,
        "mata_kuliah": [
          {
            "nama": "Basis Data",
            "sks": 3,
            "nilai": "A-"
          },
          {
            "nama": "Rekayasa Perangkat Lunaka",
            "sks": 3,
            "nilai": "A"
          },
          {
            "nama": "Analisis Proses Bisnis",
            "sks": 3,
            "nilai": "B+"
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
      String nilai = matkul['nilai'];

      // Mengonversi nilai huruf ke nilai angka
      double nilaiAngka = _konversiNilai(nilai);

      totalSks += sks;
      totalNilaiSks += sks * nilaiAngka;
    }
  }

  // Menghitung IPK
  double ipk = totalNilaiSks / totalSks;

  print('IPK Rakha Maulana: ${ipk.toStringAsFixed(2)}');
}

double _konversiNilai(String nilai) {
  switch (nilai) {
    case 'A':
      return 4.0;
    case 'A-':
      return 3.7;
    case 'B+':
      return 3.3;
    case 'B':
      return 3.0;
    default:
      return 0.0;
  }
}