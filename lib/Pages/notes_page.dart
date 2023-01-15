import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_notes/All_Route/route_name.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_fire_notes/utils/toast.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final databaseRef = FirebaseDatabase.instance.ref('Notes');
  final auth = FirebaseAuth.instance;
  var _titleController = TextEditingController();
  var _descController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 98, 131, 207),
            Color.fromARGB(255, 16, 35, 71),
          ])),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 98, 131, 207),
              Color.fromARGB(255, 16, 35, 71),
            ])),
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showMyDialog();
              },
              child: Icon(Icons.add),
              backgroundColor: Color.fromARGB(255, 98, 131, 207),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BubbleBottomBar(
                backgroundColor: Color.fromARGB(255, 98, 131, 207),
                hasNotch: true,
                fabLocation: BubbleBottomBarFabLocation.end,
                opacity: .2,
                currentIndex: currentIndex,
                onTap: changePage,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ), //border radius doesn't work when the notch is enabled.
                elevation: 8,
                tilesPadding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                items: <BubbleBottomBarItem>[
                  BubbleBottomBarItem(
                    backgroundColor: Color.fromARGB(255, 98, 131, 207),
                    icon: Icon(
                      Icons.dashboard,
                      color: Colors.black,
                    ),
                    activeIcon: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  BubbleBottomBarItem(
                      backgroundColor: Color.fromARGB(255, 98, 131, 207),
                      icon: Icon(
                        Icons.access_time,
                        color: Colors.black,
                      ),
                      activeIcon: Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      title:
                          Text("Logs", style: TextStyle(color: Colors.white))),
                  BubbleBottomBarItem(
                      backgroundColor: Color.fromARGB(255, 98, 131, 207),
                      icon: Icon(
                        Icons.folder_open,
                        color: Colors.black,
                      ),
                      activeIcon: Icon(
                        Icons.folder_open,
                        color: Colors.white,
                      ),
                      title: Text("Folders",
                          style: TextStyle(color: Colors.white))),
                  BubbleBottomBarItem(
                      backgroundColor: Color.fromARGB(255, 98, 131, 207),
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      activeIcon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      title:
                          Text("Menu", style: TextStyle(color: Colors.white)))
                ]),
            backgroundColor: Colors.transparent,
            body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notes',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Poppins',
                                  color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                auth.signOut().then((value) {
                                  Navigator.pushReplacementNamed(
                                      context, RouteName.loginpage);
                                  Toast()
                                      .FlutterToastShow('Succesfully Logout');
                                }).onError((error, stackTrace) {
                                  Toast().FlutterToastShow(error.toString());
                                });
                              },
                              child: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 8,
                        child: FirebaseAnimatedList(
                          defaultChild:
                              Center(child: CircularProgressIndicator()),
                          query: databaseRef,
                          itemBuilder: (context, snapshot, animation, index) {
                            final title =
                                snapshot.child('Title').value.toString();
                            final desc =
                                snapshot.child('Description').value.toString();
                            final id = snapshot.child('Id').value.toString();
                            return Container(
                              margin: EdgeInsets.only(bottom: 12),
                              height: 100,
                              width: MediaQuery.of(context).size.width * 2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 16, 35, 71),
                                        blurRadius: 5,
                                        offset: Offset(0, 5))
                                  ]),
                              child: ListTile(
                                trailing: PopupMenuButton(
                                  icon: Icon(Icons.more_vert,
                                      size: 26, color: Colors.purple),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                          value: '1',
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.pop(context);
                                              showUpdateDialog(title, desc, id);
                                            },
                                            leading: Icon(Icons.edit),
                                            title: Text('Edit'),
                                          )),
                                      PopupMenuItem(
                                          value: '2',
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.pop(context);
                                              showDeleteDialog(id);
                                            },
                                            leading: Icon(Icons.delete),
                                            title: Text('Delete'),
                                          ))
                                    ];
                                  },
                                ),
                                title: Text(
                                    snapshot.child('Title').value.toString()),
                                subtitle: Text(snapshot
                                    .child('Description')
                                    .value
                                    .toString()),
                              ),
                            );
                          },
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Future showDeleteDialog(String id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100,
            width: 100,
            child: Column(
              children: [
                Expanded(
                    child:
                        Image(image: AssetImage('assets/images/delete.jpg'))),
                Expanded(child: Text('Sure to delete this note? '))
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  databaseRef.child(id).remove().then((value) {
                    Toast().FlutterToastShow('Post Deleted');
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    Navigator.pop(context);
                    Toast().FlutterToastShow(error.toString());
                  });
                },
                child: Text('Delete'))
          ],
        );
      },
    );
  }

  Future showUpdateDialog(String title, String desc, String id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text('Update Notes'),
              titleTextStyle: TextStyle(
                  fontSize: 22, color: Colors.white, fontFamily: 'Poppins'),
              alignment: Alignment.center,
              backgroundColor: Color.fromARGB(255, 98, 131, 207),
              content: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width * 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextFormField(
                                controller: _titleController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: 'Title.....',
                                    hintStyle: TextStyle(color: Colors.black)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter title first';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextFormField(
                                maxLines: 4,
                                controller: _descController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: 'Description.....',
                                    hintStyle: TextStyle(color: Colors.black)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter description first';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      databaseRef.child(id).update({
                        'Title': _titleController.text.toString(),
                        'Description': _descController.text.toString(),
                      }).then((value) {
                        Toast().FlutterToastShow('Post Updated');
                        Navigator.pop(context);
                        _descController.clear();
                        _titleController.clear();
                      }).onError((error, stackTrace) {
                        Toast().FlutterToastShow(error.toString());
                      });
                    }
                  },
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        });
  }

  Future showMyDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text('Add Notes'),
              titleTextStyle: TextStyle(
                  fontSize: 22, color: Colors.white, fontFamily: 'Poppins'),
              alignment: Alignment.center,
              backgroundColor: Color.fromARGB(255, 98, 131, 207),
              content: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width * 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextFormField(
                                controller: _titleController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: 'Title',
                                    hintStyle: TextStyle(color: Colors.black)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter title first';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextFormField(
                                maxLines: 4,
                                controller: _descController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: 'Description',
                                    hintStyle: TextStyle(color: Colors.black)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter description first';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      final id =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      databaseRef.child(id).set({
                        'Id': id,
                        'Title': _titleController.text.toString(),
                        'Description': _descController.text.toString(),
                      }).then((value) {
                        Toast().FlutterToastShow('Notes Added');
                        _descController.clear();
                        _titleController.clear();
                        Navigator.of(context).pop();
                      }).onError((error, stackTrace) {
                        Toast().FlutterToastShow(error.toString());
                      });
                    }
                  },
                  child: Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        });
  }
}
