import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  runApp(const WeightLossApp());
}

class WeightLossApp extends StatefulWidget {
  const WeightLossApp({super.key});

  @override
  State<WeightLossApp> createState() => _WeightLossAppState();
}

class _WeightLossAppState extends State<WeightLossApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007AFF),
          primary: const Color(0xFF007AFF),
          secondary: const Color(0xFF30D158),
          surface: const Color(0xFFF8F8FA),
          onSurface: const Color(0xFF1C2526),
          brightness: Brightness.light,
          background: const Color(0xFFF5F5F5),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF007AFF), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF6B7280)),
          hintStyle: const TextStyle(color: Color(0xFF6B7280)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007AFF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            elevation: 0,
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFFFFFFFF),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Color(0xFF1C2526), fontSize: 34, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Color(0xFF1C2526), fontSize: 28, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: Color(0xFF1C2526), fontSize: 24, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: Color(0xFF1C2526), fontSize: 17),
          bodyMedium: TextStyle(color: Color(0xFF6B7280), fontSize: 15),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F5F5),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Color(0xFF1C2526), fontSize: 20, fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: Color(0xFF007AFF)),
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF000000),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007AFF),
          primary: const Color(0xFF007AFF),
          secondary: const Color(0xFF30D158),
          surface: const Color(0xFF1C1C1E),
          onSurface: const Color(0xFFFFFFFF),
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1C1C1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF007AFF), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF8E8E93)),
          hintStyle: const TextStyle(color: Color(0xFF8E8E93)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007AFF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            elevation: 0,
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1C1C1E),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 17),
          bodyMedium: TextStyle(color: Color(0xFF8E8E93), fontSize: 15),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: Color(0xFF007AFF)),
        ),
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.hasData ? const MainScreen() : const LoginPage();
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  bool _isLoading = false;

  Future<void> _login() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF007AFF), Color(0xFF30D158)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    size: 40,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(duration: 600.ms).scale(),
                const SizedBox(height: 32),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineLarge,
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue your journey',
                  style: Theme.of(context).textTheme.bodyMedium,
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF007AFF)),
                        ),
                      ).animate().fadeIn(delay: 600.ms),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF007AFF)),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() => _obscureText = !_obscureText),
                          ),
                        ),
                      ).animate().fadeIn(delay: 800.ms),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Sign In'),
                        ).animate().fadeIn(delay: 1000.ms),
                      ),
                    ],
                  ),
                ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 400.ms),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignupPage()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 1200.ms),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  bool _isLoading = false;

  Future<void> _signup() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'height': null,
          'goalWeight': null,
        });
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MainScreen()),
            (route) => false,
          );
        }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF007AFF), Color(0xFF30D158)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    size: 40,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(duration: 600.ms).scale(),
                const SizedBox(height: 32),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineLarge,
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 8),
                Text(
                  'Start your fitness journey today',
                  style: Theme.of(context).textTheme.bodyMedium,
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline, color: Color(0xFF007AFF)),
                        ),
                      ).animate().fadeIn(delay: 600.ms),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF007AFF)),
                        ),
                      ).animate().fadeIn(delay: 800.ms),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF007AFF)),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() => _obscureText = !_obscureText),
                          ),
                        ),
                      ).animate().fadeIn(delay: 1000.ms),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signup,
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Create Account'),
                        ).animate().fadeIn(delay: 1200.ms),
                      ),
                    ],
                  ),
                ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 400.ms),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 1400.ms),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<WeightEntry> _entries = [];
  double? _goalWeight;
  double? _userHeight;
  TimeOfDay? _reminderTime;
  bool _isLoading = true;

  void _addWeight(double weight) {
    final entry = WeightEntry(weight, DateTime.now());
    FirebaseFirestore.instance.collection('weights').add({
      'weight': entry.weight,
      'date': entry.date.toIso8601String(),
      'userId': FirebaseAuth.instance.currentUser?.uid,
    // ignore: body_might_complete_normally_catch_error
    }).catchError((error) {
      print("Error adding weight: $error");
    });
    setState(() {
      _entries.add(entry);
    });
  }

  void _setGoalWeight(double goal) {
    setState(() {
      _goalWeight = goal;
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'goalWeight': goal}).catchError((error) {
        print("Error setting goal weight: $error");
      });
    });
  }

  void _setUserHeight(double height) {
    setState(() {
      _userHeight = height;
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'height': height}).catchError((error) {
        print("Error setting height: $error");
      });
    });
  }

  String _getDailyTip() {
    final tips = [
      "💧 Stay hydrated with 8 glasses of water daily",
      "🍎 Add colorful fruits to your meals",
      "🏋️‍♂️ Move your body for 30 minutes each day",
      "🥗 Fill half your plate with vegetables",
      "💤 Quality sleep supports your wellness goals",
      "🚶 Take the stairs whenever possible",
      "🥚 Include lean protein in every meal",
      "🧘 Practice mindfulness and stress management",
    ];
    return tips[Random().nextInt(tips.length)];
  }

  List<Widget> _pages() => [
        HomeTab(
          key: null,
          entries: _entries,
          addWeightCallback: _addWeight,
          goalWeight: _goalWeight,
          userHeight: _userHeight,
          dailyTip: _getDailyTip(),
        ),
        const DashboardTab(key: null),
        HistoryTab(
          key: null,
          entries: _entries,
          onDateSelected: (date) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WeightGraphScreen(
                  entries: _entries,
                  selectedDate: date,
                ),
              ),
            );
          },
        ),
        const ExercisesTab(key: null),
        SettingsTab(
          key: null,
          setGoalCallback: _setGoalWeight,
          setHeightCallback: _setUserHeight,
          goalWeight: _goalWeight,
          userHeight: _userHeight,
          reminderTime: _reminderTime,
          onReminderSet: (time) => setState(() => _reminderTime = time),
          onThemeToggle: (isDark) => (context as Element).findAncestorStateOfType<_WeightLossAppState>()?.toggleTheme(isDark),
        ),
      ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        }
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists && mounted) {
        setState(() {
          _goalWeight = userDoc.data()?['goalWeight']?.toDouble();
          _userHeight = userDoc.data()?['height']?.toDouble();
        });
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('weights')
          .where('userId', isEqualTo: userId)
          .orderBy('date')
          .get();
      final data = snapshot.docs.map((doc) {
        final d = doc.data();
        return WeightEntry(
          (d['weight'] as num).toDouble(),
          DateTime.parse(d['date']),
        );
      }).toList();
      if (mounted) {
        setState(() {
          _entries.addAll(data);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _pages()[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).textTheme.bodyMedium?.color,
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          type: BottomNavigationBarType.fixed,
          onTap: (int index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.analytics),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_outlined),
              activeIcon: Icon(Icons.fitness_center),
              label: 'Exercises',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class WeightEntry {
  final double weight;
  final DateTime date;

  WeightEntry(this.weight, this.date);
}

class WeightGraphScreen extends StatelessWidget {
  final List<WeightEntry> entries;
  final DateTime selectedDate;

  const WeightGraphScreen({
    super.key,
    required this.entries,
    required this.selectedDate,
  });

  List<FlSpot> _generateSpots() {
    final filteredEntries = entries
        .where((entry) => DateUtils.isSameDay(entry.date, selectedDate))
        .toList();
    return filteredEntries.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.weight);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final spots = _generateSpots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Progress - ${DateFormat('MMM d, yyyy').format(selectedDate)}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weight Data',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              if (spots.isNotEmpty)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 5,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Theme.of(context).dividerColor,
                              strokeWidth: 1,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: Theme.of(context).colorScheme.primary,
                            barWidth: 3,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  strokeWidth: 2,
                                  strokeColor: Theme.of(context).colorScheme.primary,
                                );
                              },
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Theme.of(context).colorScheme.primary.withAlpha(25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Center(
                  child: Text(
                    'No weight data for this date',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  final List<WeightEntry> entries;
  final void Function(double) addWeightCallback;
  final double? goalWeight;
  final double? userHeight;
  final String dailyTip;

  const HomeTab({
    super.key,
    required this.entries,
    required this.addWeightCallback,
    required this.goalWeight,
    required this.userHeight,
    required this.dailyTip,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController _weightController = TextEditingController();

  List<FlSpot> _generateSpots() {
    return widget.entries.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.weight);
    }).toList();
  }

  double? _calculateBMI() {
    if (widget.entries.isNotEmpty && widget.userHeight != null) {
      final latestWeight = widget.entries.last.weight;
      final heightInMeters = widget.userHeight! / 100;
      return latestWeight / (heightInMeters * heightInMeters);
    }
    return null;
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  String _getWeightTrend() {
    if (widget.entries.length < 2) return 'Need more data';
    final lastTwo = widget.entries.reversed.take(2).toList();
    final difference = lastTwo[0].weight - lastTwo[1].weight;
    if (difference < 0) return 'Decreasing 📉';
    if (difference > 0) return 'Increasing 📈';
    return 'Stable ⚖️';
  }

  Future<void> _exportData() async {
    try {
      final csvData = [
        ['Date', 'Weight (kg)'],
        ...widget.entries.map((e) => [
              DateFormat('yyyy-MM-dd').format(e.date),
              e.weight.toString(),
            ]),
      ];
      final csvString = const ListToCsvConverter().convert(csvData);
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/weight_data.csv';
      final file = File(path);
      await file.writeAsString(csvString);
      await Share.shareXFiles([XFile(path)], text: 'My Weight Data');
    } catch (e) {
      print("Error exporting data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final spots = _generateSpots();
    final bmi = _calculateBMI();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Track Your Progress',
              style: Theme.of(context).textTheme.headlineLarge,
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 8),
            Text(
              'Every step counts towards your goals',
              style: Theme.of(context).textTheme.bodyMedium,
            ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log Your Weight',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      hintText: 'Enter your current weight',
                      prefixIcon: Icon(Icons.monitor_weight_outlined, color: Color(0xFF007AFF)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final weight = double.tryParse(_weightController.text);
                            if (weight != null && weight > 0) {
                              widget.addWeightCallback(weight);
                              _weightController.clear();
                            }
                          },
                          child: const Text('Add Weight'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _exportData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF30D158),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        ),
                        child: const Icon(Icons.share, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 400.ms),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.trending_up, color: Color(0xFF30D158), size: 24),
                        const SizedBox(height: 8),
                        Text(
                          'Trend',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getWeightTrend(),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.favorite_outline, color: Color(0xFFFF453A), size: 24),
                        const SizedBox(height: 8),
                        Text(
                          'BMI',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          bmi != null ? '${bmi.toStringAsFixed(1)} (${_getBMICategory(bmi)})' : 'Add height',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms, delay: 600.ms),
            const SizedBox(height: 24),
            if (spots.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight Progress',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 5,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Theme.of(context).dividerColor,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    '${value.toInt()}',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              isCurved: true,
                              color: Theme.of(context).colorScheme.primary,
                              barWidth: 3,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    strokeWidth: 2,
                                    strokeColor: Theme.of(context).colorScheme.primary,
                                  );
                                },
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Theme.of(context).colorScheme.primary.withAlpha(25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().slideX(begin: 0.3, duration: 400.ms, delay: 800.ms),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF30D158), Color(0xFF32D160)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daily Tip',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.dailyTip,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms, delay: 1000.ms),
          ],
        ),
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  double _calculateWeeklyChange(List<WeightEntry> entries) {
    if (entries.length < 2) return 0.0;
    final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    final recentEntries = entries.where((e) => e.date.isAfter(oneWeekAgo)).toList();
    if (recentEntries.length < 2) return 0.0;
    final latest = recentEntries.last.weight;
    final earliest = recentEntries.first.weight;
    return latest - earliest;
  }

  double _calculateAverageWeight(List<WeightEntry> entries) {
    if (entries.isEmpty) return 0.0;
    return entries.map((e) => e.weight).reduce((a, b) => a + b) / entries.length;
  }

  @override
  Widget build(BuildContext context) {
    final _mainScreenState = context.findAncestorStateOfType<_MainScreenState>();
    final entries = _mainScreenState?._entries ?? [];
    final weeklyChange = _calculateWeeklyChange(entries);
    final averageWeight = _calculateAverageWeight(entries);
    final goalWeight = _mainScreenState?._goalWeight;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Analytics',
              style: Theme.of(context).textTheme.headlineLarge,
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 8),
            Text(
              'Insights into your wellness journey',
              style: Theme.of(context).textTheme.bodyMedium,
            ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.trending_up,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Weekly Progress',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weight Change',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${weeklyChange.toStringAsFixed(1)} kg',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: weeklyChange < 0 ? const Color(0xFF30D158) : const Color(0xFFFF453A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Average',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${averageWeight.toStringAsFixed(1)} kg',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 400.ms),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF30D158).withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.flag_outlined,
                          color: Color(0xFF30D158),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Goal Progress',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: goalWeight != null && entries.isNotEmpty
                          ? 1 - ((entries.last.weight - goalWeight) / entries.last.weight).clamp(0.0, 1.0)
                          : 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF30D158), Color(0xFF32D160)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(goalWeight != null && entries.isNotEmpty ? (1 - ((entries.last.weight - goalWeight) / entries.last.weight).clamp(0.0, 1.0)) * 100 : 0).toStringAsFixed(0)}% Complete',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        goalWeight != null && entries.isNotEmpty
                            ? '${(entries.last.weight - goalWeight).abs().toStringAsFixed(1)} kg to go'
                            : 'Set a goal',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 600.ms),
          ],
        ),
      ),
    );
  }
}

