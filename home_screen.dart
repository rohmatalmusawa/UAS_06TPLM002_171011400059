import 'package:cuaca/provider/cuaca_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  Intl.defaultLocale = 'id_ID';
  initializeDateFormatting().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuaca App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mendapatkan tanggal dan hari terkini
    DateTime currentDate = DateTime.now();
    String dayOfWeek = _getDayOfWeek(currentDate.weekday);

    return Scaffold(
      appBar: AppBar(
        title: Text("ROHMAT - 171011400059"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj9OKREIPeUdDHW7l_xIfXZsXzaTSWTC2NSw&usqp=CAU'),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<CuacaProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        dayOfWeek,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${currentDate.day} ${_getMonthName(currentDate.month)} ${currentDate.year}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: provider.cityNameText,
                    decoration: InputDecoration(
                      hintText: "Input Nama Kota",
                      labelText: "Nama Kota",
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      provider.showWeatherData();
                    },
                    child: Text("Tampilkan Cuaca"),
                  ),
                  SizedBox(height: 20),
                  Text(
                    provider?.cuacaModel?.name ?? "Waiting Data",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    provider.cuacaModel.weather?.first?.main ?? "Waiting data",
                  ),
                  SizedBox(height: 10),
                  Text("Suhu: ${provider.cuacaModel.main?.temp?.toStringAsFixed(0) ?? ''} \u2103"),

                ],
              ),
            );
          },
        ),
      ),
    );
  }

              String _getDayOfWeek(int day) {
                switch (day) {
                  case 1:
                    return "Senin";
                  case 2:
                    return "Selasa";
                  case 3:
                    return "Rabu";
                  case 4:
                    return "Kamis";
                  case 5:
                    return "Jumat";
                  case 6:
                    return "Sabtu";
                  case 7:
                    return "Minggu";
                  default:
                    return "";
                }
              }

              String _getMonthName
            (int month) {
            switch (month) {
            case 1:
            return "Januari";
            case 2:
            return "Februari";
            case 3:
            return "Maret";
            case 4:
            return "April";
            case 5:
            return "Mei";
            case 6:
            return "Juni";
            case 7:
            return "Juli";
            case 8:
            return "Agustus";
            case 9:
            return "September";
            case 10:
            return "Oktober";
            case 11:
            return "November";
            case 12:
            return "Desember";
            default:
            return "";
        }
    }
 }

