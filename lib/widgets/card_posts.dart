import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardsPost extends StatefulWidget {
  @override
  _CardsPostState createState() => _CardsPostState();
}

class _CardsPostState extends State<CardsPost> {
  bool pressAttention = false;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('blogs').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("loading");
        }
        return SingleChildScrollView(
          child: Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Card(
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${data['authorPic']}'),
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        child: Text(
                          '${data['title']}',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(bottom: 7),
                        child: Text(
                          '${data['author']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Text(
                        '${data['content']}',
                        overflow: TextOverflow.ellipsis,
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
                            onPressed: () => setState(
                                () => pressAttention = !pressAttention),
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
            }).toList(),
          ),
        );
      },
    );
  }
}
