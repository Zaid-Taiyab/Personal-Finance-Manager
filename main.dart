import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'services/auth_service.dart';
import 'services/database_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => DatabaseService()),
      ],
      child: MaterialApp(
        title: 'Personal Finance Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AuthService>(
          builder: (context, authService, _) {
            return authService.isAuthenticated ? DashboardScreen() : LoginScreen();
          },
        ),
      ),
    );
  }
}

