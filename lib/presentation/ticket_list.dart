import 'package:helpdesk/data/models/ticket_model.dart';

List<Ticket> appTickets = [
  Ticket(
    ticketId: 'TCKT-001',
    title: 'Login Issue',
    description: 'Unable to login to the account using Google authentication.',
    customerName: 'John Doe',
    status: 'Active',
    lastUpdatedOn: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Ticket(
    ticketId: 'TCKT-002',
    title: 'App Crash on Payment',
    description:
        'The app crashes whenever I try to make a payment using a credit card.',
    customerName: 'Jane Smith',
    status: 'Pending',
    lastUpdatedOn: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
  ),
  Ticket(
    ticketId: 'TCKT-003',
    title: 'Unable to reset password',
    description:
        'The reset password link does not work. I am not receiving any email.',
    customerName: 'Robert Brown',
    status: 'Closed',
    lastUpdatedOn: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
  ),
  Ticket(
    ticketId: 'TCKT-004',
    title: 'Feature Request: Dark Mode',
    description:
        'Can you please add a dark mode feature to the app? It would help with visibility at night.',
    customerName: 'Emily White',
    status: 'Active',
    lastUpdatedOn: DateTime.now().subtract(const Duration(hours: 10)),
  ),
  Ticket(
    ticketId: 'TCKT-005',
    title: 'Error 404 on Profile Page',
    description: 'I get a 404 error whenever I try to visit the profile page.',
    customerName: 'Michael Green',
    status: 'Pending',
    lastUpdatedOn: DateTime.now().subtract(const Duration(days: 2, hours: 6)),
  ),
  Ticket(
    ticketId: 'TCKT-006',
    title: 'Duplicate Charges on Credit Card',
    description:
        'I have been charged twice for the same transaction. Please look into this.',
    customerName: 'Laura Blue',
    status: 'Closed',
    lastUpdatedOn: DateTime.now().subtract(const Duration(days: 4, hours: 3)),
  ),
];
