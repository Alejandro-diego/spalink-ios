import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../model/providerrtdb.dart';
import '../widget/button.dart';
import '../widget/container_background.dart';
import '../widget/horizont_picker.dart';
import '../widget/sfcontainer.dart';
import '../widget/stauspoll.dart';

class HomePageMovil extends StatefulWidget {
  const HomePageMovil({Key? key}) : super(key: key);

  @override
  State<HomePageMovil> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageMovil> {
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
                      top: size.height * 0.018,
                      child: const ContainerBackgraund(
                        altura: 550,
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.05,
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
                      left: size.width * 0.05,
                      top: size.height * 0.15,
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
                      left: size.width * 0.05,
                      top: size.height * 0.26,
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
                      left: size.width * 0.05,
                      top: size.height * 0.37,
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
                        right: size.width * 0.05,
                        top: size.height * 0.50,
                        child: const HorizonPicker()),
                    Positioned(
                      left: size.width * 0.36,
                      top: size.height * 0.04,
                      child: const SfContainer(
                        title: 'Temperatura',
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.39,
                      top: size.height * 0.09,
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
                      left: size.width * 0.36,
                      top: size.height * 0.27,
                      child: const SfContainer(
                        title: 'Control Panel',
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.38,
                      top: size.height * 0.31,
                      child: const StautusPoll(),
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
