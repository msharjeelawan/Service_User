
class Transactions{
  // String _owner_id="";
  // String _transfer_to="";
  String _amount="";
  String _type="";
  String _jobNo="";
  String _date="";
  String _name="";

  static List<Transactions> _list=[];

  static List<Transactions> get transactionsList => _list;

  Transactions(this._amount,this._type,this._jobNo,this._date,this._name);

  String get jobNo => _jobNo;

  String get type => _type;

  String get amount => _amount;

  String get date => _date;

  String get name => _name;

// String get transfer_to => _transfer_to;
  //
  // String get owner_id => _owner_id;
}