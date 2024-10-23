import 'package:helpdesk/data/models/customer_model.dart';

List<Customer> appCustomers = [
  Customer(
    customerId: 'CUST-001',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phoneNumber: '+1234567890',
    registeredOn: DateTime.now().subtract(const Duration(days: 120)),
  ),
  Customer(
    customerId: 'CUST-002',
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    phoneNumber: '+1234567891',
    registeredOn: DateTime.now().subtract(const Duration(days: 98)),
  ),
  Customer(
    customerId: 'CUST-003',
    name: 'Robert Brown',
    email: 'robert.brown@example.com',
    phoneNumber: '+1234567892',
    registeredOn: DateTime.now().subtract(const Duration(days: 85)),
  ),
  Customer(
    customerId: 'CUST-004',
    name: 'Emily White',
    email: 'emily.white@example.com',
    phoneNumber: '+1234567893',
    registeredOn: DateTime.now().subtract(const Duration(days: 75)),
  ),
  Customer(
    customerId: 'CUST-005',
    name: 'Michael Green',
    email: 'michael.green@example.com',
    phoneNumber: '+1234567894',
    registeredOn: DateTime.now().subtract(const Duration(days: 60)),
  ),
  Customer(
    customerId: 'CUST-006',
    name: 'Laura Blue',
    email: 'laura.blue@example.com',
    phoneNumber: '+1234567895',
    registeredOn: DateTime.now().subtract(const Duration(days: 40)),
  ),
];
