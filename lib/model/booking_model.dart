enum StatusBooking { pending, confirmed, cancelled }

enum ClassBus { standard, business, vip }

class Booking {
  final String bookingId;
  final DateTime tgl;
  final StatusBooking statusBooking;

  final String kotaAsal;
  final String kotaTujuan;

  final ClassBus kelas;
  final int seatNumber;

  final String busId;
  final String jamKeberangkatan;

  final double totalHarga;

  Booking({
    required this.bookingId,
    required this.tgl,
    required this.statusBooking,
    required this.kotaAsal,
    required this.kotaTujuan,
    required this.kelas,
    required this.seatNumber,
    required this.busId,
    required this.jamKeberangkatan,
    required this.totalHarga,
  });

  factory Booking.fromMap(Map<String, dynamic> data, String id) {
    return Booking(
      bookingId: id,
      tgl: DateTime.parse(data['tgl']),
      statusBooking: StatusBooking.values.firstWhere(
        (e) => e.name == data['statusBooking'],
      ),
      kotaAsal: data['kotaAsal'],
      kotaTujuan: data['kotaTujuan'],
      kelas: ClassBus.values.firstWhere((e) => e.name == data['kelas']),
      seatNumber: data['seatNumber'],
      busId: data['busId'],
      jamKeberangkatan: data['jamKeberangkatan'],
      totalHarga: (data['totalHarga'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tgl': tgl.toIso8601String(),
      'statusBooking': statusBooking.name,
      'kotaAsal': kotaAsal,
      'kotaTujuan': kotaTujuan,
      'kelas': kelas.name,
      'seatNumber': seatNumber,
      'busId': busId,
      'jamKeberangkatan': jamKeberangkatan,
      'totalHarga': totalHarga,
    };
  }
}