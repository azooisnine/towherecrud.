// screens/splash_screen.dart

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;
  bool showIntro = false;

  @override
  void initState() {
    super.initState();

    // Splash loading dulu
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showIntro = true;
      });

      _startAutoSlide();
    });
  }

  void _startAutoSlide() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentPage < 3) {
        currentPage++;

        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EBDD),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        child: showIntro
            ? Directionality(
                textDirection:
                    TextDirection.rtl, // bikin slide dari kanan ke kiri unik
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: _pageOne(),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: _pageTwo(),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: _pageThree(),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: _pageFour(),
                    ),
                  ],
                ),
              )
            : const _LoadingSplash(),
      ),
    );
  }

  // ================= PAGE 1 =================

  Widget _pageOne() {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            "assets/images/bus_inside.jpg",
            fit: BoxFit.cover,
          ),
        ),

        // blur
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.15),
          ),
        ),

        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),

              _ticketLogo(),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(
                        text: "Perjalanan yang\n",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: "nyaman dan\n",
                        style: TextStyle(color: Color(0xFFF7B75B)),
                      ),
                      TextSpan(
                        text: "tenang ",
                        style: TextStyle(color: Color(0xFFF7B75B)),
                      ),
                      TextSpan(
                        text: "dengan\nbeberapa\ntombol",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              _indicator(0),

              const Spacer(),

              _bottomWave(),
            ],
          ),
        ),
      ],
    );
  }

  // ================= PAGE 2 =================

  Widget _pageTwo() {
    return Stack(
      children: [
        Container(color: const Color(0xFFF2EBDD)),

        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),

              _ticketLogo(),

              const SizedBox(height: 30),

              Expanded(
                child: Column(
                  children: [
                    const Spacer(),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFA000),
                            shape: BoxShape.circle,
                          ),
                        ),

                        Image.asset(
                          "assets/images/bus_blue.png",
                          width: 320,
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "Harganya yang ",
                              style: TextStyle(
                                color: Color(0xFF008E8E),
                              ),
                            ),
                            TextSpan(
                              text: "murah dan\n",
                              style: TextStyle(
                                color: Color(0xFFF7B75B),
                              ),
                            ),
                            TextSpan(
                              text: "terpercaya",
                              style: TextStyle(
                                color: Color(0xFFF7B75B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    _indicator(1),

                    const Spacer(),
                  ],
                ),
              ),

              _bottomWave(),
            ],
          ),
        ),
      ],
    );
  }

  // ================= PAGE 3 =================

  Widget _pageThree() {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            "assets/images/bus_night.jpg",
            fit: BoxFit.cover,
          ),
        ),

        Container(
          color: Colors.deepPurple.withOpacity(0.3),
        ),

        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),

              _ticketLogo(),

              const SizedBox(height: 50),

              const Text(
                "to where boss?",
                style: TextStyle(
                  color: Color(0xFFFFC46B),
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              _indicator(2),

              const Spacer(),

              _bottomWave(),
            ],
          ),
        ),
      ],
    );
  }

  // ================= PAGE 4 =================

  Widget _pageFour() {
    return Stack(
      children: [
        Container(color: const Color(0xFFF2EBDD)),

        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 120),

              _ticketLogo(),

              const Spacer(),

              GestureDetector(
                onTap: () {
                  // pindah ke halaman login
                  // Navigator.pushReplacement(...)
                },
                child: Container(
                  width: 190,
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF008E8E),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(
                    child: Text(
                      "GET STARTED",
                      style: TextStyle(
                        color: Color(0xFF008E8E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              _bottomWave(),
            ],
          ),
        ),
      ],
    );
  }

  // ================= WIDGETS =================

  Widget _ticketLogo() {
    return Transform.rotate(
      angle: -0.8,
      child: Image.asset(
        "assets/images/ticket.png",
        width: 70,
      ),
    );
  }

  Widget _indicator(int active) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: active == index
                ? const Color(0xFF00A6A6)
                : const Color(0xFF00A6A6).withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _bottomWave() {
    return SizedBox(
      height: 170,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: const BoxDecoration(
                color: Color(0xFF008E8E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(180, 70),
                  topRight: Radius.elliptical(180, 70),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 25,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xFFF5D56B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(180, 60),
                  topRight: Radius.elliptical(180, 60),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 45,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFFF7B75B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(180, 50),
                  topRight: Radius.elliptical(180, 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= SPLASH LOADING =================

class _LoadingSplash extends StatefulWidget {
  const _LoadingSplash();

  @override
  State<_LoadingSplash> createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<_LoadingSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xFFF2EBDD),
        ),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                turns: controller,
                child: Transform.rotate(
                  angle: -0.8,
                  child: Image.asset(
                    "assets/images/ticket.png",
                    width: 70,
                  ),
                ),
              ),

              const SizedBox(height: 70),

              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: const AlwaysStoppedAnimation(
                    Color(0xFF00A6A6),
                  ),
                  backgroundColor:
                      const Color(0xFFF5D56B).withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const _WaveWidget(),
          ),
        ),
      ],
    );
  }
}

// ================= WAVE =================

class _WaveWidget extends StatelessWidget {
  const _WaveWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: const BoxDecoration(
                color: Color(0xFF008E8E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(180, 70),
                  topRight: Radius.elliptical(180, 70),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 25,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xFFF5D56B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(180, 60),
                  topRight: Radius.elliptical(180, 60),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 45,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFFF7B75B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(180, 50),
                  topRight: Radius.elliptical(180, 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}