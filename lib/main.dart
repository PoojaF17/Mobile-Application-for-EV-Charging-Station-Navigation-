import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/firestore_service.dart';
import 'screens/auth_gate.dart';
// After running `flutterfire configure`, uncomment the next line and import generated options
// import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform, // uncomment after configure
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirestoreService()),
      ],
      child: MaterialApp(
        title: 'EV Charging Navigator',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
        home: const AuthGate(),
      ),
    );
  }
}
