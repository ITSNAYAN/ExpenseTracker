import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

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
    ThemeData color = Theme.of(context);
    // Con().callApi();
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // setting option
          SlidableAction(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            onPressed: onEditPressed,
            icon: Icons.edit,
            backgroundColor: Colors.blue,
            borderRadius: BorderRadius.circular(24),
            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
            foregroundColor: Colors.white,
          ),
          SizedBox(width: 3),
          // delete option
          SlidableAction(
            onPressed: onDeletePressed,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(24),
            // padding: const EdgeInsets.symmetric(horizontal: 15.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8.0, bottom: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.grey.shade300, // soft minimal color
              width: 0.5, // minimal border width
            ),
            color: color.colorScheme.secondary,
          ),
          child: ListTile(

            leading: Container(
              height: 25,
              width: 75,
              decoration: BoxDecoration(
                color: color.colorScheme.primary,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.grey.shade300, // soft minimal color
                  width: 0.5, // minimal border width
                ),
              ),
                child: Center(child: Text(leading, style: GoogleFonts.saira(color: color.colorScheme.secondary)))),
            title: Center(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.saira(color: color.colorScheme.primary,fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            trailing: Container(
              height: 25,
              width: 75,
              decoration: BoxDecoration(
                color: color.colorScheme.primary,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.grey.shade300, // soft minimal color
                  width: 0.5, // minimal border width
                ),
              ),
              child: Center (
                child: Text(
                  trailing,
                  style: GoogleFonts.saira(color: color.colorScheme.secondary,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

