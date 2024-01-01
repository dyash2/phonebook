// create_group.dart

import 'package:flutter/material.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter Group Name:"),
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                hintText: "Group Name",
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save the new group name and update UI
                Navigator.pop(context, _groupNameController.text);
              },
              child: Text("Create Group"),
            ),
          ],
        ),
      ),
    );
  }
}
