import 'package:flutter/material.dart';
import 'booking_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Map<String, String>> scheduleList = [
    {
      "title": "Travelspeed",
      "route": "Banjarbaru - BanjarMasin",
      "time": "12:00 PM"
    },
    {
      "title": "Travelspeed",
      "route": "Banjarbaru - BanjarMasin",
      "time": "02:30 PM"
    },
    {
      "title": "Travelspeed",
      "route": "Banjarbaru - BanjarMasin",
      "time": "05:15 PM"
    },
  ];

  void goToBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BookingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E5C5B),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              // HEADER (dari design kamu)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "To Where.",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Book Your Ticket",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Fast & easy",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFFFFB21A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD166),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.confirmation_num_outlined,
                        color: Color(0xFF0E5C5B),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Divider(color: Colors.white54),
              ),

              const SizedBox(height: 34),

              // TITLE
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Book Ticket",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFEFC96D),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // HERO CARD + BOOK BUTTON (FIX LOGIC)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 610,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/bus.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(42),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.15),
                          Colors.black.withOpacity(0.55),
                          Colors.black.withOpacity(0.72),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 30),
                      child: Column(
                        children: [
                          const Spacer(),
                          const Text(
                            "“Life begins at the end of your\ncomfort zone.”",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 34),

                          GestureDetector(
                            onTap: goToBooking,
                            child: Container(
                              height: 72,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5B85F),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Text(
                                  "BOOK NOW",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 56),

              // SCHEDULE TITLE
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Today's Schedule",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFEFC96D),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // HORIZONTAL CARD (UI STYLE FULL)
              SizedBox(
                height: 210,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: scheduleList.map((item) {
                      return Container(
                        width: 310,
                        margin: const EdgeInsets.only(right: 18),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C8A8B),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white70,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.15),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Icon(Icons.directions_bus,
                                color: Colors.white),
                            const Spacer(),
                            Text(
                              item["time"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              item["route"]!,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),

      // BOTTOM NAVBAR (dari design kamu)
      bottomNavigationBar: Container(
        height: 92,
        decoration: const BoxDecoration(
          color: Color(0xFF202020),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
            topRight: Radius.circular(34),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_rounded, 0),
            _navItem(Icons.image_outlined, 1),
            _navItem(Icons.person_outline_rounded, 2),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final bool active = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: active ? 62 : 52,
        width: active ? 62 : 52,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF0AA8A8) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: active ? Colors.white : const Color(0xFF00AEB3),
        ),
      ),
    );
  }
}