# universal_translator

[![pub package](https://img.shields.io/pub/v/universal_translator.svg)](https://pub.dev/packages/universal_translator)

**A flutter plugin for adapting screen and font size.Let your UI display a reasonable layout on different screen sizes!**

## Usage:
### Add dependency：
Please check the latest version before installation.
If there is any problem with the new version, please use the previous version
```yaml
dependencies:
  # Functionalities
  universal_translator: ^{latest version}
  ..
  flutter:
    sdk: flutter
```
### Add the following imports to your Dart code:
```dart
import 'package:universal_translator/universal_translator.dart';
```

## Getting Started
First, you will need to send the path, heades, body example and response example, allong with a few default parameters described bellow, before the calling of the translate function (we recomend to do as in the example):
```dart
void main() {
    /// Required to make the `UniversalTranslatorInit` call before the `MaterialApp`
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {

  String path = "https://nlp-translation.p.rapidapi.com/v1/translate";
  Map<String,dynamic> headers = { "x-rapidapi-key": "MY_API_KEY" }

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
  }

  @override
  Widget build(BuildContext context) {
    return UniversalTranslatorInit(path,
      headers: headers,
      method: HttpMethod.get,
      responsePattern: responsePattern,
      bodyPattern: bodyPattern,
      translateTo: Locale('en'),
      // automaticDetection: , In case you don't know the user language
      cacheDuration: Duration(days: 13),
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
```
*Note*: If will want to make the call before the MaterialApp, will have to add the *WidgetsFlutterBinding.ensureInitialized();* before the *runApp* function.
______________
## Basic Usage

Now, all you'll have to make is add the *.translate()* to all the *Text* you want to translate.

```dart
Scaffold(
    appBar: AppBar(
    title: Text(widget.title ?? "").translate(),
    ),
    body: Column(
        children: [
            Text("Meu texto traduzido").translate(),
            Text("Este texto mostra um placeholder diferente").translate("Place to Holder")
        ]
    ),
);
```
## Disclaimer

This package works with cache data [dio_http_cache](https://pub.dev/packages/dio_http_cache), that, by default last's 7 days, but can be change in the `UniversalTranslatorInit` > `cacheDuration` parameter.

## Issues

Please if you see any issues, bugs, or feature requests, send to me in: [GitHub issue](https://github.com/JulioCGMC/universal_translator/issues) or send a direct email in case of urgency.