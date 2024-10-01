import 'package:flutter/material.dart';
import 'service_details_page.dart';
import 'package:turquesa_app/services_api.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 125, 177, 171),
        elevation: 0,
        title: Text(
          "Hello, Usuário.",
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navegar para a tela de notificações
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://via.placeholder.com/150", // Substitua pela URL da imagem do usuário
              ),
            ),
          )*/
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Espaço para logo
            SizedBox(height: 20),
            Center(
              child: Image.network(
                "https://turquesaesmalteria.com.br/wp-content/uploads/2020/07/Logo-Turquesa-Horizontal.png", // Substitua pela URL da logo
                height: 100,
              ),
            ),
            SizedBox(height: 16), // Espaçamento após a logo

            // Cards de serviços (grid)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho da seção
                  Text(
                    'Serviços:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      height: 16.0), // Espaçamento entre o título e os cards

                  // Grid de cards de serviços
                  GridView.count(
                    crossAxisCount: 3, // 3 cards por linha
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Impede rolagem
                    childAspectRatio:
                        0.85, // Proporção da altura para a largura
                    children: [
                      _buildCategoryCard(
                        "https://kproserragaucha.com.br/wp-content/uploads/2022/10/Untitled-1-1.jpg",
                        "Cabelo",
                        context,
                      ),
                      _buildCategoryCard(
                        "https://img.freepik.com/free-photo/beauty-spa_144627-46202.jpg",
                        "Body Spa",
                        context,
                      ),
                      _buildCategoryCard(
                        "https://i0.wp.com/priflor.com/wp-content/uploads/2023/12/maquiagem_pele_negra_02.webp?fit=828%2C828&ssl=1",
                        "Maquiagem",
                        context,
                      ),
                      _buildCategoryCard(
                        "https://media.istockphoto.com/id/1389918141/photo/studio-shot-of-an-attractive-young-woman-applying-makeup-against-a-brown-background.jpg?s=612x612&w=0&k=20&c=Y9G_TTMSfXbJMGYNDd0dycryGWVUXlWDe4LHO_9w85I=",
                        "Estética",
                        context,
                      ),
                      _buildCategoryCard(
                        "https://boaforma.abril.com.br/wp-content/uploads/sites/2/2023/12/cuidados-na-hora-de-fazer-as-unhas.jpg?crop=1&resize=1212,909",
                        "Unhas",
                        context,
                      ),
                      _buildCategoryCard(
                        "https://media.istockphoto.com/id/845708412/pt/foto/eyelash-extension-procedure-woman-eye-with-long-eyelashes-lashes-close-up-macro-selective-focus.jpg?s=612x612&w=0&k=20&c=AtbS1bVvcfgKooF-Dd0wkDSpAc5zPzvgiHUHc94gwWU=",
                        "Cílios",
                        context,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /* Beauty Specialists
            SizedBox(height: 20), // Espaço entre ofertas e especialistas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Beauty Specialists",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navega para a tela de especialistas detalhados
                      Navigator.pushNamed(context, '/specialists');
                    },
                    child: Text("See All", style: TextStyle(color: Colors.teal)),
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
                  _buildSpecialistCard(
                      "https://img.bebeautiful.in/www-bebeautiful-in/69f66d07ad95469820313b081edaefe1.jpeg?w=300",
                      "Alicia Silva",
                      "4.0",
                      context),
                  _buildSpecialistCard(
                      "https://static.wixstatic.com/media/801e12_3d6648c5f65149d09cb1ef8a0769cc47~mv2.jpg/v1/fill/w_469,h_505,al_c,q_80,enc_auto/801e12_3d6648c5f65149d09cb1ef8a0769cc47~mv2.jpg",
                      "Cara Sweet",
                      "5.0",
                      context),
                  _buildSpecialistCard(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTAukAh40bF3kRrYfug8HzH7MtOw5KB8nHe4oPeXX8F4EvwMYgRqFGY8iOcZlu4h9lMCs&usqp=CAU",
                      "Tonya Jey",
                      "4.5",
                      context),
                  _buildSpecialistCard(
                      "https://images.ctfassets.net/wlke2cbybljx/2HgQtNM4ViNmRVW6owS0ZU/1b25349ae9c87afc6a6aff0a65bff1e0/037_220024_HOLLYWOOD-PINK-REDS_HM_SOLO-JORDAN-CANDY-CHIC_RM_2308.jpg?fm=jpg",
                      "Tonya Jey",
                      "4.5",
                      context),
                ],
              ),
            ),*/

            // Dicas de Beleza
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 16.0), // Aumentar espaço acima
              child: Text(
                "Dicas de Beleza:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                _buildTipCard(
                    Icons.local_drink, // Ícone para a dica
                    "Hidratação é Fundamental",
                    "Beba bastante água todos os dias."),
                _buildTipCard(
                    Icons.wb_sunny, // Ícone para a dica
                    "Cuide da Sua Pele",
                    "Use protetor solar diariamente."),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (int index) {
          // Verifica qual item foi clicado e navega para a respectiva tela
          switch (index) {
            case 0:
              // Navegar para a tela Home
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              // Navegar para a tela Profile
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // Método para construir o card de categoria
  Widget _buildCategoryCard(
      String imageUrl, String categoryName, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          // Chama a função de requisição para buscar subcategorias da categoria selecionada
          var subcategories = await ServicesAPI.getSubcategories(categoryName);

          // Navega para a tela de detalhes com as subcategorias recebidas
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceDetailsPage(
                categoryName: categoryName,
                subcategories: subcategories,
              ),
            ),
          );
        } catch (e) {
          // Se ocorrer algum erro, mostra uma mensagem no console
          print('Erro ao carregar subcategorias: $e');
        }
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                categoryName,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Método para construir o card de especialista
  Widget _buildSpecialistCard(String imageUrl, String name, String rating, BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Expanded(
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text('Rating: $rating', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }*/

  // Método para construir o card de dica
  Widget _buildTipCard(IconData icon, String title, String description) {
  return Card(
    child: ListTile(
      leading: Icon(icon, size: 40, color: Color.fromARGB(255, 125, 177, 171)), // Aqui você coloca o ícone
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(description),
    ),
  );
}
}
