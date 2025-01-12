
import 'package:http/http.dart';

class ApiChecker {
  static void checkApi(Response response, {bool showToaster = false}) {
    if(response.statusCode == 401) {
     
    }else {
      // showCustomSnackbar(context: context, message: 'Something went wrong', isError: true);
    }
  }
}