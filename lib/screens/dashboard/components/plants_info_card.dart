import 'package:app/constants.dart';
import 'package:app/screens/plant/plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/Models.dart';

//Icon(Icons.check_circle_rounded, color: Colors.green)

//              icon: Icon(Icons.warning_rounded, color: Colors.yellow)),
//              icon: Icon(Icons.error, color: Colors.red)),

class PlantsInfoCard extends StatelessWidget {
  final PlantsInfo info;

  static const IconData solar_panel =
      IconData(0xf5ba, fontFamily: "Glyphs", fontPackage: null);

  const PlantsInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlantPage(name: info.name)),
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
            const Icon(solar_panel),
            //SizedBox(height: 20, width: 20, child: icon),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      info.location!,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            //Text("$percentage %"),
          ],
        ),
      ),
    );
  }
}
