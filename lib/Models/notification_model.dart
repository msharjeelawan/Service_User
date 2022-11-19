
class Notifications{

  String _title="";
  String _subTitle="";
  String _trailingTitle="";
  String _trailingSubTitle="";
  String _time="";
  String _jobId="";

  static List<Notifications> _list=[];

  static List<Notifications> get getList => _list;

  Notifications(this._title,this._subTitle,this._trailingTitle,this._trailingSubTitle,this._time,this._jobId);

  String get trailingSubTitle => _trailingSubTitle;

  String get trailingTitle => _trailingTitle;

  String get subTitle => _subTitle;

  String get title => _title;

  String get time => _time;

  String get jobId => _jobId;

  set title(String value) {
    _title = value;
  }
}


enum NotificationType{
  accepted,
  quoted,
  working,
  cancelled,
  completed,
  thanks
}

extension JobValue on NotificationType{
  static const status=["Job accepted","Quotation available","Work started","Job cancelled","Pay for completed Job","Thanks for payment.."];
  String get value => status[index];
}