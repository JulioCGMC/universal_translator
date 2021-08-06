import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universal_translator/universal_translator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return UniversalTranslatorInit("https://nlp-translation.p.rapidapi.com/v1/translate",
      headers: {
        "x-rapidapi-key": "MY_API_KEY"
      },
      method: HttpMethod.get,
      responsePattern: (response) {
        if (response.statusCode == 200 && response.data['status'] == 200) {
          dynamic data = response.data;
          return data["translated_text"][data["to"]];
        }
        return null;
      },
      bodyPattern: (text, to) => {
        "text": text,
        "to": to.toLanguageTag(),
        "from": "pt"
      },
      translateTo: Locale('en'),
      cacheDuration: Duration(days: 13),
      // automaticDetection: , In case you don't know the user language
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Página inicial de demonstração do Flutter'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(widget.title ?? "").translate(),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Original: Meu texto traduzido", 
              textAlign: TextAlign.center),
            Text("Meu texto traduzido", 
              textAlign: TextAlign.center).translate(),
            SizedBox(height: 20),
            Text("Original: Este texto mostra um placeholder diferente", 
              textAlign: TextAlign.center),
            Text("Este texto mostra um placeholder diferente", 
              textAlign: TextAlign.center).translate("Place to Holder")
          ]
        ),
      ),
    );
  }
}
