import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Icon(Icons.check_circle_rounded, color: Colors.green)

//              icon: Icon(Icons.warning_rounded, color: Colors.yellow)),
//              icon: Icon(Icons.error, color: Colors.red)),

class ChartInfoCard extends StatelessWidget {
  final String title; //, svgSrc, amountOfFiles;
  final double quantity, percentage;
  final Icon icon;
  //final Color color;

  const ChartInfoCard({
    Key? key,
    required this.title,
    required this.quantity,
    required this.percentage,
    required this.icon,
    //required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: icon,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$quantity devices",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          Text("$percentage %"),
        ],
      ),
    );
  }
}
