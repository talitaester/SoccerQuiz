import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/coin_provider.dart';
import 'screens/splash_screen.dart';
import 'services/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = await buildServiceContainer();

  runApp(MyApp(container: container));
}

class MyApp extends StatelessWidget {
  final ServiceContainer container;

  const MyApp({Key? key, required this.container}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider.value(value: container.authProvider),
        Provider.value(value: container),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Soccer Quiz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: SplashScreen(),
      ),
    );
  }
}