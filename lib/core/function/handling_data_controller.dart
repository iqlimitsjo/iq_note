import '../class/custom_response.dart';
import '../class/status_request.dart';

handlingData(response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}

handlingFirebaseData(CustomResponse response) {
  if (response.code == 200) {
    return StatusRequest.success;
  } else {
    return StatusRequest.failed;
  }
}
