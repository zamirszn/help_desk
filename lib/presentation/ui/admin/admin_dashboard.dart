import 'package:flutter/material.dart';
import 'package:helpdesk/data/models/customer_model.dart';
import 'package:helpdesk/data/models/ticket_model.dart';
import 'package:helpdesk/presentation/customers.dart';
import 'package:helpdesk/presentation/ticket_list.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({
    super.key,
  });

  @override
  AdminDashboardScreenState createState() => AdminDashboardScreenState();
}

class AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String selectedFilter = 'All';
  final List<Ticket> allTickets = appTickets;
  final List<Customer> allCustomers = appCustomers;

  // Method to filter tickets based on the selected status filter
  List<Ticket> get filteredTickets {
    if (selectedFilter == 'All') {
      return allTickets;
    } else {
      return allTickets
          .where((ticket) => ticket.status == selectedFilter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Admin Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Section (Stats)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Tickets', allTickets.length),
                _buildStatCard('Customers', allCustomers.length),
              ],
            ),
          ),
          // Filter Dropdown for Tickets
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedFilter,
              items: ['All', 'Active', 'Pending', 'Closed']
                  .map((filter) => DropdownMenuItem(
                        value: filter,
                        child: Text(filter),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                });
              },
            ),
          ),
          // Tickets List View
          Expanded(
            child: ListView.builder(
              itemCount: filteredTickets.length,
              itemBuilder: (context, index) {
                final ticket = filteredTickets[index];
                return ListTile(
                  title: Text('${ticket.ticketId}: ${ticket.title}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer: ${ticket.customerName}'),
                      Text('Status: ${ticket.status}'),
                      Text(
                          'Last Updated On: ${ticket.lastUpdatedOn.toLocal()}'),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminTicketDetailScreen(
                        ticket: ticket,
                        onUpdateStatus: (newStatus) {
                          setState(() {
                            ticket.status = newStatus;
                            ticket.lastUpdatedOn = DateTime.now();
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method to build stat cards for overview section
  Widget _buildStatCard(String title, int count) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('$count', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

class AdminTicketDetailScreen extends StatelessWidget {
  final Ticket ticket;
  final Function(String) onUpdateStatus;

  const AdminTicketDetailScreen({
    super.key,
    required this.ticket,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Ticket Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ticket ID: ${ticket.ticketId}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Customer: ${ticket.customerName}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Description:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(ticket.description),
            const SizedBox(height: 16),
            ticket.attachment != null
                ? Text('Attached File: ${ticket.attachment!.name}')
                : Container(),
            const SizedBox(height: 16),
            Text('Current Status: ${ticket.status}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: ticket.status,
              items: ['Active', 'Pending', 'Closed']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (newStatus) {
                if (newStatus != null) {
                  onUpdateStatus(newStatus);
                }
              },
            ),
            const SizedBox(height: 16),
            Text('Last Updated: ${ticket.lastUpdatedOn.toLocal()}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
