import 'package:file_picker/file_picker.dart';

class Note {
  String text;
  DateTime timestamp;
  String role;

  Note({
    required this.text,
    required this.timestamp,
    required this.role,
  });
}

class Ticket {
  String ticketId;
  String title;
  String description;
  String status;
  String customerName;
  DateTime lastUpdatedOn;
  PlatformFile? attachment;
  List<Note> notes = [];

  Ticket({
    required this.ticketId,
    required this.title,
    required this.description,
    required this.customerName,
    required this.lastUpdatedOn,
    this.attachment,
    this.status = 'Active', // Default status
  });
}
