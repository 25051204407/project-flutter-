import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authService = AuthService();

  void _logout() {
    // Dialog konfirmasi logout
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'Konfirmasi Logout',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              _authService.logout();
              Navigator.pop(context); // tutup dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data user yang login
    final user = _authService.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ===== AVATAR USER =====
          Center(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF00ADEF), Color(0xFF003C71)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white24, width: 3),
              ),
              child: Center(
                child: user != null
                    ? Text(
                        user.initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ===== NAMA USER =====
          Center(
            child: Text(
              user?.fullName ?? 'Guest User',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 6),

          // ===== EMAIL =====
          Center(
            child: Text(
              user?.email ?? 'guest@email.com',
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ),
          const SizedBox(height: 6),

          // ===== NO HP =====
          if (user != null && user.phone.isNotEmpty)
            Center(
              child: Text(
                user.phone,
                style: const TextStyle(color: Colors.white54, fontSize: 13),
              ),
            ),
          const SizedBox(height: 30),

          // ===== STATISTIK =====
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(child: _buildStat('6', 'Total Mobil')),
                Container(width: 1, height: 40, color: Colors.white24),
                Expanded(child: _buildStat('0', 'Favorit')),
                Container(width: 1, height: 40, color: Colors.white24),
                Expanded(child: _buildStat('0', 'Transaksi')),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // ===== MENU LIST =====
          const Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _menuItem(
            icon: Icons.person_outline,
            title: 'Edit Profil',
            subtitle: 'Ubah nama, email, dan foto',
            onTap: () => _showSnack('Fitur Edit Profil'),
          ),
          _menuItem(
            icon: Icons.history,
            title: 'Riwayat Transaksi',
            subtitle: 'Lihat pembelian sebelumnya',
            onTap: () => _showSnack('Fitur Riwayat Transaksi'),
          ),
          _menuItem(
            icon: Icons.favorite_border,
            title: 'Favorit Saya',
            subtitle: 'Mobil yang Anda sukai',
            onTap: () => _showSnack('Fitur Favorit'),
          ),
          _menuItem(
            icon: Icons.location_on_outlined,
            title: 'Alamat Pengiriman',
            subtitle: 'Kelola alamat Anda',
            onTap: () => _showSnack('Fitur Alamat'),
          ),
          const SizedBox(height: 20),

          // ===== PENGATURAN =====
          const Text(
            'Pengaturan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _menuItem(
            icon: Icons.notifications_outlined,
            title: 'Notifikasi',
            subtitle: 'Atur pemberitahuan',
            onTap: () => _showSnack('Fitur Notifikasi'),
          ),
          _menuItem(
            icon: Icons.lock_outline,
            title: 'Ubah Password',
            subtitle: 'Ganti kata sandi akun',
            onTap: () => _showSnack('Fitur Ubah Password'),
          ),
          _menuItem(
            icon: Icons.help_outline,
            title: 'Bantuan',
            subtitle: 'FAQ & customer service',
            onTap: () => _showSnack('Fitur Bantuan'),
          ),
          _menuItem(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            subtitle: 'Versi 1.0.0',
            onTap: () => _showSnack('Mercedes Showroom v1.0.0'),
          ),
          const SizedBox(height: 30),

          // ===== TOMBOL LOGOUT =====
          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                'LOGOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ===== WIDGET STATISTIK =====
  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF00ADEF),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }

  // ===== WIDGET MENU ITEM =====
  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF00ADEF).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF00ADEF), size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      ),
    );
  }

  // ===== SNACKBAR HELPER =====
  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF00ADEF),
      ),
    );
  }
}
