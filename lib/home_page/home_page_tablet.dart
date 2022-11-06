import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../model/providerrtdb.dart';
import '../widget/button.dart';
import '../widget/container_background.dart';

import '../widget/setpicker.dart';
import '../widget/sfcontainer.dart';
import '../widget/stauspoll.dart';

class HomePageTablet extends StatefulWidget {
  const HomePageTablet({Key? key}) : super(key: key);

  @override
  State<HomePageTablet> createState() => _HomePageTabletState();
}

class _HomePageTabletState extends State<HomePageTablet> {
  final _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ProviderRTDB>(
      builder: (context, data, child) {
        return data.datosProvider != null
            ? Center(
                child: Stack(
                  children: [
                    Positioned(
                      left: size.width * 0.021,
                      top: size.height * 0.014,
                      child: const ContainerBackgraund(
                        altura: 305,
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.04,
                      top: size.height * 0.04,
                      child: NeuButton(
                        cupertinoIcon: const IconData(0xf6cb,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage),
                        title: 'Hidro',
                        onTap: data.datosProvider!.status
                            ? () {
                                setState(
                                  () {
                                    _database
                                        .child(
                                            'disp${data.datosProvider!.disp}')
                                        .update({
                                      "pump": !data.datosProvider!.pump
                                    });
                                  },
                                );
                              }
                            : () {},
                        isButtonPressed: data.datosProvider!.pump,
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.04,
                      top: size.height * 0.23,
                      child: NeuButton(
                        cupertinoIcon: const IconData(0xf869,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage),
                        title: 'Bolhas',
                        onTap: data.datosProvider!.status
                            ? () {
                                setState(
                                  () {
                                    _database
                                        .child(
                                            'disp${data.datosProvider!.disp}')
                                        .update({
                                      "buble": !data.datosProvider!.buble
                                    });
                                  },
                                );
                              }
                            : () {},
                        isButtonPressed: data.datosProvider!.buble,
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.04,
                      top: size.height * 0.42,
                      child: NeuButton(
                        cupertinoIcon: const IconData(0xf864,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage),
                        title: 'Aquecedor',
                        onTap: data.datosProvider!.status
                            ? () {
                                setState(
                                  () {
                                    _database
                                        .child(
                                            'disp${data.datosProvider!.disp}')
                                        .update({
                                      "warm": !data.datosProvider!.warm
                                    });
                                  },
                                );
                              }
                            : () {},
                        isButtonPressed: data.datosProvider!.warm,
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.04,
                      top: size.height * 0.61,
                      child: NeuButton(
                        cupertinoIcon: const IconData(0xf4B6,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage),
                        title: 'Leds',
                        onTap: () {
                          setState(
                            () {
                              _database
                                  .child('disp${data.datosProvider!.disp}')
                                  .update({"leds": !data.datosProvider!.leds});
                            },
                          );
                        },
                        isButtonPressed: data.datosProvider!.leds,
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.19,
                      top: size.height * 0.04,
                      child: const SfContainer(
                        title: 'Temperatura',
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.23,
                      top: size.height * 0.18,
                      child: Column(
                        children: [
                          Text(
                            '${data.datosProvider!.temp / 100}°',
                            style: GoogleFonts.orbitron(
                                textStyle: const TextStyle(
                                    fontSize: 45.0, color: Colors.green)),
                          ),
                          Text(
                            'TempSet: ${data.datosProvider!.tempSetting}°',
                            style: const TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.50,
                      top: size.height * 0.04,
                      child: const SfContainer(
                        title: 'Control Panel',
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.52,
                      top: size.height * 0.14,
                      child: const StautusPoll(),
                    ),
                    Positioned(
                      left: size.width * 0.79,
                      top: size.height * 0.04,
                      child: const SetPicker(),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CupertinoActivityIndicator(),
              );
      },
    );
  }
}
