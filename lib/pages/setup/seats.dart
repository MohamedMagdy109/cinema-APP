//import 'dart:html';
import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class seats extends StatefulWidget {
  DocumentSnapshot document;
  var bookedSeates;
  var secArr;
  var colort;
  seats({this.document, this.bookedSeates, this.colort, this.secArr});
  @override
  _seatsState createState() => _seatsState(curdocument: document);
}

class _seatsState extends State<seats> {
  CollectionReference add = Firestore.instance.collection("vendor");
  var quantity;
  String name;
  int proQuantity;
  //int value1,value2;
  String imageUrl;
  // var colort;
  // int i;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   for (i = 0; i < 73; i++) {
  //     setState(() {
  //       colort[i].add(Colors.white);
  //     });
  //   }
  // }

  var l = [0, 0, 0];

  DocumentSnapshot curdocument;
  _seatsState({this.curdocument});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(curdocument["Title"]),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Firestore.instance
                    .collection('vendor')
                    .document(widget.document.documentID)
                    .updateData({
                  'bookedSeates': widget.secArr,
                }).then((value) {
                  Toast.show("Done", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                });
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 7,
            scrollDirection: Axis.vertical,
            children: List.generate(47, (index) {
              return (widget.bookedSeates[index] == 1)
                  ? Center(
                      /////////////////////////////////////////////////////////////////
                      child: InkWell(
                        onTap: () {
                          Toast.show("already booked", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.grey, width: 3.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(16.0),
                        ),
                      ),
                    )
                  : Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.colort[index] = Color(0xff4caf50);
                            // widget.bookedSeates[index] = 1;
                            widget.secArr[index] = 1;
                            print(widget.colort);
                            print('colorssssssssssssssssssssssss');
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // color: (widget.colort[index] == null)
                            //     ? Colors.white
                            //     : widget.colort[index],
                            color: widget.colort[index],
                            border: Border.all(color: Colors.grey, width: 1.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(16.0),
                        ),
                      ),
                    );
            }),
          ),
        ));
  }
} //end of class
