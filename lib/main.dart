import 'package:u_todo/my_app.dart';
import 'package:u_todo/services/app/app_config.dart';
import 'package:u_todo/services/app/app_theme.dart';

Future<void> main() async {
  /// Init dev config
  AppConfig(env: Env.dev(), theme: AppTheme.origin());
  await myMain();
}
