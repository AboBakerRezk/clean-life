
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:clean_life/home.dart';
import 'package:clean_life/pages/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'language.dart';





class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiKey = '85a38e33702779880006e1eb0f8ee104'; // ضع هنا مفتاح الـ API الخاص بك

  // قوائم المدن الأكثر تلوثًا والأفضل
  final List<City> mostPollutedCities = [
    City(name: 'New Delhi', country: 'India', lat: 28.6139, lon: 77.2090),
    City(name: 'Lahore', country: 'Pakistan', lat: 31.5204, lon: 74.3587),
    City(name: 'Dhaka', country: 'Bangladesh', lat: 23.8103, lon: 90.4125),
    City(name: 'Karachi', country: 'Pakistan', lat: 24.8607, lon: 67.0011),
    City(name: 'Beijing', country: 'China', lat: 39.9042, lon: 116.4074),
    City(name: 'Ulaanbaatar', country: 'Mongolia', lat: 47.8864, lon: 106.9057),
    City(name: 'Cairo', country: 'Egypt', lat: 30.0444, lon: 31.2357),
    City(name: 'Jakarta', country: 'Indonesia', lat: -6.2088, lon: 106.8456),
    City(name: 'Baghdad', country: 'Iraq', lat: 33.3152, lon: 44.3661),
    City(name: 'Mumbai', country: 'India', lat: 19.0760, lon: 72.8777),
  ];

  final List<City> bestAirQualityCities = [
    City(name: 'Reykjavik', country: 'Iceland', lat: 64.1466, lon: -21.9426),
    City(name: 'Zurich', country: 'Switzerland', lat: 47.3769, lon: 8.5417),
    City(name: 'Helsinki', country: 'Finland', lat: 60.1699, lon: 24.9384),
    City(name: 'Vancouver', country: 'Canada', lat: 49.2827, lon: -123.1207),
    City(name: 'Calgary', country: 'Canada', lat: 51.0447, lon: -114.0719),
    City(name: 'Wellington', country: 'New Zealand', lat: -41.2865, lon: 174.7762),
    City(name: 'Portland', country: 'USA', lat: 45.5051, lon: -122.6750),
    City(name: 'Stockholm', country: 'Sweden', lat: 59.3293, lon: 18.0686),
    City(name: 'Oslo', country: 'Norway', lat: 59.9139, lon: 10.7522),
    City(name: 'Copenhagen', country: 'Denmark', lat: 55.6761, lon: 12.5683),
  ];

  // قائمة بجميع الدول (استخدام حزمة country_picker)
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // عدد التبويبات
      child: Scaffold(
        appBar: AppBar(
          title: Text('${AppLocale.air138.getString(context)}'),
          bottom: TabBar(
            tabs: [
              Tab(text: '${AppLocale.air139.getString(context)}'),
              Tab(text: '${AppLocale.air140.getString(context)}'),
              Tab(text: '${AppLocale.air141.getString(context)}'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllCountriesTab(apiKey: apiKey),
            PollutedCitiesTab(cities: mostPollutedCities, apiKey: apiKey),
            BestCitiesTab(cities: bestAirQualityCities, apiKey: apiKey),
          ],
        ),
      ),
    );
  }
}

// نموذج لتمثيل المدينة
class City {
  final String name;
  final String country;
  final double lat;
  final double lon;
  int aqi;

  City({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    this.aqi = 0,
  });
}
class AllCountriesTab extends StatefulWidget {
  final String apiKey;

  AllCountriesTab({required this.apiKey});

  @override
  _AllCountriesTabState createState() => _AllCountriesTabState();
}

