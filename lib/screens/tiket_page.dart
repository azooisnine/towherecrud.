import 'package:flutter/material.dart';
import '../model/tiket_model.dart';

class TiketPage extends StatelessWidget {
  final Tiket tiket;

  const TiketPage({super.key, required this.tiket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Your Ticket"),
        backgroundColor: Colors.orangeAccent,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// BOOKING CODE
            Text(
              tiket.noTiket,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 20),

            _row("Route", tiket.rute),
            _row("Departure", tiket.departure),
            _row("Seat", tiket.seat.toString()),
            _row("Passenger", tiket.passengerName),
            _row("Total", "Rp ${tiket.total.toStringAsFixed(0)}"),

            const SizedBox(height: 25),

            /// QR CODE (DUMMY)
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: const Center(
                child: Text(
                  "QR CODE",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Your Ticket Can Be Check On Activity....",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            const Text(
              "Thank You!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}