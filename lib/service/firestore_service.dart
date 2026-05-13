import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:towherecrud/model/booking_model.dart';
import 'package:towherecrud/model/pembayaran_model.dart';
import 'package:towherecrud/model/tiket_model.dart';

class FirestoreService {

  // ================= BOOKING =================
  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('booking');

  Future<void> addBooking(Booking booking) {
    return bookingCollection.add(booking.toMap());
  }

  Stream<List<Booking>> getBooking() {
    return bookingCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Booking.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  Future<void> updateBooking(String id, Booking booking) {
    return bookingCollection.doc(id).update(booking.toMap());
  }

  Future<void> deleteBooking(String id) {
    return bookingCollection.doc(id).delete();
  }

  // ================= PEMBAYARAN =================
  final CollectionReference pembayaranRef =
      FirebaseFirestore.instance.collection('pembayaran');

  Future<void> addPembayaran(Pembayaran pembayaran) {
    return pembayaranRef.add(pembayaran.toMap());
  }

// ================= TIKET =================
final CollectionReference tiketRef =
    FirebaseFirestore.instance.collection('tiket');

Future<void> addTiket(Tiket tiket) {
  return tiketRef.add({
    'tiketId': tiket.tiketId,
    'noTiket': tiket.noTiket,
    'bookingId': tiket.bookingId,
    'rute': tiket.rute,
    'departure': tiket.departure,
    'seat': tiket.seat,
    'kelas': tiket.kelas.toString(), // 🔥 penting biar aman
    'passengerName': tiket.passengerName,
    'total': tiket.total,
    'createdAt': DateTime.now(),
    'status': 'active',
  });
  }
}