class _AllCountriesTabState extends State<AllCountriesTab> {
  final TextEditingController _cityController = TextEditingController();
  String? cityName;
  String? country;
  String? continent;
  Map<String, dynamic>? airPollutionData;
  bool isLoading = false;
  String? errorMessage;
  Timer? _debounce;
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _cityController.addListener(_onCityChanged);
  }

  @override
  void dispose() {
    _cityController.removeListener(_onCityChanged);
    _cityController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onCityChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        cityName = _cityController.text.trim();
      });
      if (cityName != null && cityName!.isNotEmpty) {
        fetchAirPollutionData(cityName!);
      }
    });
  }

  Future<void> fetchAirPollutionData(String city) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      airPollutionData = null;
      country = null;
      continent = null;
      latitude = null;
      longitude = null;
    });

    try {
      // 1. جلب إحداثيات المدينة باستخدام خدمة Geocoding من OpenWeather
      final geocodingUrl = Uri.https('api.openweathermap.org', '/geo/1.0/direct', {
        'q': city,
        'limit': '1',
        'appid': widget.apiKey,
      });

      final geocodingResponse = await http.get(geocodingUrl);

      if (geocodingResponse.statusCode == 200) {
        final geocodingData = json.decode(geocodingResponse.body);
        if (geocodingData is List && geocodingData.isNotEmpty) {
          final lat = geocodingData[0]['lat'];
          final lon = geocodingData[0]['lon'];
          final countryCode = geocodingData[0]['country'];

          setState(() {
            latitude = lat.toDouble();
            longitude = lon.toDouble();
          });

          // 2. جلب معلومات البلد باستخدام Rest Countries API
          final countryInfoUrl = Uri.https('restcountries.com', '/v3.1/alpha/$countryCode');
          final countryInfoResponse = await http.get(countryInfoUrl);

          if (countryInfoResponse.statusCode == 200) {
            final countryInfoData = json.decode(countryInfoResponse.body);
            if (countryInfoData is List && countryInfoData.isNotEmpty) {
              final countryDetails = countryInfoData[0];
              country = countryDetails['name']['common'] ?? '${AppLocale.air33.getString(context)}';
              continent = countryDetails['region'] ?? '${AppLocale.air33.getString(context)}';
            } else {
              country = '${AppLocale.air33.getString(context)}';
              continent = '${AppLocale.air33.getString(context)}';
            }
          } else {
            country = '${AppLocale.air33.getString(context)}';
            continent = '${AppLocale.air33.getString(context)}';
          }

          // 3. جلب بيانات تلوث الهواء باستخدام Air Pollution API من OpenWeather
          final airPollutionUrl = Uri.https('api.openweathermap.org', '/data/2.5/air_pollution', {
            'lat': lat.toString(),
            'lon': lon.toString(),
            'appid': widget.apiKey,
          });

          final airPollutionResponse = await http.get(airPollutionUrl);

          if (airPollutionResponse.statusCode == 200) {
            final pollutionData = json.decode(airPollutionResponse.body);
            setState(() {
              airPollutionData = Map<String, dynamic>.from(pollutionData);
            });
          } else {
            setState(() {
              errorMessage = '${AppLocale.air143.getString(context)} ${airPollutionResponse.statusCode}';
            });
          }
        } else {
          setState(() {
            errorMessage = '${AppLocale.air144.getString(context)}';
          });
        }
      } else {
        setState(() {
          errorMessage = '${AppLocale.air143.getString(context)} ${geocodingResponse.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = '${AppLocale.air146.getString(context)} $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocale.air147.getString(context)}',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: '${AppLocale.air35.getString(context)}',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (errorMessage != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            else if (airPollutionData != null)
                AirQualityDisplay(
                  city: cityName!,
                  country: country ?? '${AppLocale.air33.getString(context)}',
                  continent: continent ?? '${AppLocale.air33.getString(context)}',
                  latitude: latitude!,
                  longitude: longitude!,
                  data: airPollutionData!,
                ),
          ],
        ),
      ),
    );
  }
}

class AirQualityDisplay extends StatelessWidget {
  final String city;
  final String country;
  final String continent;
  final double latitude;
  final double longitude;
  final Map<String, dynamic> data;

  AirQualityDisplay({
    required this.city,
    required this.country,
    required this.continent,
    required this.latitude,
    required this.longitude,
    required this.data,
  });

  String getAirQualityDescription(int aqi, BuildContext context) {
    switch (aqi) {
      case 1:
        return '${AppLocale.air28.getString(context)}';
      case 2:
        return '${AppLocale.air29.getString(context)}';
      case 3:
        return '${AppLocale.air30.getString(context)}';
      case 4:
        return '${AppLocale.air76.getString(context)}';
      case 5:
        return '${AppLocale.air77.getString(context)}';
      default:
        return '${AppLocale.air33.getString(context)}';
    }
  }

