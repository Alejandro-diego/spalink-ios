import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../responisive.dart';
import 'home_page_movil.dart';
import 'home_page_tablet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _database = FirebaseDatabase.instance.ref();
  final _dispController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 56.0),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: AppBar(
              title: Text(
                'SpaController',
                style: GoogleFonts.msMadi(
                  textStyle:
                      const TextStyle(color: Colors.redAccent, fontSize: 40.0),
                ),
              ),
              backgroundColor: Colors.white.withOpacity(.1),
              elevation: 0,
              actions: <Widget>[
                PopupMenuButton<int>(
                  onSelected: (item) => _OnSelected(context, item),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Row(
                        children: const [
                          Icon(Icons.logout),
                          Text(' LogOut'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: const [
                          Icon(Icons.broadcast_on_home),
                          Text(' Disp'),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('lib/image/spahome.png'),
          ),
        ),
        child: const Responsive(
          mobile: HomePageMovil(),
          tablet: HomePageTablet(),
          //   ipad: HomePageIpad(),
        ),
      ),
    );
  }

  void _dispN(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            backgroundColor: Colors.black.withOpacity(.5),
            actions: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.black,
                        content: Text(
                          'Salvando datos',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    );
                    _colocar();
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Guardar'),
              ),
            ],
            title: const Text('Dispositivo'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(),
                      labelText: 'Dispositivo',
                    ),
                    keyboardType: TextInputType.number,
                    controller: _dispController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese Dispositivo';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _colocar() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    setState(
      () {
        preference.setString('disp', _dispController.text);

        _database.child('disp${_dispController.text}').update(
          {
            'disp': _dispController.text,
          },
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  void _OnSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        FirebaseAuth.instance.signOut();
        break;
      case 1:
        _dispN(context);
        break;
    }
  }
}
