import 'dart:math';

// Daftar nama asisten lab
final List<String> asistenLab = [
  "Asisten A",
  "Asisten B",
  "Asisten C",
  "Asisten D",
  "Asisten E"
];

// Fungsi untuk memilih nama asisten secara acak
String getRandomAsisten() {
  final random = Random();
  return asistenLab[random.nextInt(asistenLab.length)];
}

// Data Dummy Praktikum dengan 3 kelas
final List<Map<String, dynamic>> praktikumDummy = [
  {
    "namaPraktikum": "Pemrograman Mobile E",
    "finalGrade": "A",
    "schedule": {
      "day": "Monday",
      "startTime": "08:00",
      "endTime": "10:00",
      "location": "Lab A",
      "seat": "A23"
    },
    "tasks": [
      {
        "title": "Modul 1",
        "deskripsi": "Dasar Pemrograman Mobile.",
        "grade": "A",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": false}
      },
      {
        "title": "Modul 2",
        "deskripsi": "Mengenal UI dan UX.",
        "grade": "B+",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "Modul 3",
        "deskripsi": "State Management Dasar.",
        "grade": "B",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": false, "presensi2": true}
      },
      {
        "title": "Modul 4",
        "deskripsi": "Integrasi API.",
        "grade": "A",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "Modul 5",
        "deskripsi": "Testing dan Debugging.",
        "grade": "B+",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "Modul 6",
        "deskripsi": "Deployment Aplikasi.",
        "grade": "A+",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "UAP",
        "deskripsi": "Ujian Akhir Praktikum.",
        "grade": "B",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": false}
      }
    ]
  },
  {
    "namaPraktikum": "Pemrograman Mobile F",
    "finalGrade": "B+",
    "schedule": {
      "day": "Wednesday",
      "startTime": "13:00",
      "endTime": "15:00",
      "location": "Lab B",
      "seat": "B15"
    },
    "tasks": [
      {
        "title": "Modul 1",
        "deskripsi": "Dasar Pemrograman Mobile.",
        "grade": "A",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": false}
      },
      {
        "title": "Modul 2",
        "deskripsi": "Mengenal UI dan UX.",
        "grade": "B+",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "Modul 3",
        "deskripsi": "State Management Dasar.",
        "grade": "B",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": false, "presensi2": true}
      },
      {
        "title": "Modul 4",
        "deskripsi": "Integrasi API.",
        "grade": "A",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "Modul 5",
        "deskripsi": "Testing dan Debugging.",
        "grade": "B+",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "Modul 6",
        "deskripsi": "Deployment Aplikasi.",
        "grade": "A+",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "UAP",
        "deskripsi": "Ujian Akhir Praktikum.",
        "grade": "B",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": false}
      }
    ]
  },
  {
    "namaPraktikum": "Pemrograman Mobile G",
    "finalGrade": "A+",
    "schedule": {
      "day": "Friday",
      "startTime": "15:00",
      "endTime": "17:00",
      "location": "Lab C",
      "seat": "C12"
    },
    "tasks": [
      {
        "title": "Modul 1",
        "deskripsi": "Dasar Pemrograman Mobile.",
        "grade": "A",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": false}
      },
      {
        "title": "Modul 2",
        "deskripsi": "Mengenal UI dan UX.",
        "grade": "B+",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "Modul 3",
        "deskripsi": "State Management Dasar.",
        "grade": "B",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": false, "presensi2": true}
      },
      {
        "title": "Modul 4",
        "deskripsi": "Integrasi API.",
        "grade": "A",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "Modul 5",
        "deskripsi": "Testing dan Debugging.",
        "grade": "B+",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "Modul 6",
        "deskripsi": "Deployment Aplikasi.",
        "grade": "A+",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": true}
      },
      {
        "title": "UAP",
        "deskripsi": "Ujian Akhir Praktikum.",
        "grade": "B",
        "gradedBy": getRandomAsisten(),
        "presensi": {"presensi1": true, "presensi2": false}
      }
    ]
  }
];