  Color getAQIColor(int aqi) {
    switch (aqi) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  String getContinentDescription(String continent, BuildContext context) {
    return '${AppLocale.air150.getString(context)} $city ${AppLocale.air149.getString(context)} $continent.';
  }

  @override
  Widget build(BuildContext context) {
    final aqi = data['list'][0]['main']['aqi'];
    final components = data['list'][0]['components'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عرض معلومات جودة الهواء
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: getAQIColor(aqi).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: getAQIColor(aqi), width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$city, $country, $continent',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: getAQIColor(aqi),
                ),
              ),
              SizedBox(height: 10),
              Text(
                getContinentDescription(continent, context),
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '${AppLocale.air151.getString(context)} ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '$aqi (${getAirQualityDescription(aqi, context)})',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: getAQIColor(aqi),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                '${AppLocale.air152.getString(context)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...components.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      Text(
                        '${entry.key.toUpperCase()}: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${entry.value} μg/m³'),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              Text(
    _getAQIExplanation(aqi, context),

    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  String _getAQIExplanation(int aqi, BuildContext context) {
    switch (aqi) {
      case 1:
        return '${AppLocale.air153.getString(context)}';
      case 2:
        return '${AppLocale.air154.getString(context)}';
      case 3:
        return '${AppLocale.air155.getString(context)}';
      case 4:
        return '${AppLocale.air156.getString(context)}';
      case 5:
        return '${AppLocale.air157.getString(context)}';
      default:
        return '${AppLocale.air158.getString(context)}';
    }
  }
}

/// ويدجيت عرض جودة الهواء
// تبويب المدن الأكثر تلوثًا
class PollutedCitiesTab extends StatefulWidget {
  final List<City> cities;
  final String apiKey;

  PollutedCitiesTab({required this.cities, required this.apiKey});

  @override
  _PollutedCitiesTabState createState() => _PollutedCitiesTabState();
}

class _PollutedCitiesTabState extends State<PollutedCitiesTab> {
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchAllPollutedCitiesAQI() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    List<City> updatedCities = [];

    try {
      for (var city in widget.cities) {
        final url = Uri.parse(
            'https://api.openweathermap.org/data/2.5/air_pollution?lat=${city.lat}&lon=${city.lon}&appid=${widget.apiKey}');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final aqi = data['list'][0]['main']['aqi'];

          updatedCities.add(City(
            name: city.name,
            country: city.country,
            lat: city.lat,
            lon: city.lon,
            aqi: aqi,
          ));
        } else {
          setState(() {
            errorMessage = '${AppLocale.air159.getString(context)}';
          });
        }
      }

      // فرز المدن بناءً على AQI (من الأعلى إلى الأدنى)
      updatedCities.sort((a, b) => b.aqi.compareTo(a.aqi));

      setState(() {
        widget.cities.clear();
        widget.cities.addAll(updatedCities);
      });
    } catch (e) {
      setState(() {
        errorMessage = '${AppLocale.air16.getString(context)} $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllPollutedCitiesAQI();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : errorMessage != null
        ? Center(
      child: Text(
        errorMessage!,
        style: TextStyle(color: Colors.red),
      ),
    )
        : ListView.builder(
      itemCount: widget.cities.length,
      itemBuilder: (context, index) {
        final city = widget.cities[index];
        return CityAirQualityTile(city: city);
      },
    );
  }
}

// تبويب المدن الأفضل في جودة الهواء
class BestCitiesTab extends StatefulWidget {
  final List<City> cities;
  final String apiKey;

  BestCitiesTab({required this.cities, required this.apiKey});

  @override
  _BestCitiesTabState createState() => _BestCitiesTabState();
}

class _BestCitiesTabState extends State<BestCitiesTab> {
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchAllBestCitiesAQI() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    List<City> updatedCities = [];

    try {
      for (var city in widget.cities) {
        final url = Uri.parse(
            'https://api.openweathermap.org/data/2.5/air_pollution?lat=${city.lat}&lon=${city.lon}&appid=${widget.apiKey}');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final aqi = data['list'][0]['main']['aqi'];

          updatedCities.add(City(
            name: city.name,
            country: city.country,
            lat: city.lat,
            lon: city.lon,
            aqi: aqi,
          ));
        } else {
          setState(() {
            errorMessage = '${AppLocale.air159.getString(context)}';
          });
        }
      }

      // فرز المدن بناءً على AQI (من الأقل إلى الأعلى)
      updatedCities.sort((a, b) => a.aqi.compareTo(b.aqi));

      setState(() {
        widget.cities.clear();
        widget.cities.addAll(updatedCities);
      });
    } catch (e) {
      setState(() {
        errorMessage = '${AppLocale.air16.getString(context)} $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllBestCitiesAQI();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : errorMessage != null
        ? Center(
      child: Text(
        errorMessage!,
        style: TextStyle(color: Colors.red),
      ),
    )
        : ListView.builder(
      itemCount: widget.cities.length,
      itemBuilder: (context, index) {
        final city = widget.cities[index];
        return CityAirQualityTile(city: city);
      },
    );
  }
}

// ويدجت لعرض بيانات جودة الهواء لمدينة معينة
class CityAirQualityTile extends StatelessWidget {
  final City city;

  CityAirQualityTile({required this.city});

  String getAQI(int aqi, BuildContext context) {
    switch (aqi) {
      case 1:
        return '${AppLocale.air40.getString(context)}';
      case 2:
        return '${AppLocale.air28.getString(context)}';
      case 3:
        return '${AppLocale.air30.getString(context)}';
      case 4:
        return '${AppLocale.air31.getString(context)}';
      case 5:
        return '${AppLocale.air78.getString(context)}';
      default:
        return '${AppLocale.air33.getString(context)}';
    }
  }

  Color getAQIColor(int aqi) {
    switch (aqi) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${city.name}, ${city.country}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'AQI: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${city.aqi} (${getAQI(city.aqi, context)})',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: getAQIColor(city.aqi),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // عرض المكونات إذا كانت متوفرة
            // يمكنك إضافة المزيد من التفاصيل هنا إذا كنت ترغب
          ],
        ),
      ),
    );
  }
}

// ويدجت لعرض بيانات جودة الهواء
