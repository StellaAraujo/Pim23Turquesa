import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(
          "Hello, Usuário",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navegar para a tela de notificações
              Navigator.pushNamed(context, '/notifications');
            },
          ),
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
            // Cards de categorias (Services)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho da seção com o botão See All
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navega para a tela de serviços detalhados
                          Navigator.pushNamed(context, '/services');
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                      height: 16.0), // Espaçamento entre o título e os cards

                  // Linha de cards de categorias
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCategoryCard(
                          "https://i.pinimg.com/236x/f3/5b/27/f35b274af562551fb129e2d033aa536d.jpg",
                          "Hair",
                          context),
                      _buildCategoryCard(
                          "https://img.freepik.com/free-photo/beauty-spa_144627-46202.jpg",
                          "Body Spa",
                          context),
                      _buildCategoryCard(
                          "https://media.istockphoto.com/id/1389918141/photo/studio-shot-of-an-attractive-young-woman-applying-makeup-against-a-brown-background.jpg?s=612x612&w=0&k=20&c=Y9G_TTMSfXbJMGYNDd0dycryGWVUXlWDe4LHO_9w85I=",
                          "Make Up",
                          context),
                      _buildCategoryCard(
                          "https://media.istockphoto.com/id/1249362060/pt/foto/close-up-portrait-of-young-woman-standing-with-naked-shoulders-and-neck-face-is-touched-by.jpg?s=612x612&w=0&k=20&c=BbNGBWQfIKmj7guuXHdBFa6KjFvOmbHG3xM35Pat8BY=",
                          "Estetica",
                          context),
                    ],
                  ),
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
                  GestureDetector(
                    onTap: () {
                      // Navega para a tela de especialistas detalhados
                      Navigator.pushNamed(context, '/specialists');
                    },
                    child:
                        Text("See All", style: TextStyle(color: Colors.teal)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildSpecialistCard("https://img.bebeautiful.in/www-bebeautiful-in/69f66d07ad95469820313b081edaefe1.jpeg?w=300",
                      "Alicia Silva", "4.0", context),
                  _buildSpecialistCard("https://static.wixstatic.com/media/801e12_3d6648c5f65149d09cb1ef8a0769cc47~mv2.jpg/v1/fill/w_469,h_505,al_c,q_80,enc_auto/801e12_3d6648c5f65149d09cb1ef8a0769cc47~mv2.jpg",
                      "Cara Sweet", "5.0", context),
                  _buildSpecialistCard("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTAukAh40bF3kRrYfug8HzH7MtOw5KB8nHe4oPeXX8F4EvwMYgRqFGY8iOcZlu4h9lMCs&usqp=CAU",
                      "Tonya Jey", "4.5", context),
                  _buildSpecialistCard("https://images.ctfassets.net/wlke2cbybljx/2HgQtNM4ViNmRVW6owS0ZU/1b25349ae9c87afc6a6aff0a65bff1e0/037_220024_HOLLYWOOD-PINK-REDS_HM_SOLO-JORDAN-CANDY-CHIC_RM_2308.jpg?fm=jpg",
                      "Tonya Jey", "4.5", context),
                ],
              ),
            ),

            // Ofertas
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best Offers",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/offers');
                      },
                      child: Text("See All")),
                      
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/offers');
                },
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        onTap: (int index) {
          // Verifica qual item foi clicado e navega para a respectiva tela
          switch (index) {
            case 0:
              // Navegar para a tela Home
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              // Navegar para a tela Offers
              Navigator.pushNamed(context, '/offers');
              break;
            case 2:
              // Navegar para a tela Booking
              Navigator.pushNamed(context, '/booking');
              break;
            case 3:
              // Navegar para a tela Profile
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: "Offers"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // Função para construir os cards de categorias
  Widget _buildCategoryCard(
      String imageUrl, String label, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navega para a tela de serviços detalhados
        Navigator.pushNamed(context, '/services');
      },
      child: Container(
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
      ),
    );
  }

  // Função para construir os cards de especialistas
  Widget _buildSpecialistCard(
      String imageUrl, String name, String rating, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navega para a tela de especialistas detalhados
        Navigator.pushNamed(context, '/specialists');
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(height: 8),
            Text(name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Rating: $rating", style: TextStyle(color: Colors.teal[700])),
          ],
        ),
      ),
    );
  }
}
