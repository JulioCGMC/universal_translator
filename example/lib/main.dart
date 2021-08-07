
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:universal_translator/universal_translator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String path = "https://nlp-translation.p.rapidapi.com/v1/translate";
    Map<String,dynamic> headers = { "x-rapidapi-key": "MY_API_KEY" };

    String responsePattern(Response response) {
      if (response.statusCode == 200 && response.data['status'] == 200) {
        dynamic data = response.data;
        return data["translated_text"][data["to"]];
      }
      return null;
    }

    Map<String,dynamic> bodyPattern(String text, Locale to) => {
      "text": text,
      "to": to.toLanguageTag(),
      "from": "pt"
    };

    return UniversalTranslatorInit(path,
      headers: headers,
      method: HttpMethod.get,
      bodyPattern: bodyPattern,
      responsePattern: responsePattern,
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
      title: Text(widget.title ?? "").translate(true),
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
            Text.rich(
              TextSpan(
                text: "primeiro ",
                children: [
                  TextSpan(
                    text: "primeiro.primeiro ",
                    children: [
                      TextSpan(
                        text: "primeiro.primeiro.primeiro ",
                        children: [
                          TextSpan(
                            text: "primeiro.primeiro.primeiro.primeiro ",
                          ),
                        ]
                      ),
                      TextSpan(text: "primeiro.primeiro.segundo ")
                    ]
                  ),
                  TextSpan(
                    text: "primeiro.segundo ",
                    children: [
                      TextSpan(text: "primeiro.segundo.primeiro "),
                      TextSpan(text: "primeiro.segundo.segundo "),
                      TextSpan(text: "primeiro.segundo.terceiro ")
                    ]
                  )
                ]
              ), 
              textAlign: TextAlign.center
            ).translate(true, "Place to Holder")
          ]
        ),
      ),
    );
  }
}
