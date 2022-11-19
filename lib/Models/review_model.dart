
class Review{

  String _name="";
  String _comment="";
  String _star="";
  String _service="";
  
  static List<Review> _list=[];

  static List<Review> get list => _list;

  Review(this._name,this._comment,this._star,this._service);

  String get service => _service;

  String get star => _star;

  String get comment => _comment;

  String get name => _name;
}