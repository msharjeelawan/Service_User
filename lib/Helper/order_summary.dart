
class OrderSummary{

  OrderSummary._constructor();
  static final _instance=OrderSummary._constructor();
  factory OrderSummary(){
    return _instance;
  }

  String _type="";
  String _subService="";
  String _subServiceArbi="";
  String _location="";
  String _time="";
  String _latLng="";

  String get latLng => _latLng;

  String get type => _type;

  String get subService => _subService;

  String get location => _location;

  String get time => _time;

  String get subServiceArbi => _subServiceArbi;

  set subServiceArbi(String value) {
    _subServiceArbi = value;
  }

  set latLng(String value) {
    _latLng = value;
  }

  set type(String value) {
    _type = value;
  }

  set subService(String value) {
    _subService = value;
  }

  set time(String value) {
    _time = value;
  }

  set location(String value) {
    _location = value;
  }
}