import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:provider/provider.dart';

import '../model/providerrtdb.dart';

class HorizonPicker extends StatefulWidget {
  const HorizonPicker({Key? key}) : super(key: key);

  @override
  State<HorizonPicker> createState() => _HorizonPickerState();
}

class _HorizonPickerState extends State<HorizonPicker> {
  final _database = FirebaseDatabase.instance.ref();

  var list = List<int>.generate(30, (i) => 15 + i);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ProviderRTDB>(builder: (context, data, child) {
      return data.datosProvider != null
          ? Container(
              padding: const EdgeInsets.only(top: 5),
              width: size.width * .9,
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade900),
                  color: Colors.black.withOpacity(.5),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  const Text(
                    'Set Temp',
                    style: TextStyle(color: Colors.green),
                  ),
                  HorizontalPicker(
                    backgroundColor: Colors.transparent,
                    activeItemTextColor: Colors.green,
                    suffix: ' °',
                    minValue: 15,
                    maxValue: 45,
                    divisions: 30,
                    height: 85,
                    onChanged: (value) {
                      setState(() {
                        _database
                            .child("disp${data.datosProvider!.disp}")
                            .update({"setTemp": value.toInt()});
                      });
                    },
                  ),
                ],
              ))
          : const Center(
              child: CupertinoActivityIndicator(),
            );
    });
  }
}
