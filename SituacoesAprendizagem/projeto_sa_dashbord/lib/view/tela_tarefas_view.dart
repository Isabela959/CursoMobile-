import 'package:flutter/material.dart'; // Importa widgets visuais

void main() {
  runApp(MyApp()); // Função principal que inicia o app e chama o widget MyApp
}

class MyApp extends StatelessWidget { //widget sem estado
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Widget principal do app que define configurações gerais
      debugShowCheckedModeBanner: false, // Remove a faixa vermelha dedebug
      home: TelaTarefas(), // Define a tela inicial como sendo a TelaTarefas
    );
  }
}

class TelaTarefas extends StatelessWidget { // Classe da tela de tarefas (sem estado)
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Estrutura visual base do app 
      appBar: AppBar( // Barra superior (AppBar)
        title: Text("IAJ Planner"), 
        backgroundColor: Colors.grey[300], 
        actions: [ // Ícones à direita da AppBar
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}), // Ícone de notificações
        ],
      ),
      drawer: Drawer( // Menu lateral do app
        child: ListView( // Lista com opções dentro do menu
          children: [
            Text("Configurações"), // Opções do menu
            Text("Notificações"),
            Text("Temas"),
            Text("Perfil"),
            Text("Ajuda"),
          ],
        ),
      ),
      body: Padding( // Define um espaço ao redor do conteúdo da tela
        padding: const EdgeInsets.all(16.0), // Espaçamento de 16 em todos os lados
        child: Column( // Coluna para organizar os widgets verticalmente
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha os elementos à esquerda
          children: [
            Text(
              "Tarefas pendentes:", 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Espaço vertical de 10 pixels
            Expanded( // Ocupa o espaço restante disponível da tela
              child: GridView.count( // Cria uma grade com número fixo de colunas
                crossAxisCount: 2, // Define 2 colunas
                childAspectRatio: 2.5, // Define a proporção largura/altura dos containers
                mainAxisSpacing: 10, // Espaço entre as linhas
                crossAxisSpacing: 10, // Espaço entre as colunas
                children: [ // Lista com as tarefas
                  "Limpar casa",
                  "Lavar quintal",
                  "Ir ao mercado",
                  "Fazer um bolo",
                ].map((task) { // Para cada item da lista acima, cria um widget
                  return Container( // Caixa que representa cada tarefa
                    decoration: BoxDecoration( // Estilização da caixa
                      color: Color(0xFF5C75FF), // Cor azul personalizada
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                    ),
                    child: Center( // Centraliza o conteúdo
                      child: Row( // Organiza os elementos horizontalmente
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça os elementos nas extremidades
                        children: [
                          Padding( // Espaçamento interno do texto
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              task, // Nome da tarefa
                              style: TextStyle(color: Colors.white), // Cor branca do texto
                            ),
                          ),
                          Padding( // Espaçamento interno do ícone
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.circle_outlined, // Ícone de círculo (vazio)
                              color: Colors.white, // Cor branca do ícone
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(), // Converte a lista mapeada em uma lista de widgets
              ),
            ),
            BottomNavigationBar( // Barra de navegação inferior
              items: [ // Itens da barra
                BottomNavigationBarItem(
                  icon: IconButton( // Ícone clicável
                    onPressed: () => Navigator.pushNamed(context, "/tarefas"), // Vai para a rota "/tarefas"
                    icon: Icon(
                      Icons.check, // Ícone de "check"
                      size: 30,
                      color: const Color(0xFF5C75FF), // Cor azul personalizada
                    ),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/"), // Vai para a tela inicial
                    icon: Icon(
                      Icons.home, // Ícone de "home"
                      size: 30,
                      color: const Color(0xFF5C75FF),
                    ),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/infografico"), // Vai para a tela de infográfico
                    icon: Icon(
                      Icons.add, // Ícone de "adicionar"
                      size: 30,
                      color: const Color(0xFF5C75FF),
                    ),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings, // Ícone de configurações
                    size: 30,
                    color: const Color(0xFF5C75FF),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dark_mode, // Ícone de modo escuro
                    size: 30,
                    color: const Color(0xFF5C75FF),
                  ),
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
