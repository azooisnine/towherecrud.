enum StatusPembayaran { pending, confirmed, cancelled }

class Pembayaran {
  final String pembayaranId;
  final String bookingId;

  final String metodePembayaran; // card / wallet (wallet dummy)
  final DateTime tglPembayaran;

  final StatusPembayaran statusPembayaran;

  final double totalBayar;

  // CARD DATA
  final String namaPemilikCard;
  final String expiryDate;
  final String cvv;

  Pembayaran({
    required this.pembayaranId,
    required this.bookingId,
    required this.metodePembayaran,
    required this.tglPembayaran,
    required this.statusPembayaran,
    required this.totalBayar,
    required this.namaPemilikCard,
    required this.expiryDate,
    required this.cvv,
  });

  factory Pembayaran.fromMap(Map<String, dynamic> data, String id) {
    return Pembayaran(
      pembayaranId: id,
      bookingId: data['bookingId'],
      metodePembayaran: data['metodePembayaran'],
      tglPembayaran: DateTime.parse(data['tglPembayaran']),
      statusPembayaran: StatusPembayaran.values.firstWhere(
        (e) => e.name == data['statusPembayaran'],
        orElse: () => StatusPembayaran.pending,
      ),
      totalBayar: (data['totalBayar'] as num).toDouble(),
      namaPemilikCard: data['namaPemilikCard'],
      expiryDate: data['expiryDate'],
      cvv: data['cvv'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'metodePembayaran': metodePembayaran,
      'tglPembayaran': tglPembayaran.toIso8601String(),
      'statusPembayaran': statusPembayaran.name,
      'totalBayar': totalBayar,
      'namaPemilikCard': namaPemilikCard,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }
}