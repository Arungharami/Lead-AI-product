import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/chat_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/leads_screen.dart';
import 'screens/login_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/subscription_screen.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LeadAiApp());
}

class LeadAiApp extends StatelessWidget {
  const LeadAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    const neonBlue = Color(0xFF3B82F6);
    const neonPurple = Color(0xFF8B5CF6);

    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lead AI Mobile',
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: const Color(0xFF090E1A),
          colorScheme: ColorScheme.fromSeed(seedColor: neonBlue, brightness: Brightness.dark).copyWith(secondary: neonPurple),
          cardTheme: const CardThemeData(color: Color(0xFF101827)),
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            indicatorColor: Color(0x333B82F6),
            labelTextStyle: WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        home: const AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();
    return StreamBuilder(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.data == null) return const LoginScreen();
        return const AppShell();
      },
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;
  final pages = const [DashboardScreen(), ChatScreen(), LeadsScreen(), SubscriptionScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => index = 1),
        backgroundColor: const Color(0xFF8B5CF6),
        child: const Icon(Icons.auto_awesome),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: NavigationBar(
              height: 72,
              selectedIndex: index,
              onDestinationSelected: (i) => setState(() => index = i),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
                NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
                NavigationDestination(icon: Icon(Icons.list_alt_outlined), label: 'Leads'),
                NavigationDestination(icon: Icon(Icons.workspace_premium_outlined), label: 'Plan'),
                NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
