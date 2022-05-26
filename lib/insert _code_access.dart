import 'package:flutter/material.dart';

class InsertCodeAccess extends StatefulWidget {
  @override
  State<InsertCodeAccess> createState() => _InsertCodeAccessState();
}

class _InsertCodeAccessState extends State<InsertCodeAccess> {
  String codigo = "";

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Ingrese su codigo:"),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu codigo porfavor';
                          }
                          return null;
                        },
                        onSaved: (finalValue) {
                          codigo = finalValue!;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Barra creada con exito'),
                          ),
                        );

                        Navigator.pop(context, codigo.toUpperCase());
                      }
                    },
                    child: const Text('Generar Barra'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
