import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedService;
  String? selectedSpecialist;
  DateTime? selectedDate;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select a Service",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedService,
              hint: Text("Choose a service"),
              isExpanded: true,
              items: services.map((String service) {
                return DropdownMenuItem<String>(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedService = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              "Select a Specialist",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedSpecialist,
              hint: Text("Choose a specialist"),
              isExpanded: true,
              items: specialists.map((String specialist) {
                return DropdownMenuItem<String>(
                  value: specialist,
                  child: Text(specialist),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSpecialist = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              "Select a Date",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Text(
                selectedDate == null
                    ? "Choose a date"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Select a Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
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
              child: Text(
                selectedTime == null
                    ? "Choose a time"
                    : "${selectedTime!.hour}:${selectedTime!.minute}",
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Confirmação do agendamento
                  if (selectedService != null &&
                      selectedSpecialist != null &&
                      selectedDate != null &&
                      selectedTime != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Service booked with $selectedSpecialist for $selectedService on ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} at ${selectedTime!.hour}:${selectedTime!.minute}."),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
