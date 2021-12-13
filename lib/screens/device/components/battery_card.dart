import 'package:app/constants.dart';
import 'package:app/models/MyFiles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/Models.dart';

class BatteryCard extends StatelessWidget {
  final BatteryStatus? status;

  static const IconData battery_full =
      IconData(0xf240, fontFamily: "Glyphs", fontPackage: null);
  static const IconData battery_quarter =
      IconData(0xf243, fontFamily: "Glyphs", fontPackage: null);
  static const IconData battery_empty =
      IconData(0xf244, fontFamily: "Glyphs", fontPackage: null);

  const BatteryCard({
    Key? key,
    this.status,
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
                "Battery",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              /*Container(
                padding: const EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: info.color?.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(info.svgSrc!, color: info.color),
              ),*/
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: getIcon(status!),
          ),
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

  getIcon(BatteryStatus state) {
    Icon icon = (state == BatteryStatus.full)
        ? const Icon(battery_full, color: Colors.green)
        : (state == BatteryStatus.low)
            ? const Icon(battery_quarter, color: Colors.yellow)
            : (state == BatteryStatus.empty)
                ? const Icon(battery_empty, color: Colors.grey)
                : (state == BatteryStatus.charging)
                    ? Icon(Icons.battery_charging_full)
                    : (state == BatteryStatus.connected)
                        ? Icon(Icons.cable_rounded)
                        : Icon(Icons.error);

    String title = (state == BatteryStatus.full)
        ? "Full"
        : (state == BatteryStatus.low)
            ? "Low"
            : (state == BatteryStatus.empty)
                ? "Empty"
                : (state == BatteryStatus.charging)
                    ? "Charging"
                    : "Connected";

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: icon,
          )
        ]);
  }
  //String get_text(info)
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 5,
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
        )
      ],
    );
  }
}
