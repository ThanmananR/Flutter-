import 'package:flutter/material.dart';

void main() => runApp(Friend3App());

class Friend3App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentManagement3(),
    );
  }
}

class StudentManagement3 extends StatefulWidget {
  @override
  _StudentManagement3State createState() => _StudentManagement3State();
}

class _StudentManagement3State extends State<StudentManagement3> {
  List<Map<String, String>> students = [];

  final nameCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final bloodCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final parentCtrl = TextEditingController();

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Student Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildField(nameCtrl, "Name"),
            buildField(dobCtrl, "Date of Birth"),
            buildField(bloodCtrl, "Blood Group"),
            buildField(addressCtrl, "Address"),
            buildField(parentCtrl, "Parent Name"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: addStudent,
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void addStudent() {
    List<String> empty = [];

    if (nameCtrl.text.isEmpty) empty.add("Name");
    if (dobCtrl.text.isEmpty) empty.add("Date of Birth");
    if (bloodCtrl.text.isEmpty) empty.add("Blood Group");
    if (addressCtrl.text.isEmpty) empty.add("Address");
    if (parentCtrl.text.isEmpty) empty.add("Parent Name");

    if (empty.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Missing Fields"),
          content: Text("Fill: ${empty.join(', ')}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      students.add({
        "name": nameCtrl.text,
        "dob": dobCtrl.text,
        "blood": bloodCtrl.text,
        "address": addressCtrl.text,
        "parent": parentCtrl.text,
      });
    });

    clearFields();
    Navigator.pop(context);
  }

  void clearFields() {
    nameCtrl.clear();
    dobCtrl.clear();
    bloodCtrl.clear();
    addressCtrl.clear();
    parentCtrl.clear();
  }

  Widget buildField(TextEditingController ctrl, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STUDENT MANAGEMENT SYSTEM"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: students.isEmpty
          ? Center(child: Text("No Students Details Added"))
          : ListView(
              children: students.asMap().entries.map((entry) {
                final i = entry.key;
                final s = entry.value;

                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.orange[50],
                  child: ExpansionTile(
                    title: Text(
                      s["name"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ListTile(
                        title: Text("Date of Birth: ${s["dob"]}"),
                      ),
                      ListTile(
                        title: Text("Blood Group: ${s["blood"]}"),
                      ),
                      ListTile(
                        title: Text("Address: ${s["address"]}"),
                      ),
                      ListTile(
                        title: Text("Parent Name: ${s["parent"]}"),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() => students.removeAt(i));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
