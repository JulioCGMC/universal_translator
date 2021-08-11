part of universal_translator;

extension TranslateSelectableText on SelectableText {
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
          if (this.textSpan == null || !snapshot.hasData) return SelectableText(
            response,
            key: this.key,
            focusNode: this.focusNode,
            style: this.style,
            strutStyle: this.strutStyle,
            textAlign: this.textAlign,
            textDirection: this.textDirection,
            textScaleFactor: this.textScaleFactor,
            showCursor: this.showCursor,
            autofocus: this.autofocus,
            toolbarOptions: this.toolbarOptions,
            minLines: this.minLines,
            maxLines: this.maxLines,
            cursorWidth: this.cursorWidth,
            cursorHeight: this.cursorHeight,
            cursorRadius: this.cursorRadius,
            cursorColor: this.cursorColor,
            dragStartBehavior: this.dragStartBehavior,
            enableInteractiveSelection: this.enableInteractiveSelection,
            onTap: this.onTap,
            scrollPhysics: this.scrollPhysics,
            textHeightBehavior: this.textHeightBehavior,
            textWidthBasis: this.textWidthBasis
          );
          else return SelectableText.rich(
            getSpansFromTexts(response.split(splitKeyWord), this.textSpan),
            key: this.key,
            focusNode: this.focusNode,
            style: this.style,
            strutStyle: this.strutStyle,
            textAlign: this.textAlign,
            textDirection: this.textDirection,
            textScaleFactor: this.textScaleFactor,
            showCursor: this.showCursor,
            autofocus: this.autofocus,
            toolbarOptions: this.toolbarOptions,
            minLines: this.minLines,
            maxLines: this.maxLines,
            cursorWidth: this.cursorWidth,
            cursorHeight: this.cursorHeight,
            cursorRadius: this.cursorRadius,
            cursorColor: this.cursorColor,
            dragStartBehavior: this.dragStartBehavior,
            enableInteractiveSelection: this.enableInteractiveSelection,
            onTap: this.onTap,
            scrollPhysics: this.scrollPhysics,
            textHeightBehavior: this.textHeightBehavior,
            textWidthBasis: this.textWidthBasis
          );
        });
  }
}
