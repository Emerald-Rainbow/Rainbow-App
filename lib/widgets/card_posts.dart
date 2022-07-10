import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html/flutter_html.dart';

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
          return Text("Loading");
        }
        return SingleChildScrollView(
          child: Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              var htmlData = {data['content']};
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                semanticContainer: true,
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
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 7),
                      child: Container(
                        height: 200,
                        child: Html(
                          data: '${data['content']}',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7),
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
