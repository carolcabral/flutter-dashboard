import 'package:app/constants.dart';
import 'package:flutter/material.dart';

import '../screens/components/chart_info_card.dart';

class PlantsInfo {
  final String? name, location;
  PlantsInfo(this.name, this.location);
}

enum DeviceState { on, off, cleaning }
enum Status { healthy, warning, critical }
enum BatteryStatus { full, low, empty, connected, charging }

class DeviceInfo {
  final String name;
  final DeviceState state;
  final Status status;
  final BatteryStatus battery_status;
  final bool isFavorite;

  DeviceInfo(
      {required this.name,
      required this.state,
      required this.status,
      required this.battery_status,
      required this.isFavorite});
}

List userPlants = [
  PlantsInfo("Distribuidora Central Gyn", "Brazil, Goiânia"),
  PlantsInfo("Doce Delícia Confeitaria", "Brazil, Anápolis"),
  PlantsInfo("EGD Energia - Carport", "Brazil, Inhumas"),
  PlantsInfo("Goiás ALimentos", "Brazil, Inhumas")
];

List userDevices = [
  DeviceInfo(
      name: "Protótipo 1",
      state: DeviceState.on,
      status: Status.healthy,
      battery_status: BatteryStatus.full,
      isFavorite: true),
  DeviceInfo(
      name: "Protótipo 2",
      state: DeviceState.off,
      status: Status.critical,
      battery_status: BatteryStatus.low,
      isFavorite: false),
  DeviceInfo(
      name: "Protótipo 3",
      state: DeviceState.cleaning,
      status: Status.healthy,
      battery_status: BatteryStatus.connected,
      isFavorite: true),
  DeviceInfo(
      name: "Protótipo 4",
      state: DeviceState.on,
      status: Status.warning,
      battery_status: BatteryStatus.charging,
      isFavorite: false),
];

List userFavorites = [
  DeviceInfo(
      name: "Protótipo 2",
      state: DeviceState.off,
      status: Status.critical,
      battery_status: BatteryStatus.empty,
      isFavorite: false),
  DeviceInfo(
      name: "Protótipo 3",
      state: DeviceState.cleaning,
      status: Status.healthy,
      battery_status: BatteryStatus.connected,
      isFavorite: true),
  DeviceInfo(
      name: "Protótipo 4",
      state: DeviceState.on,
      status: Status.warning,
      battery_status: BatteryStatus.charging,
      isFavorite: false),
];

class ChartInfo {
  final String? title; //Plant / Device
  final double? total, healthy, warning, critical;

  ChartInfo(
      {this.title, this.total, this.healthy, this.warning, this.critical});
}
