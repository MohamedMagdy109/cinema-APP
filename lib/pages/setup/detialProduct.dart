import 'package:ecproject/pages/setup/seats.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecproject/pages/home.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class detialProduct extends StatefulWidget {
  DocumentSnapshot document;
  detialProduct({this.document});

  @override
  _detialProductState createState() =>
      _detialProductState(curdocument: document);
}

class _detialProductState extends State<detialProduct> {
  CollectionReference add =
      Firestore.instance.collection("notification"); //////// firebase ref
  var quantity;
  String name;
  int proQuantity;
  //int value1,value2;
  String imageUrl;
///////////////////////////////////////
  var colort = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  int i;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for (i = 0; i < 73; i++) {
    //   setState(() {
    //     colort.add('Colors.white');
    //   });
    // }
    print(colort.length);
    print('////////////////////////////////////////////');
  }
//////////////////////////////////////////////////

  DocumentSnapshot curdocument;
  _detialProductState({this.curdocument});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("product is " + curdocument["Title"]),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("vendor").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> docs) {
            var arr = docs.data.documents
                .where((test) => test.documentID == curdocument.documentID)
                .toList();
            print('our array is :$arr');
            if (docs.hasError) return Text("Error");
            if (docs.hasData != true) return Text("No movies Added");
            if (docs.connectionState == ConnectionState.waiting)
              return SpinKitChasingDots(
                size: 20,
              );
            return Container(
              margin: EdgeInsets.all(20),
              // child: ListView(
              //   children: arr.map((document) {
              //     return InkWell(
              //        child: ListTile(
              //            title: Text("the price is "+document["price"]),
              //            subtitle: Text("the Quantity is "+document["quantity"]),
              //            trailing: IconButton(
              //              icon: Icon(Icons.add), onPressed: () {},
              //               )
              //               ),
              //               );
              //               }).toList(),
              // ),

              child: ListView(
                children: arr.map((document) {
                  return InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Image.network(document["image"]),
                        ),
                        Text("name :" + document["Title"]),
                        Text("description :" + document["Description"]),
                        Text("the numper of seats is :" + document["seats"]),
                        Text("Time :" + document["movie datetime"]),
                        FlatButton(
                          child: Text('seats'),
                          textColor: Colors.blue,
                          onPressed: () {
                            print(colort.length);
                            print(document["bookedSeates"]);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return seats(
                                  document: document,
                                  bookedSeates: document["bookedSeates"],
                                  secArr: document["bookedSeates"],
                                  colort: colort);
                            }));
                          },
                        ),
                        FlatButton(
                          child: Text('submit'),
                          textColor: Colors.blue,
                          onPressed: () {
                            dialogTigger(context);
                            this.name = document["Title"];

                            print(this.proQuantity);
                            print(this.quantity);
                            print(this.name);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ));
  }
  // Future checkQuantity() async {
  //   if(quantity <= proQuantity ){
  //                   ///quantity enter by user
  //                   /// print("okkkkkkkk");
  //                   add.document().setData({
  //                 "title": this.name,
  //                 "quantity": this.quantity,
  //               }).then((data){
  //                Navigator.of(context).pop(true);
  //               });

  //                   // update new quantity

  //                 }else{

  //                  // there is not enough quantity in the store
  //                  quantitytrigger(context);

  //                 }
  //               }

  Future<bool> dialogTigger(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            // title: new Text(
            //   '',
            //   style: TextStyle(fontSize: 15.0),
            // ),
            // content: Column(
            //   children: <Widget>[
            title: Text('are you sure you want to complete the reservations'),
            // TextField(
            //   decoration:
            //       InputDecoration(hintText: 'Enter num of  Quantity '),
            //   onChanged: (value) {
            //     this.quantity = value; // this.
            //   },
            // ),
            //   ],
            // ),
            actions: <Widget>[
              new FlatButton(
                  child: new Text('submit'),
                  textColor: Colors.blue,
                  onPressed: () async {
                    // checkQuantity();
                    add.document().setData({
                      "title": this.name,
                      // "quantity": this.quantity,
                    }).then((data) {
                      Navigator.of(context).pop(true);
                      Toast.show("Done", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    });
                  })
            ],
          );
        });
  }

// Future<bool>quantitytrigger(BuildContext context){
//   return showDialog(
//     barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context){
//         return new AlertDialog(
//           title: new Text('', style: TextStyle(fontSize: 15.0),),
//           content: Text('there is not enough quantity in the store'),
//           actions: <Widget>[
//             new FlatButton(
//               child: new Text('ok'),
//               textColor: Colors.blue,
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       }
//   );
// }

} //end of class
