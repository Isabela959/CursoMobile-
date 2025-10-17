import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_auth/local_auth.dart';

class AuthController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _localAuth = LocalAuthentication();

  // pegar usuário logado
  User? get currentUser => _auth.currentUser;

  /// Cadastro com NIF e senha
  Future<void> cadastrarUsuario({
    required String nome,
    required String nif,
    required String senha,
  }) async {
    // email para FirebaseAuth
    final email = '$nif@empresa.com';

    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );

    // salva dados no Firestore
    await _firestore.collection('usuarios').doc(cred.user!.uid).set({
      'id': cred.user!.uid,
      'nome': nome,
      'nif': nif,
    });
  }

  /// Login com NIF e senha
  Future<void> loginUsuario({
    required String nif,
    required String senha,
  }) async {
    final email = '$nif@empresa.com';
    await _auth.signInWithEmailAndPassword(email: email, password: senha);
  }

  /// Autenticação por biometria
  Future<bool> autenticarBiometria() async {
    bool podeAutenticar = await _localAuth.canCheckBiometrics;
    if (!podeAutenticar) return false;

    return await _localAuth.authenticate(
      localizedReason: 'Use a biometria para entrar',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );
  }

  /// Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
