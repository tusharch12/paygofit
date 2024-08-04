import 'package:geocoding/geocoding.dart';

class UserAddress {
  final String street;
  final String city;
  final String state;
  final String sublocality;
  final String country;
  final String postalCode;

  UserAddress({
    required this.street,
    required this.city,
    required this.state,
    required this.sublocality,
    required this.country,
    required this.postalCode,
  });

  // Factory method to create UserAddress from Placemark
  factory UserAddress.fromPlacemark(Placemark placemark) {
    return UserAddress(
      street: placemark.street ?? '',
      city: placemark.locality ?? '',
      state: placemark.administrativeArea ?? '',
      country: placemark.country ?? '',
      postalCode: placemark.postalCode ?? '',
      sublocality: placemark.subLocality ?? '',
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country, $sublocality' ;
  }
}
