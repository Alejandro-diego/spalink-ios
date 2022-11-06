import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/providerrtdb.dart';

class StautusPoll extends StatefulWidget {
  const StautusPoll({Key? key}) : super(key: key);

  @override
  State<StautusPoll> createState() => _StautusPollState();
}

class _StautusPollState extends State<StautusPoll> {
  final _database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderRTDB>(builder: (context, data, child) {
      return data.datosProvider != null
          ? SizedBox(
              width: 180,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(3),
                    height: 26,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[900]!.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        'Disp: ${data.datosProvider!.disp}',
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    height: 26,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[900]!.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          const Text(
                            'Estado :',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                          data.datosProvider!.status
                              ? const Text(
                                  'Cheia',
                                  style: TextStyle(color: Colors.green),
                                )
                              : const Text(
                                  'Vazia',
                                  style: TextStyle(color: Colors.green),
                                )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[900]!.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          data.datosProvider!.valve
                              ? const Text(
                                  'Enchendo',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                )
                              : const Text(
                                  'Ligar valvula',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                          CupertinoSwitch(
                              value: data.datosProvider!.valve,
                              onChanged: (bool a1) {
                                setState(() {
                                  _database
                                      .child('disp${data.datosProvider!.disp}')
                                      .update({
                                    'valve': a1,
                                  });
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CupertinoActivityIndicator(),
            );
    });
  }
}
