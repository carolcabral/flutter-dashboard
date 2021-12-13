import 'package:app/constants.dart';
import 'package:app/models/MyFiles.dart';
import 'package:app/screens/device/components/device_stats.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/Models.dart';

class DeviceStatusCard extends StatelessWidget {
  final Status stats;

  const DeviceStatusCard({
    Key? key,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Diagnostics",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Container(alignment: Alignment.center, child: getIcon(stats)),
          Text(
            "Last updated: ontem",
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Row getIcon(Status state) {
    Icon icon = (state == Status.healthy)
        ? Icon(Icons.check_circle_rounded, color: Colors.green, size: 40)
        : (state == Status.critical)
            ? Icon(Icons.error, size: 40, color: Colors.red)
            : (state == Status.warning)
                ? Icon(Icons.warning_rounded, size: 40, color: Colors.yellow)
                : Icon(Icons.error);

    String title = (state == Status.healthy)
        ? "Healthy"
        : (state == Status.critical)
            ? "Critical"
            : "Warning";

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: icon,
        )
      ],
    );
  }
  //String get_text(info)
}


//Icon(Icons.check_circle_rounded, color: Colors.green)

//              icon: Icon(Icons.warning_rounded, color: Colors.yellow)),
//              icon: Icon(Icons.error, color: Colors.red)),

