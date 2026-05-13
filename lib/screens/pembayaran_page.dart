import 'package:flutter/material.dart';
import '../service/firestore_service.dart';
import '../model/booking_model.dart';
import '../model/pembayaran_model.dart';
import '../model/tiket_model.dart';
import 'tiket_page.dart';

class PembayaranPage extends StatefulWidget {
  final Booking booking;

  const PembayaranPage({super.key, required this.booking});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final TextEditingController namaCard = TextEditingController();
  final TextEditingController cvv = TextEditingController();
  final FirestoreService firestore = FirestoreService();

  DateTime? expiryDate;

  String metode = 'card';
  bool loading = false;

  // ================= HARGA =================
  double get hargaTiket {
    switch (widget.booking.kelas.name) {
      case 'business':
        return 95000;
      case 'vip':
        return 135000;
      default:
        return 75000;
    }
  }

  double get adminFee => 5000;
  double get totalBayar => hargaTiket + adminFee;

  // ================= VALIDASI =================
  bool validateForm() {
    return namaCard.text.isNotEmpty &&
        cvv.text.length == 3 &&
        expiryDate != null;
  }

  // ================= TICKET CODE =================
  String generateTicketCode() {
    return "TKT-${DateTime.now().millisecondsSinceEpoch}";
  }

  // ================= EXPIRY PICKER =================
  void pickExpiry() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => expiryDate = picked);
    }
  }

  // ================= PAY NOW =================
  void payNow() async {
    if (!validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lengkapi semua data pembayaran"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      // ===== SAVE PAYMENT =====
      final pembayaran = Pembayaran(
        pembayaranId: '',
        bookingId: widget.booking.bookingId,
        metodePembayaran: metode,
        tglPembayaran: DateTime.now(),
        statusPembayaran: StatusPembayaran.confirmed,
        totalBayar: totalBayar,
        namaPemilikCard: namaCard.text,
        expiryDate: expiryDate!.toIso8601String(),
        cvv: cvv.text,
      );

      await firestore.addPembayaran(pembayaran);

      // ===== CREATE TICKET =====
      final tiket = Tiket(
        tiketId: '',
        noTiket: generateTicketCode(),
        bookingId: widget.booking.bookingId,
        rute:
            "${widget.booking.kotaAsal} → ${widget.booking.kotaTujuan}",
        departure: "08:00",
        seat: widget.booking.seatNumber,
        passengerName: namaCard.text,
        total: totalBayar,
        kelas: widget.booking.kelas.name,
      );

      await firestore.addTiket(tiket);

      setState(() => loading = false);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TiketPage(tiket: tiket),
        ),
      );
    } catch (e) {
      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final b = widget.booking;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.orangeAccent,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text("Metode Pembayaran",
                style: TextStyle(fontWeight: FontWeight.bold)),

            Row(
              children: [
                ChoiceChip(
                  label: const Text("Card"),
                  selected: metode == 'card',
                  onSelected: (_) => setState(() => metode = 'card'),
                ),
                const SizedBox(width: 10),
                const ChoiceChip(
                  label: Text("Wallet"),
                  selected: false,
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: namaCard,
              decoration: const InputDecoration(
                labelText: "Nama Pemilik Card",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: pickExpiry,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        expiryDate == null
                            ? "Expiry Date"
                            : expiryDate.toString().split(' ')[0],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: cvv,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "CVV",
                      counterText: "",
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text("Detail Booking",
                style: TextStyle(fontWeight: FontWeight.bold)),

            Text("Route: ${b.kotaAsal} → ${b.kotaTujuan}"),
            Text("Seat: ${b.seatNumber}"),
            Text("Class: ${b.kelas.name}"),
            Text("Date: ${b.tgl.toLocal()}".split(' ')[0]),

            const SizedBox(height: 20),

            const Text("Payment Summary",
                style: TextStyle(fontWeight: FontWeight.bold)),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Harga Tiket"),
                      Text("Rp ${hargaTiket.toStringAsFixed(0)}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Admin Fee"),
                      Text("Rp ${adminFee.toStringAsFixed(0)}"),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("TOTAL",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        "Rp ${totalBayar.toStringAsFixed(0)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : payNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.all(14),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("PAY NOW"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}