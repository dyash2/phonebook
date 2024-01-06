import 'package:flutter/material.dart';

class ImportContactsPage extends StatelessWidget {
  final Map<String, bool> selectedContacts;

  const ImportContactsPage({Key? key, required this.selectedContacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Contacts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Imported Contacts:'),
          const SizedBox(height: 20),
          // Display the selected contacts here
          ListView.builder(
            shrinkWrap: true,
            itemCount: selectedContacts.length,
            itemBuilder: (context, index) {
              var contact = selectedContacts.entries.elementAt(index);
              return ListTile(
                title: Text(contact.key),
              );
            },
          ),
        ],
      ),
    );
  }
}
