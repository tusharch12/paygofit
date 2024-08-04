import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paygofit/utils/useraddress.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {

 static Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
    }
  }

 static Future<UserAddress> getAddressFromCurrentLocation() async {
    // Request location permissions
    await _requestLocationPermission();

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Convert the coordinates to an address
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
        print(placemarks);
    Placemark place = placemarks[0];
    UserAddress userAddress = UserAddress(
      street: place.street ?? 'unnamed',
      city: place.locality ?? 'unnmaed',
      state: place.administrativeArea?? 'unnamed',
      country: place.country?? 'unnamed ',
      postalCode: place.postalCode?? 'unnamed',
      sublocality: place.subLocality?? 'unnamed',

    );


    // UserAddress userAddress = UserAddress(

    // );
    
    String address =
        "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
    return userAddress;
  }
}