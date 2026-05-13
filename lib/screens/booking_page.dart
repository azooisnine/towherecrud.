import 'package:flutter/material.dart';
import '../model/booking_model.dart';
import '../service/firestore_service.dart';
import '../screens/pembayaran_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() =>
      _BookingPageState();
}

class _BookingPageState
    extends State<BookingPage> {
  final FirestoreService firestore =
      FirestoreService();

  DateTime selectedDate = DateTime.now();

  String kotaAsal = 'Banjarbaru';
  String kotaTujuan = 'Banjarmasin';

  String kelas = 'standard';

  int seatNumber = 1;

  List<String> kotaList = [
    'Banjarbaru',
    'Banjarmasin',
  ];

  List<String> kelasList = [
    'standard',
    'business',
    'vip',
  ];

  // ================= PILIH TANGGAL =================
  void pilihTanggal() async {
    DateTime? date = await showDatePicker(
      context: context,

      initialDate: selectedDate,

      firstDate: DateTime.now(),

      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  // ================= BOOK NOW =================
  void bookNow() async {

    // VALIDASI KOTA
    if (kotaAsal == kotaTujuan) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Kota asal dan tujuan tidak boleh sama",
          ),

          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    final booking = Booking(
      bookingId: '',

      tgl: selectedDate,

      statusBooking:
          StatusBooking.pending,

      kotaAsal: kotaAsal,

      kotaTujuan: kotaTujuan,

      kelas: kelas == 'standard'
          ? ClassBus.standard
          : kelas == 'business'
              ? ClassBus.business
              : ClassBus.vip,

      seatNumber: seatNumber,

      busId: 'BUS_001',

      jamKeberangkatan: '08:00',

      totalHarga: 0,
    );

    // SIMPAN KE FIREBASE
    await firestore.addBooking(
      booking,
    );

    // PINDAH KE HALAMAN PAYMENT
    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) =>
            PembayaranPage(
          booking: booking,
        ),
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Book Your Ticket",
        ),

        backgroundColor:
            Colors.orangeAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ================= FROM =================
            DropdownButtonFormField(
              value: kotaAsal,

              items:
                  kotaList.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),

              onChanged: (val) {
                setState(() {
                  kotaAsal = val!;

                  // kalau sama otomatis ubah tujuan
                  if (kotaTujuan ==
                      kotaAsal) {
                    kotaTujuan =
                        kotaList.firstWhere(
                      (kota) =>
                          kota != kotaAsal,
                    );
                  }
                });
              },

              decoration:
                  const InputDecoration(
                labelText: "From",
              ),
            ),

            const SizedBox(height: 10),

            // ================= TO =================
            DropdownButtonFormField(
              value: kotaTujuan,

              items: kotaList
                  .where(
                    (kota) =>
                        kota != kotaAsal,
                  )
                  .map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),

              onChanged: (val) {
                setState(() {
                  kotaTujuan = val!;
                });
              },

              decoration:
                  const InputDecoration(
                labelText: "To",
              ),
            ),

            const SizedBox(height: 10),

            // ================= CLASS =================
            DropdownButtonFormField(
              value: kelas,

              items:
                  kelasList.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),

              onChanged: (val) {
                setState(() {
                  kelas = val!;
                });
              },

              decoration:
                  const InputDecoration(
                labelText:
                    "Choose Class",
              ),
            ),

            const SizedBox(height: 10),

            // ================= DATE =================
            Row(
              children: [
                Text(
                  "Date: ${selectedDate.toLocal()}"
                      .split(' ')[0],
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed:
                      pilihTanggal,

                  child: const Text(
                    "Pick Date",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ================= SEAT =================
            const Text(
              "Select Seat",
            ),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (seatNumber >
                        1) {
                      setState(() {
                        seatNumber--;
                      });
                    }
                  },

                  icon: const Icon(
                    Icons.remove,
                  ),
                ),

                Text(
                  seatNumber.toString(),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      seatNumber++;
                    });
                  },

                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ================= BUTTON =================
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: bookNow,

                child: const Text(
                  "BOOK NOW",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}