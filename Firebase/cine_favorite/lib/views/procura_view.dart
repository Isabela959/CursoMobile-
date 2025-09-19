import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _db = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  final _searchController = TextEditingController();

  String _searchText = "";

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text.trim().toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cine Favorite"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Pesquisar filmes ou séries",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20),
            Text("Filmes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 180,
              child: StreamBuilder<QuerySnapshot>(
                stream: _db
                    .collection("filmes")
                    .where("titulo", isGreaterThanOrEqualTo: _searchText)
                    .where("titulo", isLessThanOrEqualTo: _searchText + '\uf8ff')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Nenhum filme encontrado"));
                  }
                  final filmes = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filmes.length,
                    itemBuilder: (context, index) {
                      final filme = filmes[index].data() as Map<String, dynamic>;
                      return Container(
                        width: 120,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            filme["imagemUrl"] != null
                              ? Image.network(filme["imagemUrl"], height: 120, fit: BoxFit.cover)
                              : Container(height: 120, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              filme["titulo"] ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text("Séries", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 180,
              child: StreamBuilder<QuerySnapshot>(
                stream: _db
                    .collection("series")
                    .where("titulo", isGreaterThanOrEqualTo: _searchText)
                    .where("titulo", isLessThanOrEqualTo: _searchText + '\uf8ff')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Nenhuma série encontrada"));
                  }
                  final series = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: series.length,
                    itemBuilder: (context, index) {
                      final serie = series[index].data() as Map<String, dynamic>;
                      return Container(
                        width: 120,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            serie["imagemUrl"] != null
                              ? Image.network(serie["imagemUrl"], height: 120, fit: BoxFit.cover)
                              : Container(height: 120, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              serie["titulo"] ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}