import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yeedart/yeedart.dart';
import 'package:capstone/backgroundimage.dart';

class ReadingLight extends StatefulWidget {
  const ReadingLight({Key? key}) : super(key: key);

  @override
  State<ReadingLight> createState() => _ReadingLightState();
}

class _ReadingLightState extends State<ReadingLight> {
  var _setReadBrightness = 50.0;
  var _setReadColor = 0xFFFFFF;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as BackgroundImages;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Reading Light'),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(args.getImage()), fit: BoxFit.fill
                )
            ),
            child: Opacity(
              opacity: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Reading Light', style: TextStyle(fontSize: 26, color: Colors.pink)),
                  Row(
                    children: [
                      Container(
                        height: 65,
                        width: 80,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text('ON', style: TextStyle(color: Colors.lightGreen),),
                          onPressed: () {
                            yeelightReadON();
                          },
                        ),
                      ),
                      Container(
                        height: 65,
                        width: 80,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text('OFF', style: TextStyle(color: Colors.red),),
                          onPressed: () {
                            yeelightReadOFF();
                          },
                        ),
                      ),
                      Slider(
                          value: _setReadBrightness,
                          max: 100,
                          min: 0,
                          divisions: 10,
                          label: _setReadBrightness.round().toString(),
                          onChanged: (double val) {
                            _setReadBrightness = val;
                            setState(() {
                              yeelightReadBrightness();
                            });
                          })
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            height: 65,
                            padding: const EdgeInsets.all(2.5),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              child: const Text('White', style: TextStyle(color: Colors.black),),
                              onPressed: () {
                                _setReadColor = 0xFFFFFF;
                                setState(() {
                                  yeelightReadColor();
                                });
                              },
                            ),
                          )
                      ),
                      Expanded(
                          child: Container(
                            height: 65,
                            padding: const EdgeInsets.all(2.5),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                              ),
                              child: const Text('Red'),
                              onPressed: () {
                                _setReadColor = 0xFF0000;
                                setState(() {
                                  yeelightReadColor();
                                });
                              },
                            ),
                          )
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            height: 65,
                            padding: const EdgeInsets.all(2.5),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                              ),
                              child: const Text('Blue'),
                              onPressed: () {
                                _setReadColor = 0x000FF;
                                setState(() {
                                  yeelightReadColor();
                                });
                              },
                            ),
                          )
                      ),
                      Expanded(
                          child: Container(
                            height: 65,
                            padding: const EdgeInsets.all(2.5),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                              ),
                              child: const Text('Yellow', style: TextStyle(color: Colors.black),),
                              onPressed: () {
                                _setReadColor = 0xFFFF00;
                                setState(() {
                                  yeelightReadColor();
                                });
                              },
                            ),
                          )
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            height: 65,
                            padding: const EdgeInsets.all(2.5),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                              ),
                              child: const Text('Cyan'),
                              onPressed: () {
                                _setReadColor = 0x00FFFF;
                                setState(() {
                                  yeelightReadColor();
                                });
                              },
                            ),
                          )
                      ),
                      Expanded(
                          child: Container(
                            height: 65,
                            padding: const EdgeInsets.all(2.5),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                              ),
                              child: const Text('Green'),
                              onPressed: () {
                                _setReadColor = 0x008000;
                                setState(() {
                                  yeelightReadColor();
                                });
                              },
                            ),
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
  Future<void> yeelightReadON() async {
    final device = Device(
        address: InternetAddress('192.168.1.111'),
        port: 55443
    );

    await device.turnOn();
    await device.setRGB(
        color: _setReadColor,
        effect: const Effect.smooth(),
        duration: const Duration(milliseconds: 500)
    );
    await device.setBrightness(brightness: _setReadBrightness.toInt());
    device.disconnect();
  }

  Future<void> yeelightReadOFF() async {
    final device = Device(
        address: InternetAddress('192.168.1.111'),
        port: 55443
    );

    await device.turnOff();
    device.disconnect();
  }

  Future<void> yeelightReadBrightness() async {
    final device = Device(
        address: InternetAddress('192.168.1.111'),
        port: 55443
    );

    await device.setBrightness(brightness: _setReadBrightness.toInt());
    device.disconnect();
  }

  Future<void> yeelightReadColor() async {
    final device = Device(
        address: InternetAddress('192.168.1.111'),
        port: 55443
    );

    await device.setRGB(
        color: _setReadColor,
        effect: const Effect.smooth(),
        duration: const Duration(milliseconds: 500)
    );
    device.disconnect();
  }
}
