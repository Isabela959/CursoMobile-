import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  //atributos do formulário
  String _nome = "";
  String _email = "";
  double _idade = 0;
  bool _aceite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Cadastro"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //campo Nome
              TextFormField(
                decoration: InputDecoration(labelText: "Digite seu Nome"),
                validator:
                    (value) =>
                        value!.isEmpty
                            ? "Campo não Preenchido!!!"
                            : null, //Operador Ternário (Condição ? True : False)
                onSaved: (value) => _nome = value!, //formulário
              ),
              SizedBox(height: 20),
              //Campo Email
              TextFormField(
                decoration: InputDecoration(labelText: "Digite seu Email"),
                validator:
                    (value) =>
                        value!.contains("@") ? null : "digite um e-mail Válido",
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 20),
              Text("Anos de Experiência"),
              //slider de Seleção  -> Experiência
              Slider(
                value: _idade,
                min: 0,
                max: 25,
                divisions: 25,
                label: _idade.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _idade = value;
                  });
                },
              ),
              //Aceite dos Termos de Uso
              CheckboxListTile(
                value: _aceite,
                title: Text("Aceito os Termos de Uso"),
                onChanged: (value) {
                  setState(() {
                    _aceite = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/"),
                child: Text("Voltar"),
              ),
              //Criar a Validação dos Dados do formulários para mudar de tela
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/confirmacao"),
                child: Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _enviarFormulario() {
  if (_formKey.currentState!.validate() && _aceite) {
    _formKey.currentState!.save();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Dados do Formulário"),
            content: Column(
              children: [Text("Nome: $_nome"), Text("Email: $_email")],
            ),
          ),
    );
  }
}
