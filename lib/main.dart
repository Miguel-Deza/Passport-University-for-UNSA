import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:university_passport/insert _code_access.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'University Passport',
      theme: ThemeData(
          primarySwatch: Colors.teal, backgroundColor: Colors.tealAccent),
      home: const MyHomePage(title: 'Passport University'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String codigoUsuario = "";

  inicializador() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      codigoUsuario = prefs.getString('codigoUsuario') ?? "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializador();
  }

  void goToInsertCodeAccessPage() async {
    codigoUsuario = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InsertCodeAccess()),
    );

    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // set value
    await prefs.setString('codigoUsuario', codigoUsuario);

    setState(() {
      codigoUsuario;
    });
    print(codigoUsuario);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                // ClipRRect(
                //   child: ImageFiltered(
                //     imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                //     child: Image.asset(
                //       "assets/me.png",
                //       width: 300.0,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 50.0,
                ),
                const Text(
                  'Tu barra de acceso es:',
                ),
                BarcodeWidget(
                  barcode: Barcode.code39(),
                  data: codigoUsuario,
                  width: 300.0,
                  height: 70.0,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToInsertCodeAccessPage,
        child: const Icon(Icons.arrow_right_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
