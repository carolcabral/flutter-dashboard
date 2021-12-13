import 'package:app/constants.dart';
import 'package:app/models/MyFiles.dart';
import 'package:app/screens/device/components/device_stats.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/Models.dart';

class DeviceStateCard extends StatelessWidget {
  final DeviceState state;

  const DeviceStateCard({
    Key? key,
    required this.state,
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
                "Status",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Container(alignment: Alignment.center, child: getIcon(state)),
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

  Row getIcon(DeviceState state) {
    Icon icon = (state == DeviceState.off)
        ? Icon(Icons.toggle_off, size: 40, color: Colors.grey)
        : (state == DeviceState.on)
            ? Icon(Icons.toggle_on, size: 40)
            : (state == DeviceState.cleaning)
                ? Icon(Icons.cleaning_services_rounded, size: 40)
                : Icon(Icons.error);

    String title = (state == DeviceState.off)
        ? "Off"
        : (state == DeviceState.on)
            ? "On"
            : "Cleaning";

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
