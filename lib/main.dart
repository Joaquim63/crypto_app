// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:crypto_app/data/models/favorite_crypto_model.dart'; // modelo de favorito
import 'package:crypto_app/presentation/pages/home/home_page.dart'; // HomePage

void main() async {
  // Garante que os widgets do Flutter estejam inicializados antes de qualquer operação assíncrona
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Hive
  await Hive.initFlutter();

  // Registra o TypeAdapter para FavoriteCryptoModel
  // O typeId (0 neste caso) deve ser o mesmo definido em @HiveType(typeId: 0) no FavoriteCryptoModel
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(FavoriteCryptoModelAdapter());
  }

  // Abre a box de favoritos
  // Esta box será acessada pelo provider favoriteCryptosBoxProvider no injection_container.dart
  await Hive.openBox<FavoriteCryptoModel>('favoriteCryptosBox');

  runApp(
    // Envolve o aplicativo com ProviderScope para habilitar o Riverpod
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 20, 42, 203),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(), // tela inicial do app
    );
  }
}
