import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Models/job_model.dart';
import 'package:mutwaffer_user/Models/review_model.dart';

class MyAlertDialog{

  void showJobCompleted(BuildContext context,String message,String amount,Job job){
    showDialog(context: context,
        builder: (contxt){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: Constant.tilelefttext)),
            title:  Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Constant.tilelefttext)
              ),
              child: Center(child: Text("Job Completed",style: TextStyle(color: Constant.tilelefttext),)),
            ),
            content: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Job Detail:",style: TextStyle(color: Constant.tilelefttext),),
                  Text(job.quotation.isNotEmpty? job.quotation.split("+plus")[1] : "",maxLines:2,style: const TextStyle(fontSize: 14,),),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text("Kindly Pay Now",style: TextStyle(color: Constant.tilelefttext,fontSize: 14),)),
                      Text("RO ${job.quotation.isNotEmpty? job.quotation.split("+plus")[0] : ""}",style: const TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //const SizedBox(width: 10,),
                      ElevatedButton(onPressed: () async{
                        showDialog(
                            context: context, barrierDismissible: false, builder: (context) {
                          return AlertDialog(
                            title: const Text("Please wait"),
                            content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator()
                                ]
                            ),
                          );
                        });

                        bool hasConnection = await InternetConnectionChecker().hasConnection;
                        if(!hasConnection){
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Internet Access...")));
                          return;
                        }
                        amount=job.quotation.split("+plus")[0];
                        FirebaseDatabase.instance.ref("orders")
                            .child(job.firebaseId)
                            .update({"paymentMethod":"cash","paymentAmount":amount})
                            .then((value){
                          job.paymentMethod="cash";
                          //amount=job.quotation.split("+plus")[0];
                          job.paymentAmount=amount;
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please pay RO ${amount} by hand.")));
                        });
                        }, child: const Text("Cash"),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                            backgroundColor: MaterialStateProperty.all(Constant.white),
                            elevation: MaterialStateProperty.all(5),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(side: const BorderSide(color: Colors.amber),borderRadius: BorderRadius.circular(5)))
                        ),
                      ),
                      //   const Expanded(child: SizedBox()),
                      ElevatedButton(onPressed: () async{
                        showDialog(
                            context: context, barrierDismissible: false, builder: (context) {
                          return AlertDialog(
                            title: const Text("Please wait"),
                            content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator()
                                ]
                            ),
                          );
                        });
                        bool hasConnection = await InternetConnectionChecker().hasConnection;
                        if(!hasConnection){
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Internet Access...")));
                          return;
                        }
                        if(double.parse(Seller().balance)>=double.parse( job.quotation.split("+plus")[0])){
                         //if balance available then pay for this order...
                          amount=job.quotation.split("+plus")[0];
                          job.paymentMethod="wallet";
                          job.paymentAmount=amount;
                          FirebaseDatabase.instance.ref("orders")
                              .child(job.firebaseId)
                              .update({"paymentMethod":"wallet","paymentAmount":amount})
                              .then((value){
                                //add transaction record on success
                            var map = {"owner_id":Seller().userId,"transfer_to":job.sellerId,"type":"used","jobNo":job.jobNo,"date":DateTime.now().toString(),"amount":amount};
                            FirebaseDatabase.instance.ref("transaction").push().update(map).then((value){
                              //user seller balance
                              var ref = FirebaseDatabase.instance.ref("sellers").child(job.sellerId);
                                  ref.once().then((event){
                                    DataSnapshot snapshot = event.snapshot;
                                    Map<dynamic,dynamic> user = snapshot.value as Map<dynamic,dynamic>;
                                    String balance = user["balance"].toString();
                                    var totalBalance = double.parse(balance)+double.parse(amount);
                                    var newEarnedBalance=double.parse(user["earned"])+double.parse(amount);
                                    ref.update({"balance":totalBalance.toString(),"earned":newEarnedBalance.toString()});
                                 //update buyer balance
                                    var buyerBalance=double.parse(Seller().balance);
                                    var orderAmount=double.parse(amount);
                                    var newBalance=buyerBalance-orderAmount;
                                    var usedBalance=double.parse(Seller().used);
                                    var newUsedBalance=usedBalance+orderAmount;
                                    FirebaseDatabase.instance.ref("users").child(job.buyerId).update({"balance":newBalance.toString(),"used":newUsedBalance.toString()})
                                        .then((value){
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment paid...")));
                                    });

                              });
                             
                            });
                          });
                        }else{
                          print('no money');
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You have insufficient money.Please add balance or pay in cash.")));
                          Navigator.pop(context);
                          Navigator.pop(context);
                          topUpAlertDialog(context);
                        }
                       },
                        child: const Text("Wallet"),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                            backgroundColor: MaterialStateProperty.all(Constant.white),
                            elevation: MaterialStateProperty.all(5),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: Constant.primaryColor),borderRadius: BorderRadius.circular(5)))
                        ),
                      ),
                      // const SizedBox(width: 10,),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showThankYou(BuildContext context,Job job){
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: Constant.tilelefttext)),
            title:  Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Constant.tilelefttext)
              ),
              child: Center(child: Text("Thank You",style: TextStyle(color: Constant.tilelefttext),)),
            ),
            content: SizedBox(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment has been received and receipt was sent to your WhatsApp and Email.",textAlign: TextAlign.center,
                    style: TextStyle(color: Constant.tilelefttext),),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text("Received with Thanks",style: TextStyle(color: Constant.primaryColor,fontSize: 14),)),
                      Text("RO ${job.quotation.split("+plus")[0]}",style: const TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        showRatingDialog(context, job);
                      },
                      child: const Text("OK"),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 50)),
                          backgroundColor: MaterialStateProperty.all(Constant.white),
                          elevation: MaterialStateProperty.all(5),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: Constant.primaryColor),borderRadius: BorderRadius.circular(5)))
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showRatingDialog(BuildContext context,Job job){
    var _textController = TextEditingController();
    double rating=1.0;
    showDialog(context: context,barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: Constant.tilelefttext)),
            content: SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(backgroundColor: Constant.tilelefttext,child: Text("Pic")),
                        const SizedBox(width: 5,),
                        Flexible(
                          child: Column(
                            children: [
                              Text("Job# ${job.jobNo}",style:TextStyle(fontWeight: FontWeight.bold,color: Constant.tilelefttext,fontSize: 20),),
                              Text(job.buyerName,style:TextStyle(fontSize: 14),),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Center(
                      child: Text("Customer Behavior",
                        style: TextStyle(color: Constant.tilelefttext),),
                    ),
                    const SizedBox(height: 15,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     GestureDetector(onTap: (){}, child: const Icon(Icons.star),),
                    //     GestureDetector(onTap: (){}, child: const Icon(Icons.star),),
                    //     GestureDetector(onTap: (){}, child: const Icon(Icons.star),),
                    //     GestureDetector(onTap: (){}, child: const Icon(Icons.star),),
                    //     GestureDetector(onTap: (){}, child: const Icon(Icons.star),),
                    //   ],
                    // ),
                    RatingBar.builder(
                      initialRating: 1.0,
                      minRating: 1,
                      allowHalfRating: true,
                      itemSize: 32,
                      itemBuilder: (context,_){
                        return Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      onRatingUpdate: (star) {
                        rating=star;
                        print(rating);
                      },
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _textController,
                      //  autofocus: true,
                      maxLines: 3,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          hintText: "Enter customer behavior",
                          border: InputBorder.none
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context, barrierDismissible: false, builder: (context) {
                            return AlertDialog(
                              title: const Text("Please wait"),
                              content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CircularProgressIndicator()
                                  ]
                              ),
                            );
                          });
                          bool hasConnection = await InternetConnectionChecker().hasConnection;
                          if(!hasConnection){
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Internet Access...")));
                            return;
                          }
                          if(_textController.text.length<=1){
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter long review")));
                          }else{
                            var map = { "by":Seller().userId,
                              "to":job.sellerId,
                              "name":Seller().fullName,
                              "comment":_textController.text,
                              "star":rating.toString(),
                              "service":job.jobNo };

                           var reviewRef= FirebaseDatabase.instance.ref("reviews")
                                .push();
                                String id = reviewRef.key!;
                                job.reviewId = id;
                             
                                reviewRef.update(map)
                              
                                .then((value){
                                     
                                  DatabaseReference ref = FirebaseDatabase.instance.ref("orders").child(job.firebaseId);
                    ref.update({"userReviewId":id});




                                  Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Review Submitted")));
                            });

                          }
                        },
                        child: const Text("Submit"),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 50)),
                            backgroundColor: MaterialStateProperty.all(Constant.white),
                            elevation: MaterialStateProperty.all(5),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: Constant.primaryColor),borderRadius: BorderRadius.circular(5)))
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void topUpAlertDialog(BuildContext context){
    showDialog(context: context,
        builder: (contxt){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: Constant.tilelefttext)),
            content: SizedBox(
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to Top Up your Wallet now?",style: TextStyle(color: Constant.tilelefttext),),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //const SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                            backgroundColor: MaterialStateProperty.all(Constant.white),
                            elevation: MaterialStateProperty.all(5),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: Colors.amber),borderRadius: BorderRadius.circular(5)))
                        ),
                      ),
                      //   const Expanded(child: SizedBox()),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context,"/topup");
                        },
                        child: const Text("Yes"),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                            backgroundColor: MaterialStateProperty.all(Constant.white),
                            elevation: MaterialStateProperty.all(5),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: Constant.primaryColor),borderRadius: BorderRadius.circular(5)))
                        ),
                      ),
                      // const SizedBox(width: 10,),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
