import 'dart:convert';
/*

D:\PROJECTS\python\cbes

python inverter_mqtt.py

*/

final Map inverterData = {
  "main_data": {
    "input_voltage": "230V",
    "output_voltage": "230V",
    "input_frequency": "50Hz",
    "pv_voltage": "260V",
    "pv_current": "2.5A",
    "pv_power": "500W",
    "ac_and_pv_charging_current": "50A",
    "ac_charging_current": "50A",
    "pv_charging_current": "50A",
  },
  "fault_reference_code": "f02",
  "warning_indicator": "06",
  "operation_modes": {
    // OPERATION MODES
    /*Note: Standby mode:
The inverter is not turned on yet but at this
time, the inverter can charge
battery without AC output.

No output is supplied by the
unit but it still can charge
batteries.
*/
    "standby_mode": {
      "charging_by_utility_and_pv_energy": "true",
      "charging_by_utility": "false",
      "charging_by_pv_energy": "false",
      "no_charging": "false",
    },

    /*
  Note: Fault mode:
Errors are
caused by inside circuit error
or external reasons such as
over temperature, output short
circuited and so on.

PV energy and utility can charge batteries.
   */
    "fault_mode": {
      "charging_by_utility_and_pv_energy": "true",
      "charging_by_utility": "false",
      "charging_by_pv_energy": "false",
      "no_charging": "false",
    },

    /*
  The unit will provide output
power from the mains . It will
also charge the battery at
line mode.
*/
    "line_mode": {
      "charging_by_utility_and_pv_energy": "true",
      "charging_by_utility": "false",
      "solar_energy_not_sufficient": "false",
      "battery_not_connected": "false",
      "power_from_utility": "false",
    },

/*
The unit will provide output
power from battery and /or PV power.*/
    "battery_mode": {
      "power_from_battery_and_pv_energy": "true",
      "pv_energy_to_loads_and_charge_battery_no_utility": "false",
      "power_from_battery": "false",
      "power_from_pv_energy": "false",
    },
  }
};

String faultReferenceCode(String code) {
  var faultEvent = "null";
  switch (code) {
    case "F01":
      faultEvent = "Fan is locked when inverter is off.";
      break;
    case "F02":
      faultEvent = "Over temperature";
      break;
    case "F03":
      faultEvent = "Battery voltage is too high";
      break;
    case "F04":
      faultEvent = "Battery voltage is too low";
      break;
    case "F05":
      faultEvent = """
      Output short circuited or over temperature is detected by
internal converter components.""";
      break;
    case "F06":
      faultEvent = "Output voltage is too high";
      break;
    case "F07":
      faultEvent = "Overload time out";
      break;
    case "F08":
      faultEvent = "Bus voltage is too high";
      break;
    case "F09":
      faultEvent = "Bus soft start failed";
      break;
    case "F51":
      faultEvent = "Over current or surge";
      break;
    case "F52":
      faultEvent = "Bus voltage is too low";
      break;
    case "F53":
      faultEvent = "Inverter soft start failed";
      break;
    case "F55":
      faultEvent = "Over DC voltage in AC output";
      break;
    case "F57":
      faultEvent = "Current sensor failed";
      break;
    case "F58":
      faultEvent = "Output voltage is too low";
      break;
    case "F59":
      faultEvent = "PV voltage is over limitation";
      break;
  }
  return faultEvent;
}

String warningIndicator(String code) {
  var warningEvent = "null";
  switch (code) {
    case "01":
      warningEvent = "Fan is locked when inverter is on.";
      break;
    case "02":
      warningEvent = "Over temperature";
      break;
    case "03":
      warningEvent = "Battery is over charged";
      break;
    case "04":
      warningEvent = "Low battery";
      break;
    case "07":
      warningEvent = "Overload";
      break;
    case "10":
      warningEvent = "Output power derating";
      break;
    case "15":
      warningEvent = "PV energy is low.";
      break;
    case "16":
      warningEvent = "High AC input (>280VAC) during BUS soft start";
      break;
    case "32":
      warningEvent = "Communication interrupted";
      break;
    case "Eq":
      warningEvent = "Battery equalization";
      break;
    case "bP":
      warningEvent = "Battery is not connected";
      break;
  }
  return warningEvent;
}

String decodeKey(String key) {
  var rawKey = "null";
  switch (key){
    case "input_voltage":
      rawKey = "Input Voltage";
      break;
    case "output_voltage":
      rawKey = "Output Voltage";
      break;
    case "input_frequency":
      rawKey = "Input Frequency";
      break;
    case "pv_voltage":
      rawKey = "Pv Voltage";
      break;
    case "pv_current":
      rawKey = "Pv Current";
      break;
    case "pv_power":
      rawKey = "Pv Power";
      break;
    case "ac_and_pv_charging_current":
      rawKey = "AC and PV charging current";
      break;
    case "ac_charging_current":
      rawKey = "AC charging current";
      break;
    case "pv_charging_current":
      rawKey = "PC charging current";
      break;
  }
  return rawKey;
}

Map inverterDataMain = {
  "input_voltage": "235V",
  "output_voltage": "34",
  "input_frequency": "0",
  "pv_voltage": "0",
  "pv_current": "0",
  "pv_power": "0",
  "ac_and_pv_charging_current": "0",
  "ac_charging_current": "0",
  "pv_charging_current": "0",
  "fault_reference_code": "f02",
  "warning_indicator": "06",
  "standby_charging_by_utility_and_pv_energy": "false",
  "standby_charging_by_utility": "false",
  "standby_charging_by_pv_energy": "false",
  "standby_no_charging": "false",
  "fault_mode_charging_by_utility_and_pv_energy": "false",
  "fault_mode_charging_by_utility": "false",
  "fault_mode_charging_by_pv_energy": "false",
  "fault_mode_no_charging": "false",
  "line_mode_charging_by_utility_and_pv_energy": "false",
  "line_mode_charging_by_utility": "false",
  "line_mode_solar_energy_not_sufficient": "false",
  "line_mode_battery_not_connected": "false",
  "line_mode_power_from_utility": "false",
  "battery_mode_power_from_battery_and_pv_energy": "false",
  "battery_mode_pv_energy_to_loads_and_charge_battery_no_utility": "false",
  "battery_mode_power_from_battery": "false",
  "battery_mode_power_from_pv_energy": "false",
};
