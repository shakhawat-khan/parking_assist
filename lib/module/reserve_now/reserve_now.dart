import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReserveNowPage extends StatefulWidget {
  final String parkingName;
  const ReserveNowPage({super.key, required this.parkingName});

  @override
  State<ReserveNowPage> createState() => _ReserveNowPageState();
}

class _ReserveNowPageState extends State<ReserveNowPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String get formattedDate {
    if (selectedDate == null) return 'Select Date';
    return DateFormat('dd MMMM').format(selectedDate!); // e.g., 12 December
  }

  String get formattedTime {
    if (selectedTime == null) return 'Select Time';
    final dt = DateTime(0, 0, 0, selectedTime!.hour, selectedTime!.minute);
    return DateFormat('hh:mm a').format(dt); // e.g., 12:30 AM
  }

  void _pickDate() async {
    DateTime now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void _reserve() {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date and time')),
      );
      return;
    }

    final reservationDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Reserved ${widget.parkingName} on ${DateFormat('dd MMMM, hh:mm a').format(reservationDateTime)}',
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve at ${widget.parkingName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Date picker
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.blue),
              title: Text(formattedDate),
              trailing: const Icon(Icons.chevron_right),
              onTap: _pickDate,
            ),

            const SizedBox(height: 16),

            // Time picker
            ListTile(
              leading: const Icon(Icons.access_time, color: Colors.blue),
              title: Text(formattedTime),
              trailing: const Icon(Icons.chevron_right),
              onTap: _pickTime,
            ),

            const Spacer(),

            // Reserve Now button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _reserve,
                child: const Text(
                  'Reserve Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
