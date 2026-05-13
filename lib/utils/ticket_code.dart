String generateTicketCode() {
  final now = DateTime.now();
  return "TKT-${now.millisecondsSinceEpoch}";
}