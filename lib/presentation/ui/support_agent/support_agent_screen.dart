import 'package:flutter/material.dart';
import 'package:helpdesk/core/constants/constant.dart';
import 'package:helpdesk/data/models/ticket_model.dart';
import 'package:helpdesk/presentation/ticket_list.dart';

class SupportAgentScreen extends StatefulWidget {
  const SupportAgentScreen({
    super.key,
  });

  @override
  SupportAgentScreenState createState() => SupportAgentScreenState();
}

class SupportAgentScreenState extends State<SupportAgentScreen> {
  String selectedFilter = 'All';

  // Method to filter and sort tickets
  List<Ticket> get filteredAndSortedTickets {
    // Filter tickets based on the selected status
    List<Ticket> filteredTickets;
    if (selectedFilter == 'All') {
      filteredTickets = appTickets;
    } else {
      filteredTickets = appTickets
          .where((ticket) => ticket.status == selectedFilter)
          .toList();
    }

    // Sort tickets by "Last Updated On" in descending order (newest first)
    filteredTickets.sort((a, b) => b.lastUpdatedOn.compareTo(a.lastUpdatedOn));

    return filteredTickets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Support DashBoard'),
      ),
      body: Column(
        children: [
          // Filter Dropdown
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
              itemCount: filteredAndSortedTickets.length,
              itemBuilder: (context, index) {
                final ticket = filteredAndSortedTickets[index];
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
                      builder: (context) => SupportTicketDetailScreen(
                        ticket: ticket,
                        onUpdateStatus: (newStatus) {
                          setState(() {
                            ticket.status = newStatus;
                            ticket.lastUpdatedOn = DateTime.now();
                          });
                        },
                        onAddReply: (noteText, role) {
                          setState(() {
                            ticket.notes.add(
                              Note(
                                text: noteText,
                                timestamp: DateTime.now(),
                                role: role,
                              ),
                            );
                            ticket.lastUpdatedOn =
                                DateTime.now(); // Update last updated on
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
}

class SupportTicketDetailScreen extends StatelessWidget {
  final Ticket ticket;
  final Function(String) onUpdateStatus;
  final Function(String, String) onAddReply;

  SupportTicketDetailScreen({
    super.key,
    required this.ticket,
    required this.onUpdateStatus,
    required this.onAddReply,
  });

  final TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(ticket.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ticket ID: ${ticket.ticketId}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Customer: ${ticket.customerName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(ticket.description),
            const SizedBox(height: 16),
            ticket.attachment != null
                ? Text('Attached File: ${ticket.attachment!.name}')
                : Container(),
            const SizedBox(height: 16),
            Text(
              'Current Status: ${ticket.status}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
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
            const Text(
              'Add Reply:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: replyController,
              decoration: const InputDecoration(labelText: 'Write a reply'),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: Constant.support,
              items: [Constant.user, Constant.support, Constant.admin]
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (newRole) {
                if (newRole != null) {
                  Constant.support = newRole;
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (replyController.text.isNotEmpty) {
                  onAddReply(replyController.text, Constant.support);
                  replyController.clear();
                }
              },
              child: const Text('Add Reply'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Notes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ticket.notes.length,
                itemBuilder: (context, index) {
                  final note = ticket.notes[index];
                  return ListTile(
                    title: Text('${note.role} - ${note.timestamp.toLocal()}'),
                    subtitle: Text(note.text),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
