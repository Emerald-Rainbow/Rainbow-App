import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardsPost1 extends StatefulWidget {
  final String documentId;

  CardsPost1(this.documentId);

  @override
  State<CardsPost1> createState() => _CardsPost1State();
}

class _CardsPost1State extends State<CardsPost1> {
  bool pressAttention = false;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('blogs');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Card(
            clipBehavior: Clip.antiAlias,
            elevation: 8,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://lwlies.com/wp-content/uploads/2017/04/avatar-2009.jpg'),
                  ),
                  title: Text(
                    '${data['title']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    '${data['author']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    '${data['content']}',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: Image.asset(
                    'assets/images/img1.jpg',
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share),
                    ),
                    IconButton(
                        onPressed: () =>
                            setState(() => pressAttention = !pressAttention),
                        icon: pressAttention
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_border)),
                  ],
                ),
              ],
            ),
          );
        }
        return Text("loading");
      },
    );
  }
}
