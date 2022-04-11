import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:capstone/backgroundimage.dart';

class CapstoneProj extends StatefulWidget {
  const CapstoneProj({Key? key}) : super(key: key);

  @override
  State<CapstoneProj> createState() => _CapstoneProjState();
}

class _CapstoneProjState extends State<CapstoneProj> {
  String dateNow = DateFormat('EEE, M/d/y').format(DateTime.now());
  BackgroundImages setOfImages = BackgroundImages();
  late String getImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                setOfImages.randomIndex();
              });
            },
            label: const Text('Refresh Images'),
            icon: const Icon(Icons.refresh),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          appBar: AppBar(
            leading: const Icon(Icons.add_business),
            title: const Text('Home Assistant', style: TextStyle(fontSize: 25, color: Colors.cyanAccent),),
          ),

          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(setOfImages.getImage()), fit: BoxFit.fill)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  height: 250,
                  width: 250,
                  child: const AnalogClock(
                    tickColor: Colors.white,
                    hourHandColor: Colors.white,
                    minuteHandColor: Colors.white,
                    digitalClockColor: Colors.white,
                    numberColor: Colors.white,
                    textScaleFactor: 1.5,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(dateNow, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Opacity(
                        opacity: 0.65,
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 150,
                            child: ElevatedButton(
                                onPressed: () async {
                                  await Navigator.pushNamed(
                                      context,
                                      '/mainlight',
                                      arguments: setOfImages
                                  );
                                },
                                child: const Text('Room Light', style: TextStyle(color: Colors.redAccent))
                            )
                        ),
                      ),
                    ),
                    Expanded(
                      child: Opacity(
                        opacity: 0.65,
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 150,
                            child: ElevatedButton(
                                onPressed: () async {
                                  await Navigator.pushNamed(
                                      context,
                                      '/readlight',
                                      arguments: setOfImages
                                  );
                                },
                                child: const Text('Reading Light', style: TextStyle(color: Colors.redAccent))
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Opacity(
                    opacity: 0.65,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 80,
                      width: 200,
                      child: ElevatedButton(
                        child: const Text('RBG LED Light', style: TextStyle(color: Colors.redAccent)),
                        onPressed: () async {
                          await Navigator.pushNamed(
                              context,
                              '/rgbLed',
                              arguments: setOfImages
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Opacity(
                          opacity: 0.65,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context,
                                    '/roomtemperature',
                                    arguments: setOfImages
                                );
                              },
                              child: const Text('Room Temperature', style: TextStyle(color: Colors.redAccent)),
                            ),
                          ),
                        )
                    ),
                    Expanded(
                        child: Opacity(
                          opacity: 0.65,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context,
                                    '/weatherforecast',
                                    arguments: setOfImages
                                );
                              },
                              child: const Text('Weather Forecast', style: TextStyle(color: Colors.redAccent)),
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}