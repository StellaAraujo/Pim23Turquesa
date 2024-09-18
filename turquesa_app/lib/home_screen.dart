import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(
          "Hello, Usuário",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://via.placeholder.com/150", // Substitua pela URL da imagem do usuário
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de pesquisa
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for services",
                  prefixIcon: Icon(Icons.search, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Cards de categorias
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryCard("https://via.placeholder.com/100", "Hair"),
                  _buildCategoryCard("https://via.placeholder.com/100", "Body Spa"),
                  _buildCategoryCard("https://via.placeholder.com/100", "Make Up"),
                  _buildCategoryCard("https://via.placeholder.com/100", "Cílios"),
                ],
              ),
            ),
            // Beauty Specialists
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Beauty Specialist",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: Text("See All"))
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildSpecialistCard("https://via.placeholder.com/150", "Alicia", "4.0"),
                  _buildSpecialistCard("https://via.placeholder.com/150", "Cara Sweet", "5.0"),
                  _buildSpecialistCard("https://via.placeholder.com/150", "Tonya Jey", "4.5"),
                  _buildSpecialistCard("https://via.placeholder.com/150", "Tonya Jey", "4.5"),
                ],
              ),
            ),
            // Ofertas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best Offers",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: Text("See All"))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "50% OFF on all makeup services!",
                    style: TextStyle(color: Colors.teal[900], fontSize: 18),
                  ),
                  
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: "Offers"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String imageUrl, String label) {
    return Container(
      width: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              width: 50,
              height: 50,
            ),
            SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.teal)),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialistCard(String imageUrl, String name, String rating) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text("Rating: $rating", style: TextStyle(color: Colors.teal[700])),
        ],
      ),
    );
  }
}
