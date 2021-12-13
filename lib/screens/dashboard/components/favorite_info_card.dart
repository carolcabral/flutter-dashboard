import 'package:app/constants.dart';
import 'package:app/models/MyFiles.dart';
import 'package:app/screens/device/device_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/Models.dart';

class FavoriteInfoCard extends StatelessWidget {
  const FavoriteInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final DeviceInfo info;

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
                  info.name,
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
                IconButton(
                  icon: Icon(
                      info.isFavorite ? Icons.star : Icons.star_border_outlined,
                      color: Colors.white54),
                  onPressed: () {},
                )
                //star_rounded
              ],
            ),
            Row(
              children: [
                getStateIcon(info.state),
                getStatusIcon(info.status),
                getBatteryIcon(info.battery_status)
              ],
            ),
            Text(
              "Last updated in: ontem",
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }

  static const IconData battery_full =
      IconData(0xf240, fontFamily: "Glyphs", fontPackage: null);
  static const IconData battery_quarter =
      IconData(0xf243, fontFamily: "Glyphs", fontPackage: null);
  static const IconData battery_empty =
      IconData(0xf244, fontFamily: "Glyphs", fontPackage: null);

  getBatteryIcon(BatteryStatus state) {
    return (state == BatteryStatus.full)
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
  }

  getStateIcon(DeviceState state) {
    return (state == DeviceState.off)
        ? Icon(Icons.toggle_off, size: 40, color: Colors.grey)
        : (state == DeviceState.on)
            ? Icon(Icons.toggle_on, size: 40)
            : (state == DeviceState.cleaning)
                ? Icon(Icons.cleaning_services_rounded, size: 40)
                : Icon(Icons.error);
  }

  getStatusIcon(Status state) {
    return (state == Status.healthy)
        ? Icon(Icons.check_circle_rounded, color: Colors.green, size: 40)
        : (state == Status.critical)
            ? Icon(Icons.error, size: 40, color: Colors.red)
            : (state == Status.warning)
                ? Icon(Icons.warning_rounded, size: 40, color: Colors.yellow)
                : Icon(Icons.error);
  }
}
