import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widget/app_snackbar.dart';
import '../controllers/home_controller.dart';
import 'class_detail_page.dart';

class MyClassPage extends StatelessWidget {
  const MyClassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "My Classes",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black54,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "Class"), // Tab pertama untuk Class
              Tab(text: "Schedule"), // Tab kedua untuk Schedule
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: List Class
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: controller.schedule.length,
                itemBuilder: (context, index) {
                  final classData = controller.schedule[index];
                  return GestureDetector(
                    onTap: () {
                      // Handle tap to navigate to the class detail page
                      final classData = controller.classList[
                          index]; // Getting class data including tasks
                      Get.to(() => ClassDetailPage(classData: classData));
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
              ),
            ),

            // Tab 2: Schedule
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: controller.schedule.length,
                itemBuilder: (context, index) {
                  final schedule = controller.schedule[index];
                  final day = schedule['day'] ?? 'Unknown Day';
                  final namaPraktikum =
                      schedule['namaPraktikum'] ?? 'Unknown Class';
                  final startTime = schedule['startTime'] ?? '--:--';
                  final endTime = schedule['endTime'] ?? '--:--';
                  final location = schedule['location'] ?? 'Unknown Location';
                  final seat = schedule['seat'] ?? 'N/A';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Praktikum di kiri dan Hari di kanan
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                namaPraktikum,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              day,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Informasi Waktu, Lokasi, dan Seat dalam satu baris
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Informasi Waktu
                            Column(
                              children: [
                                const Icon(Icons.access_time,
                                    size: 20, color: Colors.orange),
                                const SizedBox(height: 4),
                                Text(
                                  "$startTime - $endTime",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            // Informasi Lokasi
                            Column(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 20, color: Colors.orange),
                                const SizedBox(height: 4),
                                Text(
                                  location,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            // Informasi Seat
                            Column(
                              children: [
                                const Icon(Icons.chair,
                                    size: 20, color: Colors.orange),
                                const SizedBox(height: 4),
                                Text(
                                  "Seat: $seat",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Tombol Remember
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              AppSnackbar.show(
                                context,
                                title: "Reminder Set",
                                message:
                                    "You have set a reminder for $namaPraktikum",
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.notifications,
                                size: 18, color: Colors.white),
                            label: const Text(
                              "Remember",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
