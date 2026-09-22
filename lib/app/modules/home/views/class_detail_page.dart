import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ClassDetailPage extends StatelessWidget {
  final Map<String, dynamic> classData;

  const ClassDetailPage({Key? key, required this.classData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = classData['tasks'] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _getShortClassName(classData['namaPraktikum'] ?? "Class Details"),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFinalGradeCard(classData['finalGrade']),
            const SizedBox(height: 24),
            ...tasks.map((task) => _buildTaskCard(task, context)).toList(),
          ],
        ),
      ),
    );
  }

  String _getShortClassName(String className) {
    return className.split(" ").map((word) => word[0]).join();
  }

  Widget _buildFinalGradeCard(String? finalGrade) {
    final gradeColor = _getGradeColor(finalGrade);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      color: gradeColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Final Grade",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              finalGrade ?? "-",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task, BuildContext context) {
    final gradeColor = _getGradeColor(task['grade']);
    final presensi = task['presensi'] as Map<String, dynamic>? ?? {};

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0, // No shadow
      color: Colors.grey.shade100, // Light background
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            Text(
              task['title'] ?? "Unknown Task",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Task Description
            Text(
              task['deskripsi'] ?? "-",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),

            // Buttons and Graded By
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Grade Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showGradePopup(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gradeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Grade: ${task['grade'] ?? '-'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Check Presence Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showPresencePopup(context, presensi);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Check Presence",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Graded By Section
            Row(
  children: [
    // Expanded agar teks mengambil sisa ruang yang tersedia
    Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Lebih lega
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2), // Background abu-abu muda dengan transparansi
          borderRadius: BorderRadius.circular(8), // Rounded corners
          border: Border.all( // Menambahkan border
            color: Colors.black.withOpacity(0.3), // Border hitam tipis dengan transparansi
            width: 1, // Ketebalan border
          ),
        ),
        child: Text(
          "Graded by: ${task['gradedBy'] ?? 'Unknown'}", // Menampilkan nama grader atau "Unknown"
          style: const TextStyle(
            fontSize: 16, // Ukuran font lebih besar
            fontWeight: FontWeight.bold, // Font tebal
            color: Colors.grey, // Warna teks abu-abu
            fontStyle: FontStyle.italic, // Teks italic
          ),
        ),
      ),
    ),
  ],
)

          ],
        ),
      ),
    );
  }

  void _showGradePopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.75,  // Adjust the initial size of the popup
            minChildSize: 0.6,       // Set minimum size
            maxChildSize: 0.9,       // Set maximum size
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Background Decoration
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -60,
                      left: -30,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Main Content
                    ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      children: [
                        // Drag Handle with Animation
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // File Upload Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Submit Your Work",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(12),
                                color: Colors.grey.shade400,
                                strokeWidth: 2,
                                dashPattern: const [8, 4],
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: 120,
                                    width: double.infinity,
                                    color: Colors.grey.shade50,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.cloud_upload_outlined, 
                                          size: 40, color: Colors.grey.shade600),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Drag and drop or click to upload",
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Download Button (with orange color)
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade600,  // Changed to orange
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.download, color: Colors.white),
                              const SizedBox(width: 10),
                              Text(
                                "Download Attachment",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Grade Details Section
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildGradeDetailCard("Demo", "A"),
                              _buildGradeDetailCard("Materi", "A"),
                              _buildGradeDetailCard("Praktik", "B+"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}

Widget _buildGradeDetailCard(String title, String grade) {
  Color gradeColor = _getGradeColor(grade);
  
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: gradeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            grade,
            style: TextStyle(
              color: gradeColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

  void _showPresencePopup(BuildContext context, Map<String, dynamic> presensi) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildPresenceStep("Presence 1", presensi['presensi1']),
              const SizedBox(height: 16),
              _buildPresenceStep("Presence 2", presensi['presensi2']),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPresenceStep(String title, bool? present) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: present == true ? Colors.green : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              present == true ? Icons.check : Icons.close,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: present == true ? Colors.green : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getGradeColor(String? grade) {
    switch (grade) {
      case "A":
        return const Color.fromARGB(255, 7, 217, 91);
      case "B":
      case "B+":
        return Colors.blue;
      case "C":
      case "C+":
        return Colors.orangeAccent;
      case "D":
      case "E":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
