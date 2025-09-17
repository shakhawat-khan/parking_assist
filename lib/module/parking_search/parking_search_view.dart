import 'package:flutter/material.dart';
import 'dart:math' as math;

class ParkingSpot {
  final String id;
  final String name;
  final String address;
  final double lat;
  final double lng;
  final int totalCapacity;
  final int availableSpots;
  final double pricePerHour;
  final double rating;
  final String openTime;
  final String closeTime;
  final List<String> facilities;
  final String distance;

  ParkingSpot({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.totalCapacity,
    required this.availableSpots,
    required this.pricePerHour,
    required this.rating,
    required this.openTime,
    required this.closeTime,
    required this.facilities,
    required this.distance,
  });
}

class ParkingMarker {
  final ParkingSpot spot;
  final Offset position;
  final Color color;

  ParkingMarker({
    required this.spot,
    required this.position,
    required this.color,
  });
}

class ParkingSearchPage extends StatefulWidget {
  const ParkingSearchPage({super.key});

  @override
  State<ParkingSearchPage> createState() => _ParkingSearchPageState();
}

class _ParkingSearchPageState extends State<ParkingSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  ParkingSpot? _selectedSpot;
  bool _showDetails = false;
  List<ParkingMarker> _markers = [];

  // Current map center and zoom
  double _centerLat = 23.8103;
  double _centerLng = 90.4125;
  double _zoomLevel = 12.0;

  // Dummy parking spots data - More distributed around Dhaka
  List<ParkingSpot> parkingSpots = [
    // Central Dhaka
    ParkingSpot(
      id: '1',
      name: 'Gulshan Shopping Center',
      address: 'Gulshan Avenue, Gulshan-1, Dhaka',
      lat: 23.7808,
      lng: 90.4176,
      totalCapacity: 150,
      availableSpots: 25,
      pricePerHour: 25.0,
      rating: 4.5,
      openTime: '6:00 AM',
      closeTime: '11:00 PM',
      facilities: ['Security', 'CCTV', 'Covered', 'EV Charging'],
      distance: '0.8 km',
    ),
    ParkingSpot(
      id: '2',
      name: 'Dhanmondi Plaza Parking',
      address: 'Satmasjid Road, Dhanmondi, Dhaka',
      lat: 23.7461,
      lng: 90.3742,
      totalCapacity: 80,
      availableSpots: 12,
      pricePerHour: 30.0,
      rating: 4.2,
      openTime: '7:00 AM',
      closeTime: '10:00 PM',
      facilities: ['Security', 'Covered', 'Wheelchair Access'],
      distance: '1.2 km',
    ),
    ParkingSpot(
      id: '3',
      name: 'Bashundhara City Mall',
      address: 'Panthapath, Dhaka',
      lat: 23.7507,
      lng: 90.3938,
      totalCapacity: 300,
      availableSpots: 45,
      pricePerHour: 20.0,
      rating: 4.7,
      openTime: '8:00 AM',
      closeTime: '11:30 PM',
      facilities: ['Security', 'CCTV', 'Covered', 'Food Court', 'Restrooms'],
      distance: '2.1 km',
    ),

    // North Dhaka
    ParkingSpot(
      id: '4',
      name: 'Uttara Sector 7 Parking',
      address: 'Sector 7, Uttara, Dhaka',
      lat: 23.8759,
      lng: 90.3795,
      totalCapacity: 200,
      availableSpots: 67,
      pricePerHour: 20.0,
      rating: 4.1,
      openTime: '6:00 AM',
      closeTime: '12:00 AM',
      facilities: ['Security', 'Open Air', 'ATM'],
      distance: '5.2 km',
    ),
    ParkingSpot(
      id: '5',
      name: 'Banani Square Parking',
      address: 'Banani, Dhaka',
      lat: 23.7936,
      lng: 90.4067,
      totalCapacity: 90,
      availableSpots: 18,
      pricePerHour: 28.0,
      rating: 4.3,
      openTime: '7:00 AM',
      closeTime: '11:00 PM',
      facilities: ['Security', 'CCTV', 'Covered'],
      distance: '1.5 km',
    ),

    // South Dhaka
    ParkingSpot(
      id: '6',
      name: 'Motijheel Commercial Area',
      address: 'Motijheel, Dhaka',
      lat: 23.7330,
      lng: 90.4172,
      totalCapacity: 120,
      availableSpots: 35,
      pricePerHour: 35.0,
      rating: 4.1,
      openTime: '6:00 AM',
      closeTime: '9:00 PM',
      facilities: ['Security', 'CCTV', 'Covered', 'Valet Service'],
      distance: '1.8 km',
    ),
    ParkingSpot(
      id: '7',
      name: 'New Market Parking Hub',
      address: 'New Market, Dhaka',
      lat: 23.7290,
      lng: 90.3854,
      totalCapacity: 75,
      availableSpots: 22,
      pricePerHour: 22.0,
      rating: 3.8,
      openTime: '8:00 AM',
      closeTime: '10:00 PM',
      facilities: ['Security', 'Covered'],
      distance: '2.8 km',
    ),

    // Old Dhaka
    ParkingSpot(
      id: '8',
      name: 'Wari Parking Hub',
      address: 'Wari, Old Dhaka',
      lat: 23.7181,
      lng: 90.4203,
      totalCapacity: 60,
      availableSpots: 8,
      pricePerHour: 15.0,
      rating: 3.9,
      openTime: '5:00 AM',
      closeTime: '12:00 AM',
      facilities: ['Security', 'Open Air'],
      distance: '3.5 km',
    ),
    ParkingSpot(
      id: '9',
      name: 'Lalbagh Fort Parking',
      address: 'Lalbagh, Old Dhaka',
      lat: 23.7186,
      lng: 90.3854,
      totalCapacity: 50,
      availableSpots: 5,
      pricePerHour: 12.0,
      rating: 3.6,
      openTime: '6:00 AM',
      closeTime: '8:00 PM',
      facilities: ['Security', 'Historical Site'],
      distance: '4.2 km',
    ),

    // West Dhaka
    ParkingSpot(
      id: '10',
      name: 'Mirpur DOHS Parking',
      address: 'DOHS, Mirpur, Dhaka',
      lat: 23.8223,
      lng: 90.3654,
      totalCapacity: 180,
      availableSpots: 89,
      pricePerHour: 18.0,
      rating: 4.4,
      openTime: '5:30 AM',
      closeTime: '11:30 PM',
      facilities: ['Security', 'CCTV', 'Covered', 'Playground'],
      distance: '4.8 km',
    ),
    ParkingSpot(
      id: '11',
      name: 'Shyamoli Parking Station',
      address: 'Shyamoli, Dhaka',
      lat: 23.7653,
      lng: 90.3601,
      totalCapacity: 95,
      availableSpots: 31,
      pricePerHour: 25.0,
      rating: 4.0,
      openTime: '6:00 AM',
      closeTime: '11:00 PM',
      facilities: ['Security', 'Covered', 'Restaurant'],
      distance: '3.1 km',
    ),

    // East Dhaka
    ParkingSpot(
      id: '12',
      name: 'Ramna Park Parking',
      address: 'Ramna, Dhaka',
      lat: 23.7378,
      lng: 90.4039,
      totalCapacity: 40,
      availableSpots: 15,
      pricePerHour: 30.0,
      rating: 4.2,
      openTime: '5:00 AM',
      closeTime: '10:00 PM',
      facilities: ['Security', 'Park View', 'Open Air'],
      distance: '1.1 km',
    ),
    ParkingSpot(
      id: '13',
      name: 'Tejgaon Industrial Area',
      address: 'Tejgaon, Dhaka',
      lat: 23.7644,
      lng: 90.3962,
      totalCapacity: 250,
      availableSpots: 156,
      pricePerHour: 15.0,
      rating: 3.9,
      openTime: '24 Hours',
      closeTime: '24 Hours',
      facilities: ['Security', 'Industrial', 'Truck Parking'],
      distance: '2.7 km',
    ),

    // Additional scattered spots
    ParkingSpot(
      id: '14',
      name: 'Farmgate Metro Parking',
      address: 'Farmgate, Dhaka',
      lat: 23.7565,
      lng: 90.3892,
      totalCapacity: 110,
      availableSpots: 44,
      pricePerHour: 26.0,
      rating: 4.1,
      openTime: '5:00 AM',
      closeTime: '12:00 AM',
      facilities: ['Security', 'Metro Access', 'CCTV'],
      distance: '2.4 km',
    ),
    ParkingSpot(
      id: '15',
      name: 'Mohakhali Bus Terminal',
      address: 'Mohakhali, Dhaka',
      lat: 23.7806,
      lng: 90.4034,
      totalCapacity: 300,
      availableSpots: 78,
      pricePerHour: 20.0,
      rating: 3.7,
      openTime: '24 Hours',
      closeTime: '24 Hours',
      facilities: ['Security', 'Bus Terminal', 'Food Court'],
      distance: '1.9 km',
    ),
  ];

  @override
  void initState() {
    super.initState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMarkers();
    });
  }

  void _updateMarkers() {
    if (!mounted) return;

    setState(() {
      _markers = parkingSpots.map((spot) {
        // Convert lat/lng to Offset (screen coords)
        final position = _latLngToOffset(spot.lat, spot.lng);

        final color = spot.availableSpots > 10
            ? Colors.green
            : spot.availableSpots > 5
                ? Colors.orange
                : Colors.red;

        return ParkingMarker(
          spot: spot,
          position: position,
          color: color,
        );
      }).toList();
    });
  }

  Offset _latLngToOffset(double lat, double lng) {
    // Get screen size for responsive positioning
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - 200; // Account for UI elements

    // Dhaka bounds (approximate) - adjusted based on zoom level
    final latRange = 0.3 / _zoomLevel * 12; // Zoom affects visible area
    final lngRange = 0.3 / _zoomLevel * 12;

    final minLat = _centerLat - latRange / 2;
    final maxLat = _centerLat + latRange / 2;
    final minLng = _centerLng - lngRange / 2;
    final maxLng = _centerLng + lngRange / 2;

    final x = ((lng - minLng) / (maxLng - minLng)) * screenWidth * 0.8;
    final y = ((maxLat - lat) / (maxLat - minLat)) * screenHeight * 0.8;

    return Offset(x.clamp(-100, screenWidth), y.clamp(-100, screenHeight));
  }

  void _showParkingDetails(ParkingSpot spot) {
    setState(() {
      _selectedSpot = spot;
      _showDetails = true;
    });
  }

  void _hideDetails() {
    setState(() {
      _showDetails = false;
      _selectedSpot = null;
    });
  }

  void _searchLocation(String query) {
    if (query.isNotEmpty) {
      List<ParkingSpot> filteredSpots = parkingSpots
          .where(
              (spot) => spot.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (filteredSpots.isNotEmpty) {
        setState(() {
          _centerLat = filteredSpots.first.lat;
          _centerLng = filteredSpots.first.lng;
          _zoomLevel = 15.0;
        });
        _updateMarkers();
      }
    }
  }

  void _zoomIn() {
    setState(() {
      _zoomLevel = math.min(_zoomLevel + 1, 20); // Max zoom level 20
    });
    _updateMarkers();
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = math.max(_zoomLevel - 1, 8); // Min zoom level 8
    });
    _updateMarkers();
  }

  void _centerMap() {
    setState(() {
      _centerLat = 23.8103;
      _centerLng = 90.4125;
      _zoomLevel = 12.0;
    });
    _updateMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Parking'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Stack(
        children: [
          // Map Container
          Container(
            color: Colors.blue.shade50,
            child: Stack(
              children: [
                // Map Background
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade100,
                        Colors.green.shade50,
                        Colors.blue.shade50,
                      ],
                    ),
                  ),
                  child: CustomPaint(
                    painter: MapPainter(),
                  ),
                ),

                // Parking Markers with zoom-responsive sizing
                ..._markers.map((marker) {
                  // Calculate marker size based on zoom level
                  final markerSize = math.max(30.0, _zoomLevel * 2.5);
                  final iconSize = math.max(16.0, _zoomLevel * 1.2);

                  return Positioned(
                    left: marker.position.dx + 50, // Adjusted offset
                    top: marker.position.dy + 80,
                    child: GestureDetector(
                      onTap: () => _showParkingDetails(marker.spot),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: markerSize,
                        height: markerSize,
                        decoration: BoxDecoration(
                          color: marker.color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.local_parking,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                    ),
                  );
                }),

                // Current Location Marker (zoom responsive)
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.5 - 10,
                  top: (MediaQuery.of(context).size.height - 200) * 0.5 - 10,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: math.max(16.0, _zoomLevel * 1.5),
                    height: math.max(16.0, _zoomLevel * 1.5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onSubmitted: _searchLocation,
                decoration: InputDecoration(
                  hintText: 'Search for parking locations...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.my_location, color: Colors.blue),
                    onPressed: _centerMap,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),

          // Map Controls with zoom level indicator
          Positioned(
            right: 16,
            top: 100,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    'Zoom: ${_zoomLevel.toInt()}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  heroTag: "zoom_in",
                  onPressed: _zoomIn,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.add, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  heroTag: "zoom_out",
                  onPressed: _zoomOut,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.remove, color: Colors.black87),
                ),
              ],
            ),
          ),

          // Parking List Button
          Positioned(
            bottom: _showDetails ? 320 : 100,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => _showParkingList(context),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.list, color: Colors.white),
            ),
          ),

          // Parking Details Bottom Sheet
          if (_showDetails && _selectedSpot != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildParkingDetailsSheet(_selectedSpot!),
            ),
        ],
      ),
    );
  }

  Widget _buildParkingDetailsSheet(ParkingSpot spot) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              spot.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 16, color: Colors.grey.shade600),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    spot.address,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: _hideDetails,
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard(
                        icon: Icons.local_parking,
                        title: '${spot.availableSpots}',
                        subtitle: 'Available',
                        color: spot.availableSpots > 10
                            ? Colors.green
                            : Colors.orange,
                      ),
                      _buildStatCard(
                        icon: Icons.schedule,
                        title: '৳${spot.pricePerHour.toInt()}',
                        subtitle: 'per hour',
                        color: Colors.blue,
                      ),
                      _buildStatCard(
                        icon: Icons.star,
                        title: spot.rating.toString(),
                        subtitle: 'Rating',
                        color: Colors.amber,
                      ),
                      _buildStatCard(
                        icon: Icons.straighten,
                        title: spot.distance,
                        subtitle: 'Away',
                        color: Colors.purple,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Details
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Operating Hours',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text('${spot.openTime} - ${spot.closeTime}'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Capacity',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text('${spot.totalCapacity} spots'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Facilities
                  Text(
                    'Facilities',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: spot.facilities.map((facility) {
                      return Chip(
                        label: Text(
                          facility,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: Colors.blue.shade50,
                        side: BorderSide(color: Colors.blue.shade200),
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  // Reserve Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        _showReservationDialog(spot);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Reserve Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  void _showParkingList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8, // 👈 starts at 80% of screen
          minChildSize: 0.5, // user can shrink to 50%
          maxChildSize: 0.95, // user can expand to 95%
          expand: false,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                // handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const Text(
                  'Available Parking Spots',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // parking spots list
                ...parkingSpots.map((spot) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.local_parking,
                            color: Colors.blue.shade600,
                          ),
                        ),
                        title: Text(
                          spot.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${spot.distance} • ৳${spot.pricePerHour.toInt()}/hr'),
                            Text(
                              '${spot.availableSpots} spots available',
                              style: TextStyle(
                                color: spot.availableSpots > 10
                                    ? Colors.green
                                    : Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                            Text(spot.rating.toString()),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _showParkingDetails(spot);
                        },
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        );
      },
    );
  }

  void _showReservationDialog(ParkingSpot spot) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reserve Parking'),
        content: Text('Would you like to reserve a spot at ${spot.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _hideDetails();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Reservation confirmed at ${spot.name}!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Reserve'),
          ),
        ],
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.0;

    // Draw grid lines to simulate map
    for (int i = 0; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }

    for (int i = 0; i < size.height; i += 20) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }

    // Draw some "roads"
    final roadPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 3.0;

    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      roadPaint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      roadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      roadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.7, size.height),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
