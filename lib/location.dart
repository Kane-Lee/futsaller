import 'package:geolocator/geolocator.dart';

class Location {

  double latitude = 0;
  double longitude = 0;

  Future<void> getCurrentLocation() async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever){
        return Future.error('Location Not Available');
      }
    } else{
      throw Exception('Error');
    }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      latitude = position.latitude;
      longitude = position.longitude;




  }

}