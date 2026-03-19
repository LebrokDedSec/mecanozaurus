import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hide system UI overlays (status/navigation bars) for full-screen control.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Lock app to landscape for a controller-style interface.
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MecanozaurusApp());
}

class MecanozaurusApp extends StatelessWidget {
  const MecanozaurusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mecanozaurus Controller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B7285)),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      ),
      home: const ControlScreen(),
    );
  }
}

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF151515),
      child: Stack(
        children: [
          // Body
          Container(
            color: const Color(0xFF151515),
            child: const Center(
              child: Text(
                'Ready',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Custom AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: const Color(0xFF151515),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mecanozaurus',
                    style: TextStyle(
                      color: Color(0xFFe63416),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Placeholder for drawer action
                    },
                    child: Image.asset(
                      'assets/Samo-logo.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
