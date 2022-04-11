import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:capstone/backgroundimage.dart';

class RGBLed extends StatefulWidget {
  const RGBLed({Key? key}) : super(key: key);

  @override
  State<RGBLed> createState() => _RGBLedState();
}

class _RGBLedState extends State<RGBLed> {

  @override
  void initState() {
    super.initState();
    getInitLedState(); // Getting initial state of LED, which is by default on
  }
  String _status = '';
  String _blueStatus = '';
  String _redStatus = '';
  String _greenStatus = '';

  var blueIcon = Icons.lightbulb;
  var redIcon = Icons.lightbulb;
  var greenIcon = Icons.lightbulb;
  var ledColor = Colors.white;

  String url =
      'http://192.168.1.200:80/'; //IP Address which is configured in NodeMCU Sketch
  var response;

  getInitLedState() async {
    try {
      response = await http.get(Uri.parse(url), headers: {"Accept": "plain/text"});
      setState(() {
        _status = 'On';
      });
    } catch (e) {
      // If NodeMCU is not connected, it will throw error
      print(e);
      if (this.mounted) {
        setState(() {
          _status = 'Not Connected';
        });
      }
    }
  }

  toggleBlue() async {
    try {
      response = await http.get(Uri.parse(url + 'blue'), headers: {"Accept": "plain/text"});
      setState(() {
        _blueStatus = response.body;
        print(response.body);
      });
    } catch (e) {
      // If NodeMCU is not connected, it will throw error
      print(e);
    }
  }

  toggleRed() async {
    try {
      response = await http.get(Uri.parse(url + 'red'), headers: {"Accept": "plain/text"});
      setState(() {
        _redStatus = response.body;
        print(response.body);
      });
    } catch (e) {
      // If NodeMCU is not connected, it will throw error
      print(e);
    }
  }

  toggleGreen() async {
    try {
      response = await http.get(Uri.parse(url + 'green'), headers: {"Accept": "plain/text"});
      setState(() {
        _greenStatus = response.body;
        print(response.body);
      });
    } catch (e) {
      // If NodeMCU is not connected, it will throw error
      print(e);
    }
  }

  _colorDisplay() {
    if(_blueStatus == 'On' && _redStatus == 'On' && _greenStatus == 'Off') {
      setState(() {
        ledColor = Colors.purpleAccent;
      });
    }else if(_blueStatus == 'On' && _redStatus == 'Off' && _greenStatus == 'On') {
      setState(() {
        ledColor = Colors.cyan;
      });
    }else if(_blueStatus == 'Off' && _redStatus == 'On' && _greenStatus == 'On') {
      setState(() {
        ledColor = Colors.yellow;
      });
    }else if(_blueStatus == 'Off' && _redStatus == 'Off' && _greenStatus == 'On') {
      setState(() {
        ledColor = Colors.green;
      });
    }else if(_blueStatus == 'Off' && _redStatus == 'On' && _greenStatus == 'Off') {
      setState(() {
        ledColor = Colors.red;
      });
    }else if(_blueStatus == 'On' && _redStatus == 'Off' && _greenStatus == 'Off') {
      setState(() {
        ledColor = Colors.blue;
      });
    }else {
      ledColor = Colors.white;
    }
    return ledColor;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as BackgroundImages;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('RBG LED Light Control'),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(args.getImage()), fit: BoxFit.fill
                )
            ),
            child: Center(
              child: Opacity(
                opacity: 0.65,
                child: Container(
                  height: 300,
                  width: 300,
                  color: ledColor,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            await toggleBlue();
                            _colorDisplay();
                            setState(()  {
                              if(_blueStatus == 'Off') {
                                blueIcon = Icons.lightbulb_outline;
                              }else {
                                blueIcon = Icons.lightbulb;
                              }
                            });
                          },
                          child: ListTile(
                            title: const Text('Toggle Blue LED'),
                            trailing:Icon(blueIcon),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            await toggleRed();
                            _colorDisplay();
                            setState(() {
                              if(_redStatus == 'Off') {
                                redIcon = Icons.lightbulb_outline;
                              }else {
                                redIcon = Icons.lightbulb;
                              }
                            });
                          },
                          child: ListTile(
                            title: const Text('Toggle Red LED'),
                            trailing:Icon(redIcon),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            await toggleGreen();
                            _colorDisplay();
                            setState(() {
                              if(_greenStatus == 'Off') {
                                greenIcon = Icons.lightbulb_outline;
                              }else {
                                greenIcon = Icons.lightbulb;
                              }
                            });
                          },
                          child: ListTile(
                            title: const Text('Toggle Green LED'),
                            trailing:Icon(greenIcon),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        )
    );
  }
}
