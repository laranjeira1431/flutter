import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/filme_viewmodel.dart';
import 'pages/pagina_inicial.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    // aqui a gente "entrega" a ViewModel pro resto do app usar
    return ChangeNotifierProvider(
      create: (context) => FilmeViewModel(),
      child: MaterialApp(
        title: 'Minha Lista de Filmes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PaginaInicial(),
      ),
    );
  }
}
