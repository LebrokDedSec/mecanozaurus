import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF151515),
    systemNavigationBarColor: Color(0xFF151515),
    systemNavigationBarDividerColor: Color(0xFF151515),
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Keep immersive fullscreen so system bars are hidden during control mode.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Lock app to landscape for a controller-style interface.
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MecanosaurusApp());
}

class MecanosaurusApp extends StatelessWidget {
  const MecanosaurusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mecanosaurus Controller',
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _joyX = 0.0;
  double _joyY = 0.0;
  Offset _knobOffset = Offset.zero;
  double _omega = 0.0;
  double _sliderKnobX = 0.0;

  void _handleJoyPan(Offset localPos) {
    final delta = localPos - const Offset(110, 110);
    const maxTravel = 88.0;
    final clamped = delta.distance > maxTravel
        ? delta / delta.distance * maxTravel
        : delta;
    setState(() {
      _knobOffset = clamped;
      _joyX = clamped.dx / maxTravel;
      _joyY = -clamped.dy / maxTravel;
    });
  }

  void _handleJoyEnd() {
    setState(() {
      _knobOffset = Offset.zero;
      _joyX = 0.0;
      _joyY = 0.0;
    });
  }

  void _handleSliderEnd() {
    setState(() {
      _sliderKnobX = 0.0;
      _omega = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        primary: false,
        backgroundColor: const Color(0xFF151515),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFF343434),
          ),
        ),
        title: const Text(
          'Mecanosaurus',
          style: TextStyle(
            color: Color(0xFFe63416),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              child: Image.asset(
                'assets/Samo-logo.png',
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF151515),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'X',
                                    style: TextStyle(
                                      color: Color(0xFFe63416),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Container(height: 1, color: const Color(0xFF343434)),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    _joyX.toStringAsFixed(3),
                                    style: const TextStyle(
                                      color: Color(0xFFd5d5d5),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, color: const Color(0xFF343434)),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Y',
                                    style: TextStyle(
                                      color: Color(0xFFe63416),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Container(height: 1, color: const Color(0xFF343434)),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    _joyY.toStringAsFixed(3),
                                    style: const TextStyle(
                                      color: Color(0xFFd5d5d5),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, color: const Color(0xFF343434)),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'ω',
                                    style: TextStyle(
                                      color: Color(0xFFe63416),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Container(height: 1, color: const Color(0xFF343434)),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    _omega.toStringAsFixed(3),
                                    style: const TextStyle(
                                      color: Color(0xFFd5d5d5),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 1, color: const Color(0xFF343434)),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final trackW = constraints.maxWidth * 0.75;
                          final halfW = trackW / 2;
                          return GestureDetector(
                            onPanUpdate: (d) {
                              final dx = (d.localPosition.dx - halfW)
                                  .clamp(-halfW, halfW);
                              setState(() {
                                _sliderKnobX = dx;
                                _omega = -(dx / halfW);
                              });
                            },
                            onPanEnd: (_) => _handleSliderEnd(),
                            child: SizedBox(
                              width: trackW,
                              height: 44,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 1,
                                    color: const Color(0xFF343434),
                                  ),
                                  Transform.translate(
                                    offset: Offset(_sliderKnobX, 0),
                                    child: Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFFe63416),
                                        border: Border.all(
                                          color: const Color(0xFF343434),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(width: 1, color: const Color(0xFF343434)),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onPanUpdate: (d) => _handleJoyPan(d.localPosition),
                  onPanEnd: (_) => _handleJoyEnd(),
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1D1D1D),
                      border: Border.all(color: const Color(0xFF343434), width: 2),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.translate(
                          offset: _knobOffset,
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFe63416),
                              border: Border.all(
                                color: const Color(0xFF343434),
                                width: 1.5,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x55000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color(0xFFe63416),
        child: DrawerHeader(
          decoration: const BoxDecoration(
            color: Color(0xFFe63416),
          ),
          child: const Text(
            'Bluetooth Settings',
            style: TextStyle(
              color: Color(0xFF151515),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
