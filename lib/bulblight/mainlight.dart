import 'package:flutter/material.dart';
import 'package:yeedart/yeedart.dart';
import 'dart:io';
import 'package:capstone/backgroundimage.dart';


class MainLight extends StatefulWidget {
  const MainLight({Key? key}) : super(key: key);

  @override
  State<MainLight> createState() => _MainLightState();
}

class _MainLightState extends State<MainLight> {
  var _setBrightness = 50.0;
  var _setColor = 0xFFFFFF;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as BackgroundImages;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Room Light'),
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
                  const Text('Room Light', style: TextStyle(fontSize: 26, color: Colors.pink),),
                  Row(
                    children: [
                      Container(
                        height: 65,
                        width: 80,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text('ON', style: TextStyle(color: Colors.lightGreen),),
                          onPressed: () {
                            yeelightON();
                          },
                        ),
                      ),
                      Container(
                        height: 65,
                        width: 80,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text('OFF', style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            yeelightOFF();
                          },
                        ),
                      ),
                      Slider(
                          value: _setBrightness,
                          max: 100,
                          min: 0,
                          divisions: 10,
                          label: _setBrightness.round().toString(),
                          onChanged: (double val) {
                            _setBrightness = val;
                            setState(() {
                              yeelightBrightness();
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
                                _setColor = 0xFFFFFF;
                                setState(() {
                                  yeelightColor();
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
                                _setColor = 0xFF0000;
                                setState(() {
                                  yeelightColor();
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
                                _setColor = 0x000FF;
                                setState(() {
                                  yeelightColor();
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
                                _setColor = 0xFFFF00;
                                setState(() {
                                  yeelightColor();
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
                                _setColor = 0xFFE0F7FA;
                                setState(() {
                                  yeelightColor();
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
                                _setColor = 0x008000;
                                setState(() {
                                  yeelightColor();
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
  Future<void> yeelightON() async {
    final device = Device(
        address: InternetAddress('192.168.0.101'),
        port: 55443
    );

    await device.turnOn();
    await device.setRGB(
        color: _setColor,
        effect: const Effect.smooth(),
        duration: const Duration(milliseconds: 500)
    );
    await device.setBrightness(brightness: _setBrightness.toInt());
    device.disconnect();
  }

  Future<void> yeelightOFF() async {
    final device = Device(
        address: InternetAddress('192.168.0.101'),
        port: 55443
    );

    await device.turnOff();
    device.disconnect();
  }

  Future<void> yeelightBrightness() async {
    final device = Device(
        address: InternetAddress('192.168.0.101'),
        port: 55443
    );

    await device.setBrightness(brightness: _setBrightness.toInt());
    device.disconnect();
  }

  Future<void> yeelightColor() async {
    final device = Device(
        address: InternetAddress('192.168.0.101'),
        port: 55443
    );

    await device.setRGB(
        color: _setColor,
        effect: const Effect.smooth(),
        duration: const Duration(milliseconds: 500)
    );
    device.disconnect();
  }
}
