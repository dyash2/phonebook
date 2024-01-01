import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/Groups/add_members_to_group.dart';
import 'package:contacts_app/controllers/crud_services.dart';
import 'package:contacts_app/views/update_contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  late Stream<QuerySnapshot> _stream;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchfocusNode = FocusNode();

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

  // Helper method to show a delete confirmation dialog
  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Group"),
          content: Text("Are you sure you want to delete this group?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Implement logic to delete the group
                // ...
                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  // Helper method to navigate to the screen for adding members
 void navigateToAddMembersScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMembersToGroupPage()),
    );
    // Process the result if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu item selection
              if (value == 'delete') {
                showDeleteConfirmationDialog();
              } else if (value == 'addMembers') {
                navigateToAddMembersScreen();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 8),
                    Text('Delete Group'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'addMembers',
                child: Row(
                  children: [
                    Icon(Icons.person_add),
                    SizedBox(width: 8),
                    Text('Add Members'),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
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
                  border: OutlineInputBorder(),
                  label: Text("Search"),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            _searchfocusNode.unfocus();
                            _stream = CRUDService().getContacts();
                            setState(() {});
                          },
                          icon: Icon(Icons.close),
                        )
                      : null,
                ),
              ),
            ),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width * 8, 80),
        ),
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: _stream,
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.hasError) {
      //       return Text("Something Went Wrong");
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: Text("Loading"),
      //       );
      //     }
      //     return snapshot.data!.docs.length == 0
      //         ? Center(
      //             child: Text("No Contacts Found ..."),
      //           )
      //         : ListView(
      //             children: snapshot.data!.docs
      //                 .map((DocumentSnapshot document) {
      //                   Map<String, dynamic> data =
      //                       document.data()! as Map<String, dynamic>;
      //                   return ListTile(
      //                     onTap: () => Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => UpdateContact(
      //                                 name: data["name"],
      //                                 phone: data["phone"],
      //                                 email: data["email"],
      //                                 docID: document.id))),
      //                     leading: CircleAvatar(child: Text(data["name"][0])),
      //                     title: Text(data["name"]),
      //                     subtitle: Text(data["phone"]),
      //                     trailing: IconButton(
      //                       icon: Icon(Icons.call),
      //                       onPressed: () {
      //                         callUser(data["phone"]);
      //                       },
      //                     ),
      //                   );
      //                 })
      //                 .toList()
      //                 .cast(),
      //           );
      //   },
      // ),
    );
  }
}
