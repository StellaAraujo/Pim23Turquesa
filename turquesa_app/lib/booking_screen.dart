import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedService;
  String? selectedSpecialist;
  DateTime selectedDate = DateTime.now(); // Garantindo que não seja nulo
  TimeOfDay? selectedTime;

  final List<String> services = [
    "Haircut",
    "Body Spa",
    "Makeup",
    "Cílios",
  ];

  final List<String> specialists = [
    "Alicia",
    "Cara Sweet",
    "Tonya Jey",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Service"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Select a Service"),
            _buildDropdown(
              selectedValue: selectedService,
              hintText: "Choose a service",
              items: services,
              onChanged: (value) {
                setState(() {
                  selectedService = value;
                });
              },
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Select a Specialist"),
            _buildDropdown(
              selectedValue: selectedSpecialist,
              hintText: "Choose a specialist",
              items: specialists,
              onChanged: (value) {
                setState(() {
                  selectedSpecialist = value;
                });
              },
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Select a Date"),
            CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1),
              onDateChanged: (newDate) {
                setState(() {
                  selectedDate = newDate; // Garantindo que newDate nunca seja nulo
                });
              },
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Select a Time"),
            _buildTimeButton(),
            SizedBox(height: 30),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
    );
  }

  Widget _buildDropdown({
    required String? selectedValue,
    required String hintText,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.teal[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      hint: Text(hintText),
      isExpanded: true,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTimeButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            selectedTime = pickedTime;
          });
        }
      },
      icon: Icon(Icons.access_time),
      label: Text(
        selectedTime == null
            ? "Choose a time"
            : "${selectedTime!.hour}:${selectedTime!.minute}",
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.teal[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (selectedService != null &&
              selectedSpecialist != null &&
              // ignore: unnecessary_null_comparison
              selectedDate != null &&
              selectedTime != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Service booked with $selectedSpecialist for $selectedService on ${selectedDate.day}/${selectedDate.month}/${selectedDate.year} at ${selectedTime!.hour}:${selectedTime!.minute}.",
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please fill all the details."),
              ),
            );
          }
        },
        child: Text("Confirm Booking"),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.teal[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        ),
      ),
    );
  }
}