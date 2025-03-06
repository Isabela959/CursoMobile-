import 'package:flutter/material.dart';
void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ícone de perfil (usuário)
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, size: 60, color: Colors.blue),
              ),
              SizedBox(height: 16),
              
              // Nome do usuário
              Text(
                'Isabela',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Estudante - DEV',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 32),

              // 3 Containers horizontais
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSquareContainer('Conteúdo 1'),
                  _buildSquareContainer('Conteúdo 2'),
                  _buildSquareContainer('Conteúdo 3'),
                ],
              ),
              SizedBox(height: 32),

              // 4 Linhas de dados (baixo dos containers)
              _buildInfoContainer(Icons.email, 'usuario@exemplo.com'),
              SizedBox(height: 16),
              _buildInfoContainer(Icons.phone, '+55 (11) 98765-4321'),
              SizedBox(height: 16),
              _buildInfoContainer(Icons.location_on, 'Rua Exemplo, 123'),
              SizedBox(height: 16),
              _buildInfoContainer(Icons.date_range, '01/01/1990'),

              SizedBox(height: 32),

              // Redes sociais (ícones)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook),
                    onPressed: () {},
                    iconSize: 30,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.chat_bubble),
                    onPressed: () {},
                    iconSize: 30,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () {},
                    iconSize: 30,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: 2,  // Indica o ícone ativo
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            // Ação a ser tomada ao clicar na barra de navegação
            print("Item $index pressionado");
          },
        ),
      ),
    );
  }

  // Função para criar os 3 containers quadrados
  Widget _buildSquareContainer(String content) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Função para criar containers com ícone e texto (dados)
  Widget _buildInfoContainer(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Alinha o conteúdo à esquerda
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.blue,
          ),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
