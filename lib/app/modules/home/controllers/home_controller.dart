import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/bad_student_dummy.dart';
import '../../../data/otherservice.dart';
import '../../../data/left_stuff_dummy.dart';
import '../../../data/data_praktikum_dummy.dart';

class HomeController extends GetxController {
  // Menu Items
  final List<Map<String, dynamic>> menuItems = [
    {"title": "My Class", "icon": Icons.school},
    {"title": "Download Task", "icon": Icons.file_download},
  ];

  // Dummy Data Sources
  final otherServices = otherFeaturesDummy;
  final badStudents = badStudentDummy;
  final leftStuff = leftStuffDummy;

  // Page Indicator
  final currentPage = 0.obs;

  // Reactive Lists
  final schedule = <Map<String, dynamic>>[].obs;
  final classList = <Map<String, dynamic>>[].obs;
  final tasksList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  void loadAllData() {
    // Load data langsung dari praktikumDummy
    classList.value = praktikumDummy;
    
    // Load schedule
    schedule.value = praktikumDummy.map((praktikum) {
      return {
        "namaPraktikum": praktikum['namaPraktikum'],
        ...praktikum['schedule'] as Map<String, dynamic>,
      };
    }).toList();

    // Load tasks
    tasksList.clear();
    for (var praktikum in praktikumDummy) {
      final tasks = praktikum['tasks'] as List;
      for (var task in tasks) {
        tasksList.add({
          "class": praktikum['namaPraktikum'],
          ...task as Map<String, dynamic>,
        });
      }
    }

    print('Data loaded successfully:');
    print('Classes: ${classList.length}');
    print('Schedules: ${schedule.length}');
    print('Tasks: ${tasksList.length}');
  }

  // Helper method untuk mendapatkan kelas berdasarkan nama
  Map<String, dynamic>? getClassByName(String className) {
    try {
      return classList.firstWhere(
        (classItem) => classItem['namaPraktikum'] == className,
      );
    } catch (e) {
      print('Error getting class by name: $e');
      return null;
    }
  }

  // Helper method untuk mendapatkan tasks berdasarkan kelas
  List<Map<String, dynamic>> getTasksByClass(String className) {
    return tasksList.where((task) => task['class'] == className).toList();
  }

  // Method untuk refresh data
  void refreshData() {
    loadAllData();
  }
}