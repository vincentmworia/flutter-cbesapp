String faultReferenceCode(String code) {
  var faultEvent = "null";
  switch (code) {
    case "f00":
      faultEvent = "-" * 5;
      break;
    case "f01":
      faultEvent = "Fan is locked when inverter is off.";
      break;
    case "f02":
      faultEvent = "Over temperature";
      break;
    case "f03":
      faultEvent = "Battery voltage is too high";
      break;
    case "f04":
      faultEvent = "Battery voltage is too low";
      break;
    case "f05":
      faultEvent = """
      Output short circuited or over temperature is detected by
internal converter components.""";
      break;
    case "f06":
      faultEvent = "Output voltage is too high";
      break;
    case "f07":
      faultEvent = "Overload time out";
      break;
    case "f08":
      faultEvent = "Bus voltage is too high";
      break;
    case "f09":
      faultEvent = "Bus soft start failed";
      break;
    case "f51":
      faultEvent = "Over current or surge";
      break;
    case "f52":
      faultEvent = "Bus voltage is too low";
      break;
    case "f53":
      faultEvent = "Inverter soft start failed";
      break;
    case "f55":
      faultEvent = "Over DC voltage in AC output";
      break;
    case "f57":
      faultEvent = "Current sensor failed";
      break;
    case "f58":
      faultEvent = "Output voltage is too low";
      break;
    case "f59":
      faultEvent = "PV voltage is over limitation";
      break;
  }
  return faultEvent;
}

String warningIndicator(String code) {
  var warningEvent = "null";
  switch (code) {
    case "00":
      warningEvent = "-" * 5;
      break;
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
  switch (key) {
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
    case "fault_reference_code":
      rawKey = "Fault";
      break;
    case "Warning":
      rawKey = "PC charging current";
      break;
    case "standby_mode":
      rawKey = "Standby mode";
      break;
    case "fault_mode":
      rawKey = "Fault mode";
      break;
    case "line_mode":
      rawKey = "Line mode";
      break;
    case "battery_mode":
      rawKey = "Battery mode";
      break;
    case "charging_by_utility_and_pv_energy":
      rawKey = "Utility & PV charging";
      break;
    case "charging_by_utility":
      rawKey = "Utility charging";
      break;
    case "charging_by_pv_energy":
      rawKey = "PV charging";
      break;
    case "no_charging":
      rawKey = "Not charging";
      break;
    case "solar_energy_not_sufficient":
      rawKey = "Solar not sufficient";
      break;
    case "battery_not_connected":
      rawKey = "Battery disconnected";
      break;
    case "power_from_utility":
      rawKey = "Not charging";
      break;

    case "power_from_battery_and_pv_energy":
      rawKey = "Power from battery & PV";
      break;
    case "pv_energy_to_loads_and_charge_battery_no_utility":
      rawKey = "PV to load and charge battery\n${"\t" * 10}No Utility";
      break;
    case "power_from_battery":
      rawKey = "Power from battery";
      break;
    case "power_from_pv_energy":
      rawKey = "Power from PV";
      break;
  }
  return rawKey;
}

var useInverterData = {
  "main_data": {
    "input_voltage": "212" + "V",
    "output_voltage": "234" + "V",
    "input_frequency": "50" + "Hz",
    "pv_voltage": "321" + "V",
    "pv_current": "23" + "A",
    "pv_power": "123" + "W",
    "ac_and_pv_charging_current": "54" + "A",
    "ac_charging_current": "11" + "A",
    "pv_charging_current": "5" + "A",
  },
  "fault_reference_code": "f02",
  "warning_indicator": "07",
  "operation_modes": {
    "standby_mode": {
      "charging_by_utility_and_pv_energy": "true",
      "charging_by_utility": "true",
      "charging_by_pv_energy": "false",
      "no_charging": "false",
    },
    "fault_mode": {
      "charging_by_utility_and_pv_energy": "true",
      "charging_by_utility": "true",
      "charging_by_pv_energy": "false",
      "no_charging": "false",
    },
    "line_mode": {
      "charging_by_utility_and_pv_energy": "true",
      "charging_by_utility": "false",
      "solar_energy_not_sufficient": "true",
      "battery_not_connected": "true",
      "power_from_utility": "true",
    },
    "battery_mode": {
      "power_from_battery_and_pv_energy": "false",
      "pv_energy_to_loads_and_charge_battery_no_utility": "true",
      "power_from_battery": "false",
      "power_from_pv_energy": "false",
    },
  }
};
