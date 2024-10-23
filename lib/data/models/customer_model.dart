class Customer {
  final String customerId;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime registeredOn;

  Customer({
    required this.customerId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.registeredOn,
  });

  // Helper method to format date for UI
  String get formattedRegistrationDate {
    return '${registeredOn.day}/${registeredOn.month}/${registeredOn.year}';
  }
}
