import 'package:flutter/material.dart';

// Model for Deals
class ParkingDeal {
  final String title;
  final String description;
  final double discount;
  final String validUntil;

  ParkingDeal({
    required this.title,
    required this.description,
    required this.discount,
    required this.validUntil,
  });
}

// Dummy Deals
final List<ParkingDeal> dummyDeals = [
  ParkingDeal(
    title: "50% Off at Sydney Opera House Car Park",
    description: "Book now and enjoy half price on your first 2 hours.",
    discount: 50,
    validUntil: "30 Sep 2025",
  ),
  ParkingDeal(
    title: "Buy 2 Get 1 Free at Darling Harbour",
    description:
        "Park 2 hours, get the 3rd hour free at Darling Harbour Secure Parking.",
    discount: 33,
    validUntil: "15 Oct 2025",
  ),
  ParkingDeal(
    title: "Flat \$20 Discount at Bondi Beach",
    description: "Enjoy flat \$20 off at Bondi Beach Public Car Park.",
    discount: 20,
    validUntil: "10 Oct 2025",
  ),
];

class DealsPage extends StatefulWidget {
  const DealsPage({super.key});

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  bool _wantsToRent = false;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _capacityCtrl = TextEditingController();

  void _submitRentForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request submitted successfully!")),
      );
      _nameCtrl.clear();
      _addressCtrl.clear();
      _priceCtrl.clear();
      _capacityCtrl.clear();
      setState(() => _wantsToRent = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parking Deals"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deals Section
            const Text(
              "Available Deals",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...dummyDeals.map((deal) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.local_offer, color: Colors.blue),
                  ),
                  title: Text(
                    deal.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "${deal.description}\nValid until: ${deal.validUntil}"),
                  isThreeLine: true,
                  trailing: Text(
                    "-${deal.discount}%",
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),

            const Divider(height: 40),

            // Rent Parking Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Do you want to rent your parking place?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: _wantsToRent,
                  onChanged: (val) {
                    setState(() {
                      _wantsToRent = val;
                    });
                  },
                ),
              ],
            ),

            if (_wantsToRent) ...[
              const SizedBox(height: 12),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(
                        labelText: "Owner Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? "Please enter your name" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _addressCtrl,
                      decoration: const InputDecoration(
                        labelText: "Parking Address",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? "Please enter address" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _priceCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Price per Hour (\$)",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val!.isEmpty ? "Enter price" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _capacityCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Capacity (Number of spots)",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? "Enter capacity" : null,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _submitRentForm,
                        child: const Text(
                          "Submit Request",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
