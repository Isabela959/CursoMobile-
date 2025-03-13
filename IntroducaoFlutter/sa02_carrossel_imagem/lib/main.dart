import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MaterialApp(home: CarrosselScreen()));
}

class CarrosselScreen extends StatelessWidget {
  final List<String> imagens = [
    'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0',
    'https://images.unsplash.com/photo-1521747116042-5a810fda9664',
    'https://images.unsplash.com/photo-1504384308090-c894fdcc538d',
    'https://images.unsplash.com/photo-1518837695005-2083093ee35b',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrossel de Imagens')),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(height: 300, autoPlay: true),
          items: imagens.map((url) {
            return Container(
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(url, fit: BoxFit.cover, width: 1000),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
