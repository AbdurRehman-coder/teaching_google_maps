

import 'package:flutter/foundation.dart';

class AddressConversion {
  ValueNotifier stringNotifier = ValueNotifier(' ');

  setNotifierValue(String newValue){
    stringNotifier.value = newValue;
  }
}