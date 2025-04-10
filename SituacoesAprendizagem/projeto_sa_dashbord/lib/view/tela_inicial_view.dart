import 'package:flutter/material.dart'; // Importa os widgets visuais do Flutter

class TelaInicial extends StatelessWidget { // Cria um widget sem estado 
  final List<String> _imagens = ["assets/img/2.png", "assets/img/1.png"]; // Lista com os caminhos das imagens

  @override
  Widget build(BuildContext context) { // Método que constrói a interface da tela
    return Scaffold( // Estrutura base da tela (barra superior, corpo e rodapé)
      appBar: AppBar( // Cria a barra superior
        title: Text(
          "Bem-Vindo ao IAJ PLanner!", // Título da barra
          style: TextStyle(fontSize: 25, color: const Color(0xFF5C75FF)),
        ),
      ),

      body: Center( // Centraliza o conteúdo da tela
        child: Column( // Organiza os widgets verticalmente
          children: [
            SizedBox(height: 1), // Pequeno espaçamento

            Expanded( // Ocupa o espaço restante da tela
              child: Padding( // Adiciona espaçamento interno em todos os lados
                padding: EdgeInsets.all(1), 
                child: GridView.builder( // Cria uma grade dinâmica para as imagens
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 1 item por linha
                    crossAxisSpacing: 1, // Espaçamento horizontal
                    mainAxisSpacing: 1, // Espaçamento vertical
                  ),
                  itemCount: _imagens.length, // Número de imagens
                  itemBuilder: (context, index) { // Criação de cada item
                    return Image.asset(_imagens[index], fit: BoxFit.cover); // Exibe imagem da lista
                  },
                ),
              ),
            ),

            Text(
              "Tarefas pendentes:", // Título da seção de tarefas
              style: TextStyle(fontWeight: FontWeight.bold), 
            ),
            SizedBox(height: 10), // Espaçamento abaixo do texto

            Expanded( // Área da lista de tarefas
              child: GridView.count( // Grade fixa de widgets
                crossAxisCount: 2, // 2 colunas
                childAspectRatio: 2.5, // Proporção largura x altura dos blocos
                mainAxisSpacing: 10, // Espaço entre linhas
                crossAxisSpacing: 10, // Espaço entre colunas
                children: [
                  "Limpar casa",
                  "Lavar quintal",
                  "Ir ao mercado",
                  "Fazer um bolo",
                ].map((task) { // Para cada tarefa, cria um container
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF5C75FF), // Cor de fundo azul
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                    ),
                    child: Center(
                      child: Row( // Exibe texto e ícone na horizontal
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaçamento entre texto e ícone
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              task, // Nome da tarefa
                              style: TextStyle(color: Colors.white), // Cor branca
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.circle_outlined, // Ícone de tarefa pendente
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(), // Converte os itens em lista de widgets
              ),
            ),

            BottomNavigationBar( // Barra de navegação inferior
              items: [
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/tarefas"), // Vai para a tela de tarefas
                    icon: Icon(Icons.check, size: 30, color: const Color(0xFF5C75FF)),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/"), // Vai para a tela inicial
                    icon: Icon(Icons.home, size: 30, color: const Color(0xFF5C75FF)),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/infografico"), // Vai para o infográfico
                    icon: Icon(Icons.add, size: 30, color: const Color(0xFF5C75FF)),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 30, color: const Color(0xFF5C75FF)), // Ícone sem ação ainda
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dark_mode, size: 30, color: const Color(0xFF5C75FF)), // Ícone modo escuro (sem ação)
                  label: '', // nome do botão (não vai aparecer)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
