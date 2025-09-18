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
  final bool isFree;

  ParkingSpot(
      {required this.id,
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
      required this.isFree});
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
    ParkingSpot(
        id: '1',
        name: 'Broadway Shopping Centre',
        address: 'Broadway, Sydney NSW 2007, Australia',
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
        isFree: false),
    ParkingSpot(
        id: '2',
        name: 'Central Park Mall',
        address: '28 Broadway, Chippendale NSW 2008, Australia',
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
        isFree: true),
    ParkingSpot(
        id: '3',
        name: 'Westfield Pitt Street',
        address: 'Pitt St, Sydney NSW 2000, Australia',
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
        isFree: false),

    ParkingSpot(
        id: '4',
        name: 'Rockhampton Central Plaza',
        address: '100 East St, Rockhampton QLD 4700, Australia',
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
        isFree: false),
    ParkingSpot(
        id: '5',
        name: 'Rozelle Public Parking',
        address: '663 Darling St, Rozelle NSW 2039, Australia',
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
        isFree: true),

    ParkingSpot(
        id: '6',
        name: 'Martin Place Secure Parking',
        address: '1 Martin Pl, Sydney NSW 2000, Australia',
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
        isFree: false),
    ParkingSpot(
        id: '7',
        name: 'Paddy\'s Market Parking',
        address: '13 Hay St, Haymarket NSW 2000, Australia',
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
        isFree: false),

    ParkingSpot(
        id: '8',
        name: 'Darling Harbour Car Park',
        address: '100 Murray St, Pyrmont NSW 2009, Australia',
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
        isFree: false),
    ParkingSpot(
        id: '9',
        name: 'Circular Quay Parking Station',
        address: '16 Alfred St, Sydney NSW 2000, Australia',
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
        isFree: false),

    ParkingSpot(
        id: '10',
        name: 'North Sydney Council Car Park',
        address: '200 Miller St, North Sydney NSW 2060, Australia',
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
        isFree: false),
    ParkingSpot(
        id: '11',
        name: 'Bondi Beach Public Car Park',
        address:
            'Bondi Beach, Queen Elizabeth Dr, Bondi Beach NSW 2026, Australia',
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
        isFree: true),
    //   id: '15',
    //   name: 'Mohakhali Bus Terminal',
    //   address: 'Mohakhali, Dhaka',
    //   lat: 23.7806,
    //   lng: 90.4034,
    //   totalCapacity: 300,
    //   availableSpots: 78,
    //   pricePerHour: 20.0,
    //   rating: 3.7,
    //   openTime: '24 Hours',
    //   closeTime: '24 Hours',
    //   facilities: ['Security', 'Bus Terminal', 'Food Court'],
    //   distance: '1.9 km',
    // ),
  ];

  @override
  void initState() {
    super.initState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMarkers();
    });
  }

  // Book Now function for immediate booking
  void _bookNow(ParkingSpot spot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.flash_on, color: Colors.orange),
              SizedBox(width: 8),
              Text('Book Now'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location: ${spot.name}'),
              const SizedBox(height: 8),
              Text('Start Time: ${_formatCurrentTime()}'),
              const SizedBox(height: 8),
              Text(
                  'Rate: ${spot.isFree ? 'FREE' : '\$${spot.pricePerHour.toInt()}/hour'}'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Your parking will start immediately upon confirmation.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _confirmBooking(spot, DateTime.now(), null);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Confirm Booking',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showScheduleBookingDialog(ParkingSpot spot) {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    int duration = 1; // Default 1 hour

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Row(
                children: [
                  Icon(Icons.schedule, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Schedule Booking'),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Date Selection
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Date'),
                      subtitle: Text(_formatDate(selectedDate)),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),

                    // Time Selection
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('Start Time'),
                      subtitle: Text(selectedTime.format(context)),
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null) {
                          setState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                    ),

                    // Duration Selection
                    ListTile(
                      leading: const Icon(Icons.timer),
                      title: const Text('Duration'),
                      subtitle:
                          Text('$duration hour${duration > 1 ? 's' : ''}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: duration > 1
                                ? () => setState(() => duration--)
                                : null,
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          IconButton(
                            onPressed: () => setState(() => duration++),
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ),

                    const Divider(),

                    // Booking Summary
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booking Summary',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Location: ${spot.name}'),
                          Text('Date: ${_formatDate(selectedDate)}'),
                          Text('Time: ${selectedTime.format(context)}'),
                          Text(
                              'Duration: $duration hour${duration > 1 ? 's' : ''}'),
                          const SizedBox(height: 4),
                          Text(
                            'Total Cost: ${spot.isFree ? 'FREE' : '\$${(spot.pricePerHour * duration).toInt()}'}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: spot.isFree ? Colors.green : Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    final scheduledDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                    _confirmBooking(spot, scheduledDateTime, duration);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Schedule Booking',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

// Confirm booking with payment handling
  void _confirmBooking(ParkingSpot spot, DateTime startTime, int? duration) {
    if (spot.isFree) {
      // For free parking, directly confirm the booking
      _processFreeBooking(spot, startTime, duration);
    } else {
      // For paid parking, show payment options
      _showPaymentDialog(spot, startTime, duration);
    }
  }

// Process free parking booking
  void _processFreeBooking(
      ParkingSpot spot, DateTime startTime, int? duration) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Booking Confirmed!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'Booking ID: #${_generateBookingId()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Location: ${spot.name}'),
                    Text('Date & Time: ${_formatDateTime(startTime)}'),
                    if (duration != null)
                      Text(
                          'Duration: $duration hour${duration > 1 ? 's' : ''}'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'FREE PARKING',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _hideDetails(); // Close the parking details sheet
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Done', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentDialog(ParkingSpot spot, DateTime startTime, int? duration) {
    final totalCost = duration != null ? spot.pricePerHour * duration : 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.payment, color: Colors.blue),
              SizedBox(width: 8),
              Text('Payment Options'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount:'),
                    Text(
                      '\$${totalCost.toInt()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Payment Method Options
              _buildPaymentOption(
                icon: Icons.account_balance_wallet,
                title: 'Mobile Banking',
                subtitle: 'bKash, Nagad, Rocket',
                onTap: () => _processPayment(
                    spot, startTime, duration, 'Mobile Banking'),
              ),
              _buildPaymentOption(
                icon: Icons.credit_card,
                title: 'Credit/Debit Card',
                subtitle: 'Visa, MasterCard',
                onTap: () => _processPayment(spot, startTime, duration, 'Card'),
              ),
              _buildPaymentOption(
                icon: Icons.account_balance,
                title: 'Internet Banking',
                subtitle: 'All major banks',
                onTap: () => _processPayment(
                    spot, startTime, duration, 'Internet Banking'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

// Build payment option widget
  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  void _processPayment(ParkingSpot spot, DateTime startTime, int? duration,
      String paymentMethod) {
    Navigator.of(context).pop(); // Close payment dialog

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Processing payment...'),
            ],
          ),
        );
      },
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close loading dialog
      _showPaymentSuccess(spot, startTime, duration, paymentMethod);
    });
  }

  void _showPaymentSuccess(ParkingSpot spot, DateTime startTime, int? duration,
      String paymentMethod) {
    final totalCost = duration != null ? spot.pricePerHour * duration : 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Payment Successful!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'Booking ID: #${_generateBookingId()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Location: ${spot.name}'),
                    Text('Date & Time: ${_formatDateTime(startTime)}'),
                    if (duration != null)
                      Text(
                          'Duration: $duration hour${duration > 1 ? 's' : ''}'),
                    Text('Payment Method: $paymentMethod'),
                    const SizedBox(height: 8),
                    Text(
                      'Amount Paid: \$${totalCost.toInt()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _hideDetails(); // Close the parking details sheet
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Done', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _generateBookingId() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(7);
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
      height: MediaQuery.sizeOf(context).height - 120,
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

                  // Payment Type Banner
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: spot.isFree
                          ? Colors.green.shade50
                          : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: spot.isFree
                            ? Colors.green.shade200
                            : Colors.blue.shade200,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          spot.isFree ? Icons.free_breakfast : Icons.payment,
                          size: 16,
                          color: spot.isFree
                              ? Colors.green.shade700
                              : Colors.blue.shade700,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          spot.isFree ? 'FREE PARKING' : 'PAID PARKING',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: spot.isFree
                                ? Colors.green.shade700
                                : Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
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
                        icon: spot.isFree ? Icons.money_off : Icons.schedule,
                        title: spot.isFree
                            ? 'FREE'
                            : '\$${spot.pricePerHour.toInt()}',
                        subtitle: spot.isFree ? 'No charge' : 'per hour',
                        color: spot.isFree ? Colors.green : Colors.blue,
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

                  // Booking Options
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _bookNow(spot);
                          },
                          icon: const Icon(Icons.flash_on, size: 18),
                          label: const Text('Book Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showScheduleBookingDialog(spot);
                          },
                          icon: const Icon(Icons.schedule, size: 18),
                          label: const Text('Schedule'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
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
                                '${spot.distance} • \$${spot.pricePerHour.toInt()}/hr'),
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
