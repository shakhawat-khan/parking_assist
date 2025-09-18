import 'package:flutter/material.dart';

class ParkingRentalForm extends StatefulWidget {
  const ParkingRentalForm({super.key});

  @override
  State<ParkingRentalForm> createState() => _ParkingRentalFormState();
}

class _ParkingRentalFormState extends State<ParkingRentalForm> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  String _selectedParking = 'Sydney Opera House Car Park';
  String _selectedVehicleType = 'Car';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // List of available parking spots
  final List<String> _parkingSpots = [
    'Sydney Opera House Car Park',
    'Darling Harbour Secure Parking',
    'Bondi Beach Public Car Park',
    'Pitt Street Mall Parking',
    'The Rocks Parking Station',
    'Martin Place Secure Parking',
    'Circular Quay Station Parking'
  ];

  // List of vehicle types
  final List<String> _vehicleTypes = [
    'Car',
    'SUV',
    'Motorcycle',
    'Van',
    'Truck'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rent a Parking Spot'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Vehicle Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                value: _selectedVehicleType,
                items: _vehicleTypes,
                label: 'Vehicle Type',
                icon: Icons.directions_car,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedVehicleType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _vehicleController,
                label: 'Vehicle Make & Model',
                icon: Icons.time_to_leave,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your vehicle details';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _licenseController,
                label: 'License Plate Number',
                icon: Icons.confirmation_number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your license plate number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Parking Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                value: _selectedParking,
                items: _parkingSpots,
                label: 'Select Parking Location',
                icon: Icons.local_parking,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedParking = newValue!;
                  });
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDatePickerField(
                      controller: _dateController,
                      label: 'Parking Date',
                      icon: Icons.calendar_today,
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDatePickerField(
                      controller: _timeController,
                      label: 'Start Time',
                      icon: Icons.access_time,
                      onTap: () => _selectTime(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _durationController,
                label: 'Duration (hours)',
                icon: Icons.timer,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter parking duration';
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 1) {
                    return 'Please enter a valid duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showConfirmationDialog();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'RENT PARKING SPOT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required String label,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Function() onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      onTap: onTap,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Parking Rental'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Location: $_selectedParking'),
                Text('Date: ${_dateController.text}'),
                Text('Time: ${_timeController.text}'),
                Text('Duration: ${_durationController.text} hours'),
                Text(
                    'Vehicle: $_selectedVehicleType - ${_vehicleController.text}'),
                const SizedBox(height: 16),
                const Text('Please confirm your parking reservation details.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessDialog();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success!'),
          content:
              const Text('Your parking spot has been reserved successfully.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // Clear form
                _formKey.currentState!.reset();
                _nameController.clear();
                _emailController.clear();
                _phoneController.clear();
                _vehicleController.clear();
                _licenseController.clear();
                _dateController.clear();
                _timeController.clear();
                _durationController.clear();
                setState(() {
                  _selectedParking = 'Sydney Opera House Car Park';
                  _selectedVehicleType = 'Car';
                  _selectedDate = null;
                  _selectedTime = null;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _vehicleController.dispose();
    _licenseController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _durationController.dispose();
    super.dispose();
  }
}
