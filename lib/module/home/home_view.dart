import 'package:flutter/material.dart';
import 'package:parking_assist/module/booking_list/booking_list_view.dart';
import 'package:parking_assist/module/day_night_parking/day_night_view.dart';
import 'package:parking_assist/module/deals/deals_view.dart';
import 'package:parking_assist/module/give_rent/give_rent_view.dart';
import 'package:parking_assist/module/parking_search/parking_search_view.dart';
import 'package:parking_assist/module/profile_page/profile_page_view.dart';
import 'package:parking_assist/module/reserve_now/reserve_now.dart';

class ParkAssistHomePage extends StatefulWidget {
  const ParkAssistHomePage({super.key});

  @override
  State<ParkAssistHomePage> createState() => _ParkAssistHomePageState();
}

class _ParkAssistHomePageState extends State<ParkAssistHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu, color: Colors.black87),
        //   onPressed: () {},
        // ),
        title: const Text(
          'Park Assist',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          // IconButton(
          //   icon:
          //       const Icon(Icons.notifications_outlined, color: Colors.black87),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: const Icon(Icons.account_circle_outlined,
          //       color: Colors.black87),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Current Location: Sydney,Australia',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for parking location...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.local_parking,
                    title: 'Day Long / Whole Night Parking option',
                    subtitle: 'Near you',
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  DayNightParkingView(),
                          ));
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.book_online,
                    title: 'Give Rent parking space?',
                    subtitle: 'Registration Here',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  GiveRentView(),
                          ));
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Nearby Parking Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nearby Parking',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Parking Spots List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildParkingSpotCard(
                  name: _getParkingSpotName(index),
                  distance: _getParkingDistance(index),
                  availableSpots: _getAvailableSpots(index),
                  price: _getParkingPrice(index),
                  rating: _getParkingRating(index),
                );
              },
            ),

            const SizedBox(height: 24),

            // Recent Activity
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            _buildRecentActivityCard(
              title: 'Sydney Opera House Car Park',
              date: 'Yesterday, 2:30 PM',
              duration: '2 hours',
              amount: '\$50',
            ),

            const SizedBox(height: 12),

            _buildRecentActivityCard(
              title: 'Darling Harbour Secure Parking',
              date: '2 days ago, 10:15 AM',
              duration: '3 hours',
              amount: '\$75',
            ),

            const SizedBox(height: 80), // Bottom padding for navigation
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParkingSearchPage(),
                ));
          }
          if (index == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingListPage(),
                ));
          }
          if (index == 3) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DealsPage(),
                ));
          }
          if (index == 4) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ));
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Deals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: color,
                fontSize: 14,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParkingSpotCard({
    required String name,
    required String distance,
    required int availableSpots,
    required String price,
    required double rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.local_parking,
              color: Colors.blue.shade600,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 16, color: Colors.grey.shade600),
                    Text(
                      distance,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$availableSpots spots available',
                  style: TextStyle(
                    color: availableSpots > 5 ? Colors.green : Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'per hour',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard({
    required String title,
    required String date,
    required String duration,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.history, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '$date • $duration',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  String _getParkingSpotName(int index) {
    final names = [
      'Sydney Opera House Car Park',
      'Harbour Bridge North Parking',
      'Darling Harbour Secure Parking',
      'Circular Quay Station Parking',
      'Bondi Beach Public Car Park',
      'Newtown King Street Parking',
      'Surry Hills Secure Parking',
      'Barangaroo Reserve Parking',
      'Central Station Car Park',
      'Pitt Street Mall Parking',
      'The Rocks Parking Station',
      'Martin Place Secure Parking',
      'Ultimo Broadway Parking',
      'Glebe Point Road Car Park',
      'Manly Wharf Parking'
    ];
    return names[index];
  }

  String _getParkingDistance(int index) {
    final distances = ['0.5 km', '1.2 km', '2.1 km'];
    return distances[index];
  }

  int _getAvailableSpots(int index) {
    final spots = [12, 8, 3];
    return spots[index];
  }

  String _getParkingPrice(int index) {
    final prices = ['\$25', '\$30', '\$35'];
    return prices[index];
  }

  double _getParkingRating(int index) {
    final ratings = [4.5, 4.2, 3.8];
    return ratings[index];
  }
}
