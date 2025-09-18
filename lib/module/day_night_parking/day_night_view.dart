import 'package:flutter/material.dart';

class DayNightParkingView extends StatefulWidget {
  @override
  _DayNightParkingViewState createState() => _DayNightParkingViewState();
}

class _DayNightParkingViewState extends State<DayNightParkingView> {
  int? _selectedOption; // 0: Day, 1: Night
  final Map<int, int> _charges = {0: 65, 1: 55}; // Day: $25, Night: $35

  void _submitForm() {
    if (_selectedOption != null) {
      String option = _selectedOption == 0 ? 'Whole Day Parking' : 'Whole Night Parking';
      int charge = _charges[_selectedOption!]!;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Booking Confirmed'),
          content: Text('You have selected $option.\nCharge: \$${charge}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day/Night Parking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Icon(Icons.nights_stay, size: 80, color: Colors.indigo),
            ),
            SizedBox(height: 20),
            Text(
              'Choose Parking Option',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Select either Day or Night parking. Charges are fixed and shown below.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 30),
            Column(
              children: [
                RadioListTile<int>(
                  value: 0,
                  groupValue: _selectedOption,
                  title: Text('Whole Day Parking', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('6:00 AM - 6:00 PM'),
                  secondary: Chip(
                    label: Text('\$${_charges[0]}', style: TextStyle(color: Colors.blue)),
                    backgroundColor: Colors.blue.shade50,
                  ),
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    setState(() => _selectedOption = val);
                  },
                ),
                RadioListTile<int>(
                  value: 1,
                  groupValue: _selectedOption,
                  title: Text('Whole Night Parking', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('6:00 PM - 6:00 AM'),
                  secondary: Chip(
                    label: Text('\$${_charges[1]}', style: TextStyle(color: Colors.indigo)),
                    backgroundColor: Colors.indigo.shade50,
                  ),
                  activeColor: Colors.indigo,
                  onChanged: (val) {
                    setState(() => _selectedOption = val);
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                     
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: Text('Confirm', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
