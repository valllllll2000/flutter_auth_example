import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initDotEnvironment() async {
    await dotenv.load(fileName: '.env');
  }
  static String apiUrl = dotenv.env['API_URL'] ?? 'Mossing API URL';
}
