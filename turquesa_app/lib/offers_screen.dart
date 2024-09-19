import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Best Offers"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildOfferCard(
            "https://via.placeholder.com/150",
            "50% OFF on Hair Services",
            "Get an amazing 50% discount on all hair styling and cutting services. Limited time offer!",
            "\$30.00",
            context,
          ),
          _buildOfferCard(
            "https://via.placeholder.com/150",
            "20% OFF on Body Spa",
            "Relax and rejuvenate with our body spa services, now at 20% off. Book your session today!",
            "\$50.00",
            context,
          ),
          _buildOfferCard(
            "https://via.placeholder.com/150",
            "30% OFF on Makeup Services",
            "Get a professional makeup session with a 30% discount. Perfect for weddings and events!",
            "\$80.00",
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(
    String imageUrl,
    String title,
    String description,
    String price,
    BuildContext context,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(imageUrl, fit: BoxFit.cover, height: 150),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação de agendar ou ver mais detalhes
                      Navigator.pushNamed(context, '/booking');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: Text("Book Now"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
