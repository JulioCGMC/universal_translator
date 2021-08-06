part of universal_translator;

extension TranslateTooltip on Tooltip {
  /// Translate the text to the defined language using
  /// the `universal_translator` package using the `FutureBuilder` widget.
  ///
  /// If the [placeholder] arguments is null then it will show three dots.
  Widget translate([String placeholder]) {
    String data = this.message;
    return FutureBuilder<String>(
        future: UniversalTranslatorController().translateText(data),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          String response = placeholder ?? "...";
          if (snapshot.hasData) {
            response = snapshot.data ?? this.message;
          }
          return Tooltip(
            key: this.key,
            message: response,
            height: this.height,
            padding: this.padding,
            margin: this.margin,
            verticalOffset: this.verticalOffset,
            preferBelow: this.preferBelow,
            excludeFromSemantics: this.excludeFromSemantics,
            decoration: this.decoration,
            textStyle: this.textStyle,
            waitDuration: this.waitDuration,
            showDuration: this.showDuration,
            child: this.child
          );
        });
  }
}
