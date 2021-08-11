part of universal_translator;

extension TranslateText on Text {
  /// Translate the text to the defined language using
  /// the `universal_translator` package using the `FutureBuilder` widget.
  ///
  /// If the [usePlaceholder] arguments is false then it will show the original while awaits.
  /// If the [placeholder] arguments is null then it will show three dots.
  Widget translate([bool usePlaceholder = false, String placeholder = "..."]) {
    String data;
    String splitKeyWord;
    if (this.textSpan != null) {
      splitKeyWord = "(}[";
      data = getTextsFromSpan(this.textSpan).join(splitKeyWord);
    }
    else {
      data = this.data;
    }
    return FutureBuilder<String>(
        future: UniversalTranslatorController().translateText(data ?? ""),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          String response = (usePlaceholder ? placeholder : this.data 
            ?? placeholder ?? "").replaceAll(splitKeyWord ?? "", "");
          if (snapshot.hasData) {
            response = snapshot.data ?? this.data;
          }
          if (this.textSpan == null || !snapshot.hasData) return Text(response,
              key: this.key,
              locale: this.locale,
              maxLines: this.maxLines,
              overflow: this.overflow,
              semanticsLabel: this.semanticsLabel,
              softWrap: this.softWrap,
              strutStyle: this.strutStyle,
              style: this.style,
              textAlign: this.textAlign,
              textDirection: this.textDirection,
              textHeightBehavior: this.textHeightBehavior,
              textScaleFactor: this.textScaleFactor,
              textWidthBasis: this.textWidthBasis);
          else return Text.rich(
              getSpansFromTexts(response.split(splitKeyWord), this.textSpan),
              key: this.key,
              locale: this.locale,
              maxLines: this.maxLines,
              overflow: this.overflow,
              semanticsLabel: this.semanticsLabel,
              softWrap: this.softWrap,
              strutStyle: this.strutStyle,
              style: this.style,
              textAlign: this.textAlign,
              textDirection: this.textDirection,
              textHeightBehavior: this.textHeightBehavior,
              textScaleFactor: this.textScaleFactor,
              textWidthBasis: this.textWidthBasis);
        });
  }
}
