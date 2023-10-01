import 'package:flutter/material.dart';
import 'package:second/userprofil/http.dart';

class ViewerScreen extends StatefulWidget {
  @override
  _ViewerScreenState createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  String? city;
  String? temperature;
  String? weatherCondition;
  String? weatherIconUrl;

  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Hämta skärmens storlek
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Beräkna ikonstorlek baserat på skärmens bredd
    double iconSize = screenWidth * 0.2; // Tar upp 40% av skärmens bredd

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Väderdelning',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02), // Responsiv spacing
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: 'Skriv in stadsnamn',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02), // Responsiv spacing
                ElevatedButton(
                  onPressed: () async {
                    WeatherService weatherService = WeatherService();
                    var weatherData = await weatherService.fetchWeather(cityController.text);

                    setState(() {
                      city = cityController.text;
                      temperature = weatherData['main']['temp'].toString();
                      weatherCondition = weatherData['weather'][0]['description'];
                      String icon = weatherData['weather'][0]['icon'];
                      weatherIconUrl = 'http://openweathermap.org/img/w/$icon.png';
                    });
                  },
                  child: Text('Sök'),
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.02), // Responsiv spacing
            if (city != null)
              Text(
                city!,
                style: TextStyle(fontSize: 22),
              ),
            SizedBox(height: screenHeight * 0.02), // Responsiv spacing
            if (temperature != null)
              Text(
                '$temperature°C',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: screenHeight * 0.02), // Responsiv spacing
            if (weatherCondition != null)
              Text(
                weatherCondition!,
                style: TextStyle(fontSize: 20),
              ),
            SizedBox(height: screenHeight * 0.01), // Responsiv spacing
            if (weatherIconUrl != null)
              Container(
                width: iconSize,  // Använd beräknad ikonstorlek här
                height: iconSize, // Och här
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(weatherIconUrl!),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  Future<void> getDefaultWeather() async {
    WeatherService weatherService = WeatherService();
    var weatherData = await weatherService.fetchWeather("Malmö");

    setState(() {
      city = "Malmö";
      temperature = weatherData['main']['temp'].toString();
      weatherCondition = weatherData['weather'][0]['description'];
      weatherIconUrl = 'http://openweathermap.org/img/w/${weatherData['weather'][0]['icon']}.png';
    });
  }

  @override
  void initState() {
    super.initState();
    getDefaultWeather();
  }
}
