class Tiket {
  final String tiketId;
  final String noTiket;
  final String bookingId;

  final String rute;
  final String departure;
  final int seat;
  final String passengerName;
  final double total;
  final String kelas;

  Tiket({
    required this.tiketId,
    required this.noTiket,
    required this.bookingId,
    required this.rute,
    required this.departure,
    required this.seat,
    required this.passengerName,
    required this.total,
    required this.kelas,
  });
}