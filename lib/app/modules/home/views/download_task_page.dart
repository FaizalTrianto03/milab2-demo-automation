import 'download_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart'; // Import your controller here
// Import the class detail page

class DownloadTaskPage extends StatelessWidget {
  const DownloadTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the instance of HomeController
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Download Task",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Listen for changes in the controller's data
          return ListView.builder(
            itemCount: controller.schedule.length, // Using schedule here
            itemBuilder: (context, index) {
              final classData = controller.schedule[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to the ClassDetailPage
                  final classData = controller.classList[index]; // Getting class data
                  Get.to(() => DownloadPage(classData: classData));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      classData['namaPraktikum'] ?? "Unknown Class",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        // Displaying Day and Seat in the subtitle
                        Text(
                          '${classData['day'] ?? "Unknown Day"}  |  ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          'Seat: ${classData['seat'] ?? "N/A"}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
