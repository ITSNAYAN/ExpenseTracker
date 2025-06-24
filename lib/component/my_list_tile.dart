import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../core/helperFunction/convert_function.dart';

class MyListTile extends StatelessWidget {
  final String trailing;
  final String leading;
  final String title;
  final void Function(BuildContext)? onEditPressed;
  final void Function(BuildContext)? onDeletePressed;

  MyListTile({
    super.key,
    required this.trailing,
    required this.leading,
    required this.title,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // setting option
          SlidableAction(
            onPressed: onEditPressed,
            icon: Icons.edit,
            backgroundColor: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
            foregroundColor: Colors.white,
          ),
          SizedBox(width: 3,),
          // delete option
          SlidableAction(
            onPressed: onDeletePressed,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(10),
            // padding: const EdgeInsets.symmetric(horizontal: 15.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.15,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
            color: Colors.transparent,
          ),
          child: ListTile(

            leading: Text(leading),
            title: Center(child: Text(title,maxLines: 1,overflow:TextOverflow.ellipsis,)),
            trailing: Text(trailing,textAlign: TextAlign.end,),
          ),
        ),
      ),
    );
  }
}
