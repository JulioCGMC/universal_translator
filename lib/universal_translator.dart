library universal_translator;

/*
 * Created by Julio Cortez on 2021/06/29.
 * email: julio.cesar.g.c125@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

part 'functions/functions.dart';
part 'enum/http_method.dart';
part 'repositories/universal_translator_repository.dart';
part 'controllers/universal_translator_controller.dart';
part 'components/universal_translator_init.dart';

/// Extensions
part 'extensions/text_extension.dart';
part 'extensions/selectable_text_extension.dart';
part 'extensions/tooltip_extension.dart';
