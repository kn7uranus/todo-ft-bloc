import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:u_todo/services/app/app_config.dart';
import 'package:u_todo/widgets/w_text_rounded.dart';

// ignore: must_be_immutable
class WEnv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Env env = AppConfig.I.env;
    return env.envType != EnvType.prod ? WTextRounded(text: describeEnum(env.envType), color: Colors.red) : Container();
  }
}
