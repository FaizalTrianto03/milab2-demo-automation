import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widget/app_snackbar.dart';

class DetailLeftStuffView extends StatelessWidget {
  final Map<String, dynamic> item;

  const DetailLeftStuffView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isTaken = item['taken'] != null;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Item Details"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Status Chip
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isTaken
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isTaken ? Icons.check_circle : Icons.access_time,
                          size: 20,
                          color: isTaken ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isTaken ? "Claimed" : "Unclaimed",
                          style: TextStyle(
                            color: isTaken ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Item Details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailSection(
                        "Item Name",
                        item['itemName'],
                        Icons.inventory_2_outlined,
                      ),
                      _buildDetailSection(
                        "Location",
                        item['location'],
                        Icons.location_on_outlined,
                      ),
                      _buildDetailSection(
                        "Notes",
                        item['note'],
                        Icons.notes_outlined,
                      ),
                      _buildDetailSection(
                        "Posted",
                        item['post'],
                        Icons.calendar_today_outlined,
                      ),
                      const SizedBox(height: 20),

                      if (item['images'] != null) ...[
                        const Text(
                          "Photos",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 100), // Space for bottom buttons
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildActionButton(
                title: "Contact",
                icon: Icons.chat_outlined,
                color: Colors.green,
                onPressed: () => _contactOwner(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                title: "Claim",
                icon: Icons.check_circle_outline,
                color: Colors.orange,
                onPressed: () => _markAsClaimed(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue[700], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white, // Set icon color to white
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Set text color to white
            ),
          ),
        ],
      ),
    );
  }

  IconData _getItemIcon(String itemName) {
    itemName = itemName.toLowerCase();
    if (itemName.contains('phone') || itemName.contains('hp')) {
      return Icons.phone_android;
    } else if (itemName.contains('book') || itemName.contains('buku')) {
      return Icons.book;
    } else if (itemName.contains('card') || itemName.contains('kartu')) {
      return Icons.credit_card;
    } else if (itemName.contains('key') || itemName.contains('kunci')) {
      return Icons.key;
    } else if (itemName.contains('wallet') || itemName.contains('dompet')) {
      return Icons.account_balance_wallet;
    } else {
      return Icons.inventory_2;
    }
  }

  void _contactOwner(BuildContext context) {
    AppSnackbar.show(
      context,
      title: 'Contact Owner',
      message: 'Opening chat with owner...',
      backgroundColor: Colors.green,
      icon: Icons.chat,
    );
  }

  void _markAsClaimed(BuildContext context) {
    AppSnackbar.show(
      context,
      title: 'Item Claimed',
      message: 'Processing your claim...',
      backgroundColor: Colors.orange,
      icon: Icons.check_circle,
    );
  }
}
