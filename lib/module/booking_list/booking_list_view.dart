import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // <-- Add this

// Booking Model
class ParkingBooking {
  final String bookingId;
  final String spotName;
  final String address;
  final DateTime startTime;
  final DateTime endTime;
  final double totalPrice;
  final String status; // reserved, completed, upcoming

  ParkingBooking({
    required this.bookingId,
    required this.spotName,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.totalPrice,
    required this.status,
  });
}

// Dummy Data
final List<ParkingBooking> dummyBookings = [
  ParkingBooking(
    bookingId: "B001",
    spotName: "Gulshan Shopping Center",
    address: "Gulshan Avenue, Gulshan-1, Dhaka",
    startTime: DateTime.now().subtract(const Duration(hours: 1)),
    endTime: DateTime.now().add(const Duration(hours: 2)),
    totalPrice: 75.0,
    status: "reserved",
  ),
  ParkingBooking(
    bookingId: "B002",
    spotName: "Bashundhara City Mall",
    address: "Panthapath, Dhaka",
    startTime: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    endTime: DateTime.now().subtract(const Duration(days: 1)),
    totalPrice: 60.0,
    status: "completed",
  ),
  ParkingBooking(
    bookingId: "B003",
    spotName: "Motijheel Commercial Area",
    address: "Motijheel, Dhaka",
    startTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
    endTime: DateTime.now().add(const Duration(days: 1, hours: 3)),
    totalPrice: 70.0,
    status: "upcoming",
  ),
];

class BookingListPage extends StatelessWidget {
  const BookingListPage({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case "reserved":
        return Colors.blue;
      case "completed":
        return Colors.green;
      case "upcoming":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat("d MMMM hh:mm a").format(dateTime);
    // Example: 12 December 12:30 AM
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: dummyBookings.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final booking = dummyBookings[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(booking.status),
                child: const Icon(Icons.local_parking, color: Colors.white),
              ),
              title: Text(
                booking.spotName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.address,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(
                    "From: ${_formatDateTime(booking.startTime)}\nTo:     ${_formatDateTime(booking.endTime)}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${booking.totalPrice.toStringAsFixed(0)} • ${booking.status.toUpperCase()}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: _getStatusColor(booking.status),
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Clicked ${booking.bookingId}")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
