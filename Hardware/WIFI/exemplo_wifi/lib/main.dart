import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: WifiStatusScreen()));
}

class WifiStatusScreen extends StatefulWidget {
  const WifiStatusScreen({super.key});

  @override
  State<WifiStatusScreen> createState() => _WifiStatusScreenState();
}

class _WifiStatusScreenState extends State<WifiStatusScreen> {
  //atributos
  String _mensagem = ""; //informa o Status da Conexão

  late StreamSubscription<List<ConnectivityResult>> _conexao;

  //verificar o status da conexão no começo da aplicação
  void _checkInitialConnection() async {
    ConnectivityResult result =
        (await Connectivity().checkConnectivity()) as ConnectivityResult;
    _updateStatusConnection(result);
  }

  // quando houver mudança de status da conexão identificar
  void _updateStatusConnection(ConnectivityResult result) async {
    setState(() {
      switch (result) {
        case ConnectivityResult.wifi:
          _mensagem = "Conectado no WIFI";
          break;
        case ConnectivityResult.mobile:
          _mensagem = "Conectado Via Dados Móveis";
          break;
        case ConnectivityResult.none:
          _mensagem = "Sem Conexão com a Internet";
          break;
        default:
          _mensagem = "Procurando Conexão";
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //1. Faz uma verificação inicial ao abrir a tela
    _checkInitialConnection();

    // 2. Começa a ouvir as mudanças de status (stream)
    _conexao = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;
      _updateStatusConnection(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Status da Conexão")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              //mudar de acordo com a conexão
              _mensagem.contains("WIFI")
                  ? Icons.wifi
                  : _mensagem.contains("Dados")
                  ? Icons.network_cell
                  : Icons.wifi_off,
              size: 80,
              color: _mensagem.contains("Sem Conexão")
                  ? Colors.red
                  : Colors.blueAccent,
            ),
            SizedBox(height: 10),
            Text("Status: $_mensagem"),
          ],
        ),
      ),
    );
  }
}
