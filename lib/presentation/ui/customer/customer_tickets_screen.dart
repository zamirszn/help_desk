import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:helpdesk/app/functions.dart';
import 'package:helpdesk/data/models/ticket_model.dart';
import 'package:helpdesk/data/models/user_model.dart';
import 'package:helpdesk/presentation/resources/values_manager.dart';
import 'package:helpdesk/presentation/ticket_list.dart';

class CustomerTicketsScreen extends StatefulWidget {
  const CustomerTicketsScreen({super.key});

  @override
  _CustomerTicketsScreenState createState() => _CustomerTicketsScreenState();
}

class _CustomerTicketsScreenState extends State<CustomerTicketsScreen> {
  // Controllers for new ticket form
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  PlatformFile? attachment;

  // Function to pick a file (PDF, image, etc.)
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      setState(() {
        attachment = result.files.first;
      });
    }
  }

  // Function to create a new ticket
  void createTicket() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        appTickets.add(
          Ticket(
            ticketId: DateTime.now().toIso8601String(),
            customerName: userModel?.email ?? "",
            lastUpdatedOn: DateTime.now(),
            title: titleController.text,
            description: descriptionController.text,
            attachment: attachment,
          ),
        );
      });
      // Clear the fields
      titleController.clear();
      descriptionController.clear();
      attachment = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tickets'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Ticket List View
          Expanded(
            child: ListView.builder(
              itemCount: appTickets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(appTickets[index].title),
                  subtitle: Text(appTickets[index].description),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TicketDetailScreen(ticket: appTickets[index]),
                    ),
                  ),
                );
              },
            ),
          ),
          // Create New Ticket Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: const Text('Create New Ticket'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('New Ticket'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        space(h: AppSize.s40),
                        TextField(
                          controller: descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                        ),
                        space(h: AppSize.s40),
                        attachment != null
                            ? Text('File attached: ${attachment!.name}')
                            : Container(),
                        TextButton.icon(
                          icon: const Icon(Icons.attach_file),
                          label: const Text('Attach File'),
                          onPressed: pickFile,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Create'),
                        onPressed: () {
                          createTicket();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
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

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;

  TicketDetailScreen({super.key, required this.ticket});

  final TextEditingController noteController = TextEditingController();

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
            const Text(
              'Add Note:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Write a note'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (noteController.text.isNotEmpty) {
                  // Add note to ticket (this is a simple example)
                  // ticket.notes.add(noteController.text);
                  noteController.clear();
                }
              },
              child: const Text('Add Note'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ticket.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Note ${index + 1}'),
                    subtitle: Text(ticket.notes[index].text),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Model for a Ticket

