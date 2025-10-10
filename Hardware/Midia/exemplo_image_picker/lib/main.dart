import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  //usar a biblioteca image_picker
  //manipular arquivos
  File? _image;
  final _picker = ImagePicker(); //controller do ImagePicker

  //método para usar o imagepicker
  //método para tirar foto
  void _getImageFromCamera() async {
    //abrir a camera e permitir tirar uma foto
    //armazenar a foto em um arquivo temporário (pickedFile)
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    //verificar se a imagem foi salva no arquivo temporário
    if (pickedFile != null) {
      setState(() {
        //coloco a imagem dentro do meu aplicativo
        _image = File(pickedFile.path);
      });
    }
  }

  void _getImageFromGallery() async {
    //abrir a galeria do dispositivo
    //armazenar a foto em um arquivo temporário (pickedFile)
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    //verificar se a imagem foi salva no arquivo temporário
    if (pickedFile != null) {
      setState(() {
        //coloco a imagem dentro do meu aplicativo
        _image = File(pickedFile.path);
      });
    }
  }

  // construção da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Image Picked"),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //campo para adicionar a imagem => ternário
          _image != null
          ? Image.file(_image!, height: 300,)
          : Text("Nenhuma Imagem Selecionada"),
          // colocar dois botões
          SizedBox(height: 20,),
          ElevatedButton(onPressed: _getImageFromCamera, child: Text("Tirar Foto")),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: _getImageFromGallery, child: Text("Escolher da Galeria"))
        ],
      ),),
    );
  }
}
