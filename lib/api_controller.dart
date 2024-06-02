import 'package:http/http.dart' as http;
import 'package:mobile_anwendungen/json_parser.dart';

class ApiProvider {
  Future<List<Cat>> getCats() async {
    const url =
        'https://api.thecatapi.com/v1/images/search?limit=15&has_breeds=1&api_key=live_O9BHrRq7E4JViudv6qwMQ7nqRmgFZFSfKXHpm9ryaX0I6Jad5mC6WUMbfW2sIsSF';

    final req = await http.get(Uri.parse(url));

    if (req.statusCode == 200) {
      final body = req.body;

      final cat = catFromJson(body);

      return cat;
    } else {
      final body = req.body;
      final error = catFromJson(body);
      return error;
    }
  }
}
