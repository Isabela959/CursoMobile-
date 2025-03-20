import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState()=> _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> _imagens = [
    //colocar as URL das imagens
    "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0",
    "https://images.unsplash.com/photo-1521747116042-5a810fda9664",
    "https://images.unsplash.com/photo-1504384308090-c894fdcc538d",
    "https://images.unsplash.com/photo-1518837695005-2083093ee35b",
    "https://images.unsplash.com/photo-1501594907352-04cda38ebc29",
    "https://images.unsplash.com/photo-1519681393784-d120267933ba",
    "https://images.unsplash.com/photo-1531259683007-016a7b628fc3",
    "https://images.unsplash.com/photo-1506619216599-9d16d0903dfd",
    "https://images.unsplash.com/photo-1494172961521-33799ddd43a5",
    "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        // Janelas, cada janela tem um scaffold
        appBar: AppBar(title: Text("Galeria de Imagens")),
        body: Center(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 300, autoPlay: true),
                items:
                    _imagens.map((url) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(url, fit: BoxFit.cover),
                        ),
                      );
                    }).toList(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _imagens.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _mostrarImagem(context, _imagens[index]),
                        child: Image.network(_imagens[index], fit: BoxFit.cover),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _adicionarImagem,
          child: Icon(Icons.add),),
      ),
    );
  } // fim do build
  // método mostrar imagem

  void _mostrarImagem(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Image.network(url),
        ));
  }

  // adicionar imagem
  void _adicionarImagem(){
    TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Adicionar NOva Imagem"),
        content: TextField(
          controller: urlController,
          decoration: InputDecoration(hintText: "Insira o URL da Imagem"),
        ),
        actions: [
          // botão de Cancelamento/Enviar
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar")),
            TextButton(
            onPressed: (){
              if (urlController.text.isNotEmpty) {
                setState((){
                  _imagens.add(urlController.text);
                });
                Navigator.pop(context);
              }
            } , 
            child: Text("Adicionar"))
        ],
      ));
  }

} // fim da classe
