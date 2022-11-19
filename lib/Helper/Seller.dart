
class Seller{

  //this is singleton class object of this class will remain same after every initialization
  Seller._constructor();
  static final _instance = Seller._constructor();

  factory Seller(){
    return _instance;
  }

  String _userId="";
  String _fullName="";
  String _email="";
  String _homeAddress="";
  String _officeAddress="";
  String _number="";
  String _rank="";
  String _rating="";
  String _balance="";
  String _deposit="";
  String _used="";
  String _password="";
  String _imageUrl="";
  //List<String> review=[];

  String get userId => _userId;

  String get fullName => _fullName;

  String get email => _email;

  String get password => _password;

  String get rating => _rating;

  String get balance => _balance;

  String get rank => _rank;

  String get number => _number;

  String get officeAddress => _officeAddress;

  String get homeAddress => _homeAddress;

  String get deposit => _deposit;

  String get used => _used;

  String get imageUrl => _imageUrl;

  set userId(String value) {
    _userId = value;
  }

  set balance(String value) {
    _balance = value;
  }

  set rank(String value) {
    _rank = value;
  }

  set rating(String value) {
    _rating = value;
  }

  set number(String value) {
    _number = value;
  }

  set officeAddress(String value) {
    _officeAddress = value;
  }

  set homeAddress(String value) {
    _homeAddress = value;
  }

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  set fullName(String value) {
    _fullName = value;
  }

  set deposit(String value) {
    _deposit = value;
  }

  set used(String value) {
    _used = value;
  }

  set imageUrl(String value) {
    _imageUrl = value;
  }
}


class Buyer{

  //this is singleton class object of this class will remain same after every initialization
  Buyer._constructor();
  static final _instance = Buyer._constructor();

  factory Buyer(){
    return _instance;
  }

  String _userId="";
  String _fullName="";
  String _email="";
  String _homeAddress="";
  String _officeAddress="";
  String _number="";
  String _rank="";
  String _rating="";
  String _balance="";
  String _earned="";
  String _received="";
  String _password="";
  String _imageUrl="";
  List<dynamic> jobs=[];
  //List<String> review=[];


  String get userId => _userId;

  String get fullName => _fullName;

  String get email => _email;

  String get password => _password;

  String get rating => _rating;

  String get balance => _balance;

  String get rank => _rank;

  String get number => _number;

  String get officeAddress => _officeAddress;

  String get homeAddress => _homeAddress;

  String get earned => _earned;

  String get received => _received;

  String get imageUrl => _imageUrl;

  set userId(String value) {
    _userId = value;
  }

  set balance(String value) {
    _balance = value;
  }

  set rank(String value) {
    _rank = value;
  }

  set rating(String value) {
    _rating = value;
  }

  set number(String value) {
    _number = value;
  }

  set officeAddress(String value) {
    _officeAddress = value;
  }

  set homeAddress(String value) {
    _homeAddress = value;
  }

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  set fullName(String value) {
    _fullName = value;
  }

  set received(String value) {
    _received = value;
  }

  set earned(String value) {
    _earned = value;
  }

  set imageUrl(String value) {
    _imageUrl = value;
  }
}