import 'dart:io';
import 'package:flutter/material.dart';
import 'barcode_scanner_without_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    ));

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String? url = 'homepage';

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  List<Map<String, String>> menu = [
    {'title': 'Home', 'url': 'homepage'},
    {'title': 'Domotica', 'url': 'quadro_domotica'},
    {'title': 'Geotermico', 'url': 'pdc_geotermica'},
    {'title': 'Puffer', 'url': 'puffer'},
    {'title': 'Qualità Aria', 'url': 'qualita_aria'},
    {'title': 'Stazione Meteo', 'url': 'stazione_meteo'},
    {'title': 'Travi Fredde', 'url': 'travi_fredde'},
    {'title': 'VMC', 'url': 'vmc'},
    {'title': 'Camino Solare', 'url': 'camino_solare'},
    {'title': 'Parete 1', 'url': 'parete1'},
    {'title': 'Parete 2', 'url': 'parete2'},
    {'title': 'Parete 3', 'url': 'parete3'},
    {'title': 'Parete 4', 'url': 'parete4'},
    {'title': 'Parete 5', 'url': 'parete5'},
    {'title': 'Parete 6', 'url': 'parete6'},
    {'title': 'Parete 7', 'url': 'parete7'},
    {'title': 'Parete 8', 'url': 'parete8'},
    {'title': 'PDC Aria-Acqua', 'url': 'pdc_ariaacqua'},
    {'title': 'PDC Acqua-Aria', 'url': 'pdc_acquaaria'},
    {'title': 'PDC Aria-Aria', 'url': 'pdc_ariaaria'},
    {'title': 'Fotovoltaico', 'url': 'impianto_fotovoltaico'},
    {'title': 'Caldaia Pirolitica', 'url': 'caldaia_pirolitica'},
    {'title': 'Tetto', 'url': 'tetto'},
    {'title': 'Collettore Solare', 'url': 'collettore_solare'},
    {'title': 'Pavimento Radiante', 'url': 'pavimento_radiante'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tour Guidato - Casa dell\'Energia')),
      drawer: Drawer(
          child: ListView(
        children: menu.toList().map((e) {
          String? title;
          String? url_map;

          if (e['title'] == null) {
            title = '';
          } else {
            title = (e['title']);
          }

          if (e['url'] == null) {
            url_map = '';
          } else {
            url_map = (e['title']);
          }

          return ListTile(
            title: title != null ? Text(title) : Text(''),
            onTap: () {
              setState(() {
                url = url_map;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      )),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "http://192.168.88.224/tour-guidato/" + url! + ".php",
        onWebResourceError: (WebResourceError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                '${WebResourceError.errorCode}, ${WebResourceError.description}'),
          ));
        },
        onPageStarted: (string) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Start loading: $string'),
          ));
        },
      ),
      //Text("http://192.168.88.224/tour-guidato/" + url + ".php"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showqrcodepage(context);
        },
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
    );
  }

  Future<void> _showqrcodepage(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BarcodeScannerWithoutController(),
      ),
    );
    if (result != null) {
      setState(() {
        url = result;
      });
    }
  }
}
