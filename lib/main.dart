import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_anim/animated_card.dart';
import 'package:profile_anim/animated_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const appTitle = "Profile Animation";
  static const appBarTitle = "Profile Page";
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: appBarTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static const duration = Duration(milliseconds: 700);
  static const elevationDuration = Duration(milliseconds: 700);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  static const heightPercent = 0.2, widthPercent = 0.3;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: MyHomePage.duration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    // Gettings sizes from MediaQuery to achieve responsiveness
    final Size(:width, :height) = MediaQuery.sizeOf(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.title,
            style: GoogleFonts.cormorantUnicase(
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Stack(
              children: [
                AnimatedCard(
                  width: width * widthPercent,
                  height: height * heightPercent,
                  listenable: _animationController,
                ),
                AnimatedInfo(
                  width: width * widthPercent,
                  height: height * heightPercent,
                  listenable: _animationController,
                  userName: 'Khurram',
                  userEmail: 'naseemkhurram397@gmail.com',
                  userCompany: 'Building Big',
                  userDesignation: 'Founder & CEO',
                  userPhoneNo: '+923017731831',
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onTap,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.animation_sharp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
