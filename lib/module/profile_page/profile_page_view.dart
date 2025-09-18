import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // User Info
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=3", // dummy profile image
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Asif al saif",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Asif_al_saif@example.com",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quick Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildStatCard("Bookings", "12", Icons.calendar_month),
                  _buildStatCard("Saved Spots", "5", Icons.bookmark),
                  _buildStatCard("Deals Used", "3", Icons.local_offer),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Profile Options
            const Divider(),
            _buildProfileOption(
              icon: Icons.person,
              title: "Edit Profile",
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.payment,
              title: "Payment Methods",
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.settings,
              title: "Settings",
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.help,
              title: "Help & Support",
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {},
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(height: 8),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color, fontSize: 16),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
