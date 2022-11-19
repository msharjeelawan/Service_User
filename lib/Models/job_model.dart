import 'package:mutwaffer_user/Models/notification_model.dart';

class Job {

  Job(this._firebaseId,this._jobNo,this._buyerId,this._buyerName,this._buyerAddress,this._sellerId,this._sellerName,this._sellerAddress,
      this._status,this._quotation,this._orderCreatedTime,
      this._orderDeliveryTime,this._service,this._paymentMethod,this._paymentAmount,this._isPaid,this._reviewId,this._type,this._isNotificationView);

  static final List<Job> _newJobList=[];
 // static final List<Job> _acceptedJobList=[];
  static final List<Job> _cancelledJobList=[];
  static final List<Job> _completedJobList=[];

  static List<Job> get newJobList => _newJobList;
  //static List<Job> get acceptedJobList => _acceptedJobList;
  static List<Job> get cancelledJobList => _cancelledJobList;
  static List<Job> get completedJobList => _completedJobList;

  static jsonToModel(String k,Map<dynamic,dynamic> v){
    // _newJobList.clear();
    // //_acceptedJobList.clear();
    // _cancelledJobList.clear();
    // _completedJobList.clear();
    // Notifications.getList.clear();

     // map.forEach((k, v) {
        //create job instance
        var job = Job(k.toString(),v["jobNo"].toString(), v["buyerId"].toString(), v["buyerName"].toString(), v["buyerAddress"].toString(),
            v["sellerId"].toString(), v["sellerName"].toString(), v["sellerAddress"].toString(),
            v["status"].toString(), v["quotation"].toString(), v["orderCreatedTime"].toString(), v["orderDeliveryTime"].toString(),v["service"].toString(),
            v["paymentMethod"].toString(),v["paymentAmount"].toString(),v["isPaid"],v["userReviewId"].toString(),v["type"].toString(),v["isNotificationView"]);

        //according to job status, push into corresponding job list....
        String status=v["status"]!;
        bool isNotificationView=v["isNotificationView"];
        String jobId=k.toString();
        if(status==JobType.pending.value || status==JobType.approved.value){
          _newJobList.add(job);
        }else if(status==JobType.accepted.value){
          _newJobList.add(job);
          if(!isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.accepted.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(status==JobType.quoted.value){
          _newJobList.add(job);
          if(!isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.quoted.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(status==JobType.working.value){
          _newJobList.add(job);
          if(!isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.working.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(status==JobType.cancelled.value){
          _cancelledJobList.add(job);
          if(!isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.cancelled.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(status==JobType.completed.value){
          _completedJobList.add(job);
          if(!job.isPaid && job._paymentMethod.isEmpty){
            if(!isNotificationView) {
              Notifications.getList.add(Notifications(NotificationType.completed.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
            }
          }else if(job.isPaid && job.reviewId.isEmpty){
            if(!isNotificationView) {
              Notifications.getList.add(Notifications(NotificationType.thanks.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
            }
          }
          //Notifications.getList.add(Notifications(NotificationType.completed.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime));
        }



        // if(v["quotation"].toString().isEmpty){
        //   //quotation empty mean request of buyer maybe in pending, cancelled or accepted state from seller side
        //   String status=v["status"];
        //   if(status==JobType.pending.value){
        //     _newJobList.add(job);
        //   }else if(status==JobType.accepted.value || status==JobType.completed.value){
        //     _acceptedJobList.add(job);
        //   }else if(status==JobType.cancelled.value){
        //     _cancelledJobList.add(job);
        //   }else if(status==JobType.completed.value){
        //     _completedJobList.add(job);
        //   }
        // }else{
        //   //request of seller quotation maybe in pending, cancelled or accepted state from buyer side
        //   String status2=v["status2"];
        //   if(status2==JobType.pending.value){
        //     _acceptedJobList.add(job);
        //   }else if(status2==JobType.accepted.value){
        //     if(v["orderStatus"].toString()=="completed"){
        //       _completedJobList.add(job);
        //     }else{
        //       //before the completion of job, status will be accepted
        //       _acceptedJobList.add(job);
        //     }
        //   }else if(status2==JobType.cancelled.value){
        //     _cancelledJobList.add(job);
        //   }
        // }


     // });//foreach
  }

  static void jobChanged(String k,Map<dynamic,dynamic> v){
    String status=v["status"]!;
    String quotation=v["quotation"];
    bool isPaid=v["isPaid"];
    String sellerId=v["sellerId"];
    String jobId=k.toString();
    bool isNotificationView=v["isNotificationView"];
   print("job changed");
   print(v);
   // print(isPaid);
    Notifications.getList.clear();

    if(_completedJobList.isNotEmpty){
      for (var job in _completedJobList) {
        if(job.firebaseId==k){
          job.isPaid=isPaid;
          job.isNotificationView=isNotificationView;
        }
     //   print("completed jobsize ${_completedJobList.length}");
        if(job.status==JobType.completed.value && job.isPaid && job.reviewId.isEmpty){
        //  print("completed jobsize");
          if(!job.isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.thanks.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(job.status==JobType.completed.value && !job.isPaid && job.paymentMethod.isEmpty){
          if(!job.isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.completed.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }
      }
    }

      for (var a=0;a<_newJobList.length;a++) {
      var job = _newJobList[a];
      if(job.firebaseId==k){
        //changed job..............
        job.status=status;
        job.quotation=quotation;
        job.isPaid=isPaid;
        job.sellerId=sellerId;
        job.isNotificationView=isNotificationView;
        if(status==JobType.accepted.value){
          if(!job.isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.accepted.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(status==JobType.quoted.value){
        if(!job.isNotificationView) {
          Notifications.getList.add(Notifications(NotificationType.quoted.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
        }
        }else if(status==JobType.working.value){
          if(!job.isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.working.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(status==JobType.cancelled.value){
          if(!job.isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.cancelled.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
          _cancelledJobList.add(job);
          _newJobList.remove(job);
        }else if(status==JobType.completed.value){
          _completedJobList.add(job);
          _newJobList.remove(job);
          //again check if job completed but not paid yet
          if(!job.isPaid){
            if(!job.isNotificationView) {
              Notifications.getList.add(Notifications(NotificationType.completed.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
            }
          }else if(job.isPaid && job.reviewId.isEmpty){
            if(!job.isNotificationView) {
              Notifications.getList.add(Notifications(NotificationType.thanks.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
            }
          }
        }
      }else{
        //non changed job..............
        if(job.status==JobType.accepted.value){
          if(!job.isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.accepted.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(job.status==JobType.quoted.value){
          if(!job.isNotificationView) {
            Notifications.getList.add(Notifications(NotificationType.quoted.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(job.status==JobType.working.value){
          if(!job.isNotificationView){
            Notifications.getList.add(Notifications(NotificationType.working.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(job.status==JobType.completed.value && !job.isPaid){
          if(!job.isNotificationView){
            Notifications.getList.add(Notifications(NotificationType.completed.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }else if(job.isPaid && job.reviewId.isEmpty){
          if(!job.isNotificationView){
            Notifications.getList.add(Notifications(NotificationType.thanks.value,job.service,job.jobNo,job.buyerAddress,job.orderCreatedTime,jobId));
          }
        }
      }
    }

      //sort list of job on change

    if(status==JobType.cancelled.value){
      Job.cancelledJobList.sort((job1,job2){
       return DateTime.parse(job1.orderCreatedTime).isBefore(DateTime.parse(job2.orderCreatedTime))? 1:0;
      });
    }else if(status==JobType.completed.value){
      Job.completedJobList.sort((job1,job2){
        return DateTime.parse(job1.orderCreatedTime).isBefore(DateTime.parse(job2.orderCreatedTime))? 1:0;
      });
    }else{
      Job.newJobList.sort((job1,job2){
        return DateTime.parse(job1.orderCreatedTime).isBefore(DateTime.parse(job2.orderCreatedTime))? 1:0;
      });
    }


  }

  String _firebaseId="";
  String _jobNo="";
  String _buyerId="";
  String _buyerName="";
  String _buyerAddress="";
  String _sellerId="";
  String _sellerName="";
  String _sellerAddress="";
  String _status="";
  String _quotation="";
  String _orderCreatedTime="";
  String _orderDeliveryTime="";
  String _service="";
  String _paymentMethod="";
  String _paymentAmount="";
  bool _isPaid=false;
  bool _isNotificationView=false;
  String _reviewId="";
  String _type="";


  String get reviewId => _reviewId;

  bool get isPaid => _isPaid;

  String get firebaseId => _firebaseId;

  String get jobNo => _jobNo;

  String get buyerId => _buyerId;

  String get paymentAmount => _paymentAmount;

  String get paymentMethod => _paymentMethod;

  String get service => _service;

  String get orderDeliveryTime => _orderDeliveryTime;

  String get orderCreatedTime => _orderCreatedTime;

  String get quotation => _quotation;

  String get status => _status;

  String get sellerAddress => _sellerAddress;

  String get sellerName => _sellerName;

  String get sellerId => _sellerId;

  String get buyerAddress => _buyerAddress;

  String get buyerName => _buyerName;

  bool get isNotificationView => _isNotificationView;

  set isNotificationView(bool value) {
    _isNotificationView = value;
  }

  String get type => _type;

  set status(String value) {
    _status = value;
  }
   set reviewId(String value) {
    _reviewId= value;
  }

  set quotation(String value) {
    _quotation = value;
  }

  set paymentAmount(String value) {
    _paymentAmount = value;
  }

  set paymentMethod(String value) {
    _paymentMethod = value;
  }

  set isPaid(bool value) {
    _isPaid = value;
  }

  set sellerId(String value) {
    _sellerId = value;
  }
}


enum JobType{
  pending,
  accepted,
  quoted,
  approved,
  working,
  cancelled,
  completed
}

extension JobStatus on JobType{
  static const status=["pending","accepted","quoted","approved","working","cancelled","completed"];
  String get value => status[index];
}