import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;

  UserProductItem(this.title, this.id, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, // REMOVE LATER FOR EDIT BUTTON
          children: [
            // ADD UPDATE FUNCTIONALITY FROM LECTURE 237!!!!!
            // IconButton(
            //   icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            //   onPressed: () {},
            // ),
            IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).errorColor,),
              onPressed: () {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              },
            ),

          ],
        ),
      ),
    );
  }
}
