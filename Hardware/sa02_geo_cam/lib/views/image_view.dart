import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  List<Image> images = [];

  // método para tirar a foto
  void TakeImage() async {
    //criar método
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              //chamar o método para tirar a foto com localização
            },
          ),
        ],
      ),
      body: //constroi o GRID VIEW,
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //mostrar a foto em tela cheia com a localização
            },
            child: Image.file(
              //pega o caminho da foto e mostra na tela
              images[index].imagePath, // converte para file
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
