import 'package:flutter/material.dart';
import '../modules/home/views/home_view.dart';
import '../modules/left-stuff/views/left_stuff_view.dart';
import '../modules/profile/views/profile_view.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0; // Index aktif navbar

  // Daftar halaman yang akan dipanggil
  final List<Widget> _pages = [
    const HomeView(), // Halaman Home
    const LeftStuffView(), // Halaman Left Stuff
    const ProfileView(), // Halaman Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex], // Halaman sesuai index navbar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Floating posisi
              child: Container(
                height: 60, // Tinggi navbar
                width: MediaQuery.of(context).size.width * 0.8, // Lebar relatif
                decoration: BoxDecoration(
                  color: Colors.white, // Warna latar belakang flat
                  borderRadius: BorderRadius.circular(30), // Membulat
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15), // Soft shadow
                      blurRadius: 15,
                      offset: const Offset(0, 5), // Posisi bayangan
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.home,
                      index: 0,
                      identifier: 'nav_home',
                      label: 'Home',
                    ),
                    _buildNavItem(
                      icon: Icons.inventory,
                      index: 1,
                      identifier: 'nav_lost_found',
                      label: 'Lost & Found',
                    ),
                    _buildNavItem(
                      icon: Icons.person,
                      index: 2,
                      identifier: 'nav_profile',
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required String identifier,
    required String label,
  }) {
    final bool isSelected = _currentIndex == index;
    return Semantics(
      identifier: identifier,
      button: true,
      label: label,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index; // Update index saat di-tap
          });
        },
        child: Icon(
          icon,
          color: isSelected
              ? Colors.orange
              : Colors.grey, // Warna oranye saat aktif
          size: 24, // Ukuran kecil
        ),
      ),
    );
  }
}
