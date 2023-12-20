import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget { //mendefinisikan stateful widget AddTodoPage. Widget ini menerima parameter opsional todo yang dapat berisi data tugas (todo) yang akan diedit.
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState(); // mendeklarasikan metode yang membuat state terkait dengan widget ini. Di sini, createState membuat dan mengembalikan instance dari _AddTodoPageState.
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    // Todo: Implement initstate
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      // prefill edit form
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Data ' : 'Input Data',
          style: TextStyle(
            color: Colors.black, // Ganti warna sesuai keinginan Anda
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),  //Input dataaa / tambah data
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Nama'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'NIM'),
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 240, 254, 174)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                isEdit ? 'Update' : 'Simpan',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    // mendapatkan data dari form
    final todo = widget.todo;
    if (todo == null) {
      print('Anda tidak dapat memperbarui data');
      return;
    }
    final id = todo['_id'];
    final is_Completed = todo['Selesai'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    // menyimpan data ke server
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    // menampilkan berhasil atau tidaknya berdasarkan status
    if (response.statusCode == 200) {
      showSuccessMessage('Update Success');
    } else {
      showErrorMessage('Failed');
    }
  }

  // membuat fungsi simpan
  Future<void> submitData() async {
    // mendapatkan data dari form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    // menyimpan data ke server
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    // menampilkan berhasil atau tidaknya berdasarkan status
    if (response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage('Success');
    } else {
      showErrorMessage('Failed');
    }
  }

  // api respon reaction
  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
