import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:capstone/backgroundimage.dart';

enum AppState  { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING}

class WeatherUpdate extends StatefulWidget {
  const WeatherUpdate({Key? key}) : super(key: key);

  @override
  State<WeatherUpdate> createState() => _WeatherUpdateState();
}

class _WeatherUpdateState extends State<WeatherUpdate> {
  String key = 'ec123d4695e48db7233ccdbc20dddd5f';
  late WeatherFactory ws;
  List<Weather> _data = [];
  String? city;
  AppState _state = AppState.NOT_DOWNLOADED;
  final _cityFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ws = WeatherFactory(key);
  }
  void currentWeather() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });
    Weather weather = await ws.currentWeatherByCityName(city!);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget dataDownloaded() {
    return Center(
      child: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_data[index].toString()),
          );
        },
      ),
    );
  }
  Widget dataDownloading() {
    return const Center(
      child: Text("Fetching Weather's Data"),
    );
  }
  Widget dataNotDownloaded() {
    return const Center(
      child: Text("Press the button to download weather's data")
    );
  }
  Widget _finalData() => _state == AppState.FINISHED_DOWNLOADING
      ? dataDownloaded()
      : _state == AppState.DOWNLOADING
      ? dataDownloading()
      : dataNotDownloaded();

  void _cityName(String input) {
    city = input;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as BackgroundImages;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
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
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.text_fields),
                      hintText: 'Enter a City Name',
                      labelText: 'City Name'
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: _cityName,
                    onSubmitted: _cityName,
                  )
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: currentWeather,
                    child: const Text("Fetch Weather's Data"),
                  ),
                ),
                Expanded(
                    child: _finalData(),
                )
              ],
            ),
          ),
        )
    );
  }
}
