import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:capstone/backgroundimage.dart';

class RoomTemperature extends StatefulWidget {
  const RoomTemperature({Key? key}) : super(key: key);

  @override
  State<RoomTemperature> createState() => _RoomTemperatureState();
}

class _RoomTemperatureState extends State<RoomTemperature> {
  String cel = '';
  String fah = '';
  String hum = '';
  String _status = '';
  String url = 'http://192.168.1.200:80/';
  var response;
  var dataProgress = true;

  getDatafromSensor() async {
    try{
      response = await http.get(Uri.parse(url + 'RoomTemperature'),
          headers: {'Accept': 'plain/text'});
      if(response.body == 'sensorError') {
        setState(() {
          _status = 'Sensor is not Connected!';
          dataProgress = false;
          cel = '';
          fah = '';
          hum = '';

        });
      } else {
        setState(() {
          _status = 'Sensor is Connected!';
          dataProgress = false;
          cel = response.body.substring(0, 4) + '°C';
          //print('Celsius: '+cel);
          fah = response.body.substring(6, 10) + '°F';
          //print('Fahrenheit: '+fah);
          hum = response.body.substring(12, 16) + '%';
          //print('Humidity: '+hum);
        });
      }
    } catch(e) {
      print(e);
      if(this.mounted) {
        setState(() {
          _status = 'NodeMCU is not Connected';
          dataProgress = false;
          cel = '';
          fah = '';
          hum = '';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getDatafromSensor();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as BackgroundImages;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Room Temperature Monitor'),
        ),

        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(args.getImage()), fit: BoxFit.fill
              )
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text('Room Temperature', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Image.asset('icons/celsius.png'),
                      ),
                      title: Text(cel.toString()),
                      subtitle: const Text('Room Temperature in Celsius'),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Image.asset('icons/fahrenheit.png'),
                      ),
                      title: Text(fah.toString()),
                      subtitle: const Text('Room Temperature in Fahrenheit'),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Image.asset('icons/humidity.png'),
                      ),
                      title: Text(hum.toString()),
                      subtitle: const Text('Room Humidity'),
                    ),
                  ],
                ),
              ),
              dataProgress ? Container(
                padding: const EdgeInsets.all(10),
                child: const Center(child: CircularProgressIndicator()),
              )
              :Container(),
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 70,
                width: 120,
                child: ElevatedButton(
                  child: const Text('Refresh Data'),
                  onPressed: () {
                    setState(() {
                      dataProgress = true;
                    });
                    getDatafromSensor();
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
