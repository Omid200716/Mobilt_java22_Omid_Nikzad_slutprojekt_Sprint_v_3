import 'dart:convert';
import 'package:http/http.dart' as http;


class WeatherService{
final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
final String apiKey = 'aeb1d29b8db6b9a654e6d73b49038c3f';


Future<Map<String, dynamic>> fetchWeather(String city) async{
  final response = await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));


  if (response.statusCode == 200){
    return json.decode(response.body);


  }else{
    throw Exception('Failed to load weather');
  }
}


}