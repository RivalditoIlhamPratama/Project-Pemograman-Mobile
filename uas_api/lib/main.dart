import 'package:flutter/material.dart';
import 'package:uas_api/screens/todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { //mengembalikan widget yang akan ditampilkan di layar
    return MaterialApp( //widget utama yang menyediakan kerangka dasar untuk aplikasi Flutter
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith( // Mengatur tema visual untuk aplikasi
          appBarTheme: AppBarTheme( //AppBarTheme, ini maksudnya dapat menentukan berbagai properti 
                                    //seperti warna latar belakang, bayangan, teks, dan sebagainya untuk AppBar secara konsisten.
        color: Color.fromARGB(255, 233, 255, 93), //menentukan warna latar belakang AppBar
      )),
      home: TodoListPage(), //sebagai layar awal aplikasi. Artinya, 
                            //ketika aplikasi pertama kali dijalankan, tampilan yang akan muncul adalah tampilan dari TodoListPage.
    );
  }
}
