import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widget/app_snackbar.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final profile = controller.profileData;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_outlined,
                  size: 20, color: Colors.black),
              onPressed: () {
                AppSnackbar.show(
                  context,
                  title: "Edit Profile",
                  message: "Feature coming soon!",
                );
              },
            ),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Main Info"),
              Tab(text: "Contact"),
              Tab(text: "Settings"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Main Info Tab
            _buildMainInfoTab(context, profile),

            // Contact Tab
            _buildContactTab(profile),

            // Settings Tab
            _buildSettingsTab(context, profile),
          ],
        ),
      ),
    );
  }

  Widget _buildMainInfoTab(BuildContext context, Map<String, dynamic> profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Profile Header
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(profile['photoPath']),
          ),
          const SizedBox(height: 16),
          Text(
            profile['fullName'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            profile['nim'],
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),

          // Essential Contact Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                _buildEssentialContactItem(
                  icon: Icons.phone,
                  value: profile['contact']['phone'],
                ),
                const Divider(height: 16),
                _buildEssentialContactItem(
                  icon: Icons.email,
                  value: profile['contact']['email'],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Switch to Assistant Mode Button
          ElevatedButton(
            onPressed: () {
              AppSnackbar.show(
                context,
                title: "Switch Role",
                message: "Switching to assistant mode...",
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Switch to Assistant Mode",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Info Cards
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  icon: Icons.person,
                  title: "Gender",
                  value: profile['gender'],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard(
                  icon: Icons.cake,
                  title: "Birth Date",
                  value: profile['birthDate'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Address Section
          _buildSection(
            title: "Address Information",
            items: [
              _buildDetailItem(
                icon: Icons.home,
                title: "Home Address",
                value: profile['addressHome'],
              ),
              _buildDetailItem(
                icon: Icons.location_on,
                title: "Current Address",
                value: profile['addressNow'],
              ),
            ],
          ),
          const SizedBox(height: 150),
        ],
      ),
    );
  }

  Widget _buildEssentialContactItem({
    required IconData icon,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue[700], size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactTab(Map<String, dynamic> profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildSection(
            title: "Contact Information",
            items: [
              _buildDetailItem(
                icon: Icons.email,
                title: "Email",
                value: profile['contact']['email'],
              ),
              _buildDetailItem(
                icon: Icons.phone,
                title: "Phone",
                value: profile['contact']['phone'],
              ),
              _buildDetailItem(
                icon: Icons.facebook,
                title: "Facebook",
                value: profile['contact']['facebook'],
              ),
              _buildDetailItem(
                icon: Icons.chat_rounded,
                title: "WhatsApp",
                value: profile['contact']['whatsapp'],
              ),
              _buildDetailItem(
                icon: Icons.chat,
                title: "Line",
                value: profile['contact']['line'],
              ),
              _buildDetailItem(
                icon: Icons.video_call,
                title: "Skype",
                value: profile['contact']['skype'],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab(BuildContext context, Map<String, dynamic> profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account Settings Section
          const Text(
            "Account Settings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSettingsItem(
                  icon: Icons.notifications_outlined,
                  title: "Notifications",
                  subtitle: "Manage your notifications",
                  onTap: () {
                    AppSnackbar.show(
                      context,
                      title: "Notifications",
                      message: "Feature coming soon!",
                    );
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.lock_outline,
                  title: "Privacy",
                  subtitle: "Control your privacy settings",
                  onTap: () {
                    AppSnackbar.show(
                      context,
                      title: "Privacy Settings",
                      message: "Feature coming soon!",
                    );
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.language_outlined,
                  title: "Language",
                  subtitle: "Change app language",
                  onTap: () {
                    AppSnackbar.show(
                      context,
                      title: "Language Settings",
                      message: "Feature coming soon!",
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Role Management Section
          const Text(
            "Role Management",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSettingsItem(
                  icon: Icons.swap_horiz,
                  title: "Switch to Assistant Mode",
                  subtitle: "Change your role to assistant",
                  isOrange: true,
                  onTap: () {
                    AppSnackbar.show(
                      context,
                      title: "Switch Role",
                      message: "Switching to assistant mode...",
                      backgroundColor: Colors.orange,
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Account Actions Section
          const Text(
            "Account Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSettingsItem(
                  icon: Icons.help_outline,
                  title: "Help Center",
                  subtitle: "Get help and support",
                  onTap: () {
                    AppSnackbar.show(
                      context,
                      title: "Help Center",
                      message: "Feature coming soon!",
                    );
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.info_outline,
                  title: "About App",
                  subtitle: "Version and information",
                  onTap: () {
                    AppSnackbar.show(
                      context,
                      title: "About App",
                      message: "Version 1.0.0",
                    );
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.logout,
                  title: "Logout",
                  subtitle: "Sign out from your account",
                  isRed: true,
                  onTap: () {
                    AppSnackbar.show(
                      context,
                      title: "Logout",
                      message: "Logging out...",
                      backgroundColor: Colors.red,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 150),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isOrange = false,
    bool isRed = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isOrange
                    ? Colors.orange.withOpacity(0.1)
                    : isRed
                        ? Colors.red.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isOrange
                    ? Colors.orange
                    : isRed
                        ? Colors.red
                        : Colors.blue,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isRed ? Colors.red : Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue[700]),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue[700], size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
