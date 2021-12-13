import 'package:app/constants.dart';
import 'package:app/screens/device/device_screen.dart';
import 'package:app/screens/plant/plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/Models.dart';

//Icon(Icons.check_circle_rounded, color: Colors.green)

//              icon: Icon(Icons.warning_rounded, color: Colors.yellow)),
//              icon: Icon(Icons.error, color: Colors.red)),

class DevicesCard extends StatelessWidget {
  final DeviceInfo info;

  static const IconData robot =
      IconData(0xf544, fontFamily: "Glyphs", fontPackage: null);

  const DevicesCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DevicePage(info: info)),
        );
      },
      child: Container(
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
            const Icon(robot),
            //SizedBox(height: 20, width: 20, child: icon),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      info.status.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Icon(info.isFavorite ? Icons.star : Icons.star_border_outlined),
          ],
        ),
      ),
    );
  }
}
