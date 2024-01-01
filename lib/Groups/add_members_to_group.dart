import 'package:flutter/material.dart';

class AddMembersToGroupPage extends StatefulWidget {
  @override
  _AddMembersToGroupPageState createState() => _AddMembersToGroupPageState(contacts: []);
}

class _AddMembersToGroupPageState extends State<AddMembersToGroupPage> {
  List<String> contacts;
  List<String> selectedContacts = [];

  _AddMembersToGroupPageState({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Members to Group"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Implement logic to add selected contacts to the group
              // For example, update the database or perform any necessary action
              Navigator.pop(context, selectedContacts);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact),
            trailing: Checkbox(
              value: selectedContacts.contains(contact),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    selectedContacts.add(contact);
                  } else {
                    selectedContacts.remove(contact);
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}