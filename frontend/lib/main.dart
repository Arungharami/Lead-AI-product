import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/leads_screen.dart';
import 'screens/subscription_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const LeadAiApp());
}

class LeadAiApp extends StatelessWidget {
  const LeadAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lead.AI',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1220),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B82F6), brightness: Brightness.dark),
        cardTheme: const CardThemeData(color: Color(0xFF111827), elevation: 0),
      ),
      home: const LoginScreen(),
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
  final pages = const [DashboardScreen(), ChatScreen(), LeadsScreen(), SubscriptionScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'AI Chat'),
          NavigationDestination(icon: Icon(Icons.list_alt_outlined), label: 'Leads'),
          NavigationDestination(icon: Icon(Icons.workspace_premium_outlined), label: 'Plan'),
        ],
        onDestinationSelected: (i) => setState(() => index = i),
      ),
    );
  }
}
