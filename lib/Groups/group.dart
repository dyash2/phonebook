import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/Groups/group_detail.dart';
import 'package:contacts_app/controllers/crud_services.dart';
import 'package:contacts_app/views/update_contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Group extends StatefulWidget {
  const Group({super.key});

  @override
  State<Group> createState() => _GrouppageState();
}

class _GrouppageState extends State<Group> {
  late Stream<QuerySnapshot> _stream;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchfocusNode = FocusNode();
  TextEditingController _groupNameController = TextEditingController();

  Map<String, bool> selectedContacts = {};

  @override
  void initState() {
    _stream = CRUDService().getContacts();
    super.initState();
  }

  @override
  void dispose() {
    _searchfocusNode.dispose();
    super.dispose();
  }

  // to call the contact using url launcher
  callUser(String phone) async {
    String url = "tel:$phone";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Could not launch $url ";
    }
  }

  // search Function to perform search
  searchContacts(String search) {
    _stream = CRUDService().getContacts(searchQuery: search);
  }
  // Function to handle contact selection
  void toggleContactSelection(String docId) {
    setState(() {
      selectedContacts[docId] = !(selectedContacts[docId] ?? false);
    });
  }

  void _showCreateGroupDialog() async {
  String? groupName = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Create Group'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(labelText: 'Group Name'),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              String groupName = _groupNameController.text;
              Navigator.of(context).pop(groupName); // Pass the group name to the caller
            },
            child: const Text('Create'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the AlertDialog
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );

  // Check if the user pressed "Create" and groupName is not null
  if (groupName != null && groupName.isNotEmpty) {
    // Navigate to the new screen and pass the group name
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDetailScreen(groupName: groupName),
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Groups")),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width * 8, 80),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: TextFormField(
                onChanged: (value) {
                  searchContacts(value);
                  setState(() {});
                },
                focusNode: _searchfocusNode,
                controller: _searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text("Search"),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            _searchfocusNode.unfocus();
                            _stream = CRUDService().getContacts();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateGroupDialog();
        },
        child: const Icon(Icons.person_add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading"),
            );
          }
          return snapshot.data!.docs.isEmpty
              ? const Center(
                  child: Text("No Contacts Found ..."),
                )
              : ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        String docId = document.id;

                        return LongPressDraggable(
                          data: docId,
                          feedback: ListTile(
                            title: Text(data["name"]),
                          ),
                          childWhenDragging: Container(),
                          onDragStarted: () {
                            // Start the drag operation
                            toggleContactSelection(docId);
                          },
                          onDragEnd: (details) {
                            // End the drag operation
                            toggleContactSelection(docId);
                          },
                          child: ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateContact(
                                  name: data["name"],
                                  phone: data["phone"],
                                  email: data["email"],
                                  docID: docId,
                                ),
                              ),
                            ),
                            leading: CircleAvatar(child: Text(data["name"][0])),
                            title: Text(data["name"]),
                            subtitle: Text(data["phone"]),
                            trailing: Checkbox(
                              value: selectedContacts[docId] ?? false,
                              onChanged: (value) {
                                toggleContactSelection(docId);
                              },
                            ),
                          ),
                        );
                      })
                      .toList()
                      .cast(),
                );
        },
      ),
    );
  }
}