class HistoryTab extends StatefulWidget {
  final List<WeightEntry> entries;
  final Function(DateTime) onDateSelected;

  const HistoryTab({
    super.key,
    required this.entries,
    required this.onDateSelected,
  });

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'History',
                  style: Theme.of(context).textTheme.headlineLarge,
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 8),
                Text(
                  '${widget.entries.length} entries recorded',
                  style: Theme.of(context).textTheme.bodyMedium,
                ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: widget.entries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Icon(
                            Icons.history,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No entries yet',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start logging your weight to see history',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      TableCalendar(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                          widget.onDateSelected(selectedDay);
                        },
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withAlpha(128),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          todayTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          selectedTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          defaultTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          weekendTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                          outsideDaysVisible: false,
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
                          leftChevronIcon: Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.onSurface),
                          rightChevronIcon: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurface),
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) {
                            final entriesOnDate = widget.entries.where((entry) =>
                                DateUtils.isSameDay(entry.date, date));
                            if (entriesOnDate.isNotEmpty) {
                              return Center(
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF30D158),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_selectedDay != null)
                        ...widget.entries.where((entry) =>
                            DateUtils.isSameDay(entry.date, _selectedDay!)).map((entry) {
                          final index = widget.entries.indexOf(entry);
                          final previousEntry = index > 0 ? widget.entries[index - 1] : null;
                          final weightChange = previousEntry != null
                              ? entry.weight - previousEntry.weight
                              : 0.0;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: index == 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor,
                                width: index == 0 ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: weightChange < 0
                                        ? const Color(0xFF30D158)
                                        : weightChange > 0
                                            ? const Color(0xFFFF453A)
                                            : Theme.of(context).textTheme.bodyMedium?.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${entry.weight.toStringAsFixed(1)} kg',
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (weightChange != 0)
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: (weightChange < 0
                                                    ? const Color(0xFF30D158)
                                                    : const Color(0xFFFF453A)).withAlpha(25),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '${weightChange > 0 ? '+' : ''}${weightChange.toStringAsFixed(1)}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: weightChange < 0
                                                      ? const Color(0xFF30D158)
                                                      : const Color(0xFFFF453A),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        DateFormat('HH:mm').format(entry.date),
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ).animate().slideX(
                            begin: 0.3,
                            duration: 400.ms,
                            delay: Duration(milliseconds: 100 * index),
                          );
                        }),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class ExercisesTab extends StatelessWidget {
  final List<Map<String, String>> exercises = const [
    {'name': 'Squats', 'description': 'Stand with feet shoulder-width apart, lower your hips as if sitting back into a chair, then push back up.'},
    {'name': 'Push-Ups', 'description': 'Place hands shoulder-width apart, lower your chest to the ground, then push back up.'},
    {'name': 'Plank', 'description': 'Hold a push-up position with your body straight, engaging your core for 20-60 seconds.'},
    {'name': 'Lunges', 'description': 'Step forward with one leg, lowering your hips until both knees are bent at about 90 degrees, then return.'},
    {'name': 'Burpees', 'description': 'From a standing position, drop into a squat, kick back to a plank, do a push-up, return to squat, and jump up.'},
    {'name': 'Sit-Ups', 'description': 'Lie on your back, bend your knees, and lift your torso to your knees using your abdominal muscles.'},
    {'name': 'Mountain Climbers', 'description': 'In a plank position, rapidly alternate bringing your knees toward your chest as if climbing.'},
    {'name': 'Jumping Jacks', 'description': 'Jump while spreading your legs and raising your arms overhead, then return to the starting position.'},
    {'name': 'Leg Raises', 'description': 'Lie on your back and lift your legs to a 90-degree angle, then lower them slowly without touching the ground.'},
    {'name': 'Bicycle Crunches', 'description': 'Lie on your back, alternate touching your elbow to the opposite knee while extending the other leg.'},
    {'name': 'Russian Twists', 'description': 'Sit with knees bent, lean back slightly, and twist your torso side to side with or without a weight.'},
  ];

  const ExercisesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Exercise Guidance',
              style: Theme.of(context).textTheme.headlineLarge,
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 8),
            Text(
              'Techniques to boost your fitness',
              style: Theme.of(context).textTheme.bodyMedium,
            ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
            const SizedBox(height: 32),
            ...exercises.asMap().entries.map((entry) {
              final exercise = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise['name']!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      exercise['description']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ).animate().slideY(
                begin: 0.3,
                duration: 400.ms,
                delay: Duration(milliseconds: 100 * entry.key),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  final void Function(double) setGoalCallback;
  final void Function(double) setHeightCallback;
  final double? goalWeight;
  final double? userHeight;
  final TimeOfDay? reminderTime;
  final void Function(TimeOfDay?) onReminderSet;
  final void Function(bool) onThemeToggle;

  const SettingsTab({
    super.key,
    required this.setGoalCallback,
    required this.setHeightCallback,
    required this.goalWeight,
    required this.userHeight,
    required this.reminderTime,
    required this.onReminderSet,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headlineLarge,
                ).animate().fadeIn(duration: 400.ms),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Customize your experience',
              style: Theme.of(context).textTheme.bodyMedium,
            ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
            const SizedBox(height: 32),
            if (user != null)
              _buildSettingCard(
                title: 'Logged in as',
                subtitle: user.email ?? user.displayName ?? user.uid,
                icon: Icons.person,
                iconColor: const Color(0xFF007AFF),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  }
                },
                trailing: const Icon(Icons.logout, color: Color(0xFFFF453A)),
                context: context,
              ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 400.ms),
            const SizedBox(height: 16),
            _buildSettingCard(
              title: 'Goal Weight',
              subtitle: goalWeight != null ? '${goalWeight!.toStringAsFixed(1)} kg' : 'Not set',
              icon: Icons.flag_outlined,
              iconColor: const Color(0xFF30D158),
              onTap: () => _showGoalDialog(context),
              context: context,
            ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 600.ms),
            const SizedBox(height: 16),
            _buildSettingCard(
              title: 'Height',
              subtitle: userHeight != null ? '${userHeight!.toStringAsFixed(0)} cm' : 'Not set',
              icon: Icons.height,
              iconColor: const Color(0xFF007AFF),
              onTap: () => _showHeightDialog(context),
              context: context,
            ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 800.ms),
            const SizedBox(height: 16),
            _buildSettingCard(
              title: 'Reminder',
              subtitle: reminderTime != null
                  ? reminderTime!.format(context)
                  : 'Not set',
              icon: Icons.notifications_none,
              iconColor: const Color(0xFFFF453A),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: reminderTime ?? TimeOfDay.now(),
                );
                if (time != null) onReminderSet(time);
              },
              context: context,
            ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 1000.ms),
            const SizedBox(height: 16),
            _buildSettingCard(
              title: 'Dark Mode',
              subtitle: 'Toggle theme preference',
              icon: Icons.dark_mode_outlined,
              iconColor: Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF8E8E93),
              onTap: () {},
              trailing: Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) => onThemeToggle(value),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              context: context,
            ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 1200.ms),
            const SizedBox(height: 16),
            _buildSettingCard(
              title: 'About',
              subtitle: 'App version 1.0.0',
              icon: Icons.info_outline,
              iconColor: Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF8E8E93),
              onTap: () {},
              trailing: null,
              context: context,
            ).animate().slideY(begin: 0.3, duration: 400.ms, delay: 1400.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
    Widget? trailing,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  void _showGoalDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Set Goal Weight',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Enter goal weight in kg',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: Theme.of(context).textTheme.bodyMedium),
          ),
          TextButton(
            onPressed: () {
              final goal = double.tryParse(controller.text);
              if (goal != null && goal > 0) {
                setGoalCallback(goal);
                Navigator.pop(context);
              }
            },
            child: Text('Set', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }

  void _showHeightDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Set Height',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Enter height in cm',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: Theme.of(context).textTheme.bodyMedium),
          ),
          TextButton(
            onPressed: () {
              final height = double.tryParse(controller.text);
              if (height != null && height > 0) {
                setHeightCallback(height);
                Navigator.pop(context);
              }
            },
            child: Text('Set', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}