import 'package:flutter/foundation.dart';

enum BikeType { electric, mechanical }

enum HousingType { apartment, house }

enum HeatingSource { electricity, gas, wood }

class WizardModel extends ChangeNotifier {
  int carKm = 12000;
  int carPassengers = 1;
  BikeType? bikeType;
  int bikeKm = 1000;

  HousingType? housingType;
  int? housingSurface;
  HeatingSource? heatingSource;

  int foodScore = 0;
  int equipmentScore = 0;

  void setCarKm(int value) {
    carKm = value;
    notifyListeners();
  }

  void setCarPassengers(int value) {
    carPassengers = value;
    notifyListeners();
  }

  void setBikeType(BikeType? value) {
    bikeType = value;
    notifyListeners();
  }

  void setBikeKm(int value) {
    bikeKm = value;
    notifyListeners();
  }

  void setHousingType(HousingType? value) {
    housingType = value;
    notifyListeners();
  }

  void setHousingSurface(int? value) {
    housingSurface = value;
    notifyListeners();
  }

  void setHeatingSource(HeatingSource? value) {
    heatingSource = value;
    notifyListeners();
  }

  void setFoodScore(int value) {
    foodScore = value;
    notifyListeners();
  }

  void setEquipmentScore(int value) {
    equipmentScore = value;
    notifyListeners();
  }
}
