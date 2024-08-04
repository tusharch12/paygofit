import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageCard extends StatelessWidget {
  String imageurl;
  String name ;
  String address;
  int price;
  ImageCard({required this.name, required this.address, required this.price ,required this.imageurl ,super.key});


  Future<String> _getImageUrl() async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child(imageurl);
      return await storageReference.getDownloadURL();
    } catch (e) {
      print('Error retrieving image URL: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
// padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: MediaQuery.of(context).size.height * 0.41,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
      
        border: Border.all(color: Colors.grey, width: 1),
        color: Colors.white,  
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
     FutureBuilder<String>(
        future: _getImageUrl(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
              child: Center(child: Text('No image found.')));
          } else {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  snapshot.data!,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            );
          }
        },
      ),
    
          SizedBox(height: 5,),
          Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                      Text(name ,style: TextStyle(
                        fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
               SizedBox(height: 7,),
          Text(address),

          const Divider(
          color: Colors.grey,
          thickness: 0.8,
        ), 
        Row(
          children: [
            Text("Rs ${price.toString()} / session", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
          Spacer(),
            TextButton(onPressed: (){}, child: Text('Book Slot' , style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold
            ),))
          ],
        ) 
            ],
          ),)
          
  
         
                
        ]
      ),
    );
  }
}