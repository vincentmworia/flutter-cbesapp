import 'dart:convert';

final inverterData = json.encode({
  "input_voltage": "230V",
  "output_voltage": "230V",
  "input_frequency": "50Hz",
  "pv_voltage": "260V",
  "pv_current": "2.5A",
  "pv_power": "500W",
  "ac_and_pv_charging_current": "50A",
  "ac_charging_current": "50A",
  "pv_charging_current": "50A",

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
  "fault_reference_code": "f02",
  "warning_indicator": "06",
});

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
      break;case "01":
      warningEvent = "Fan is locked when inverter is on.";
      break;
  }
  return warningEvent;
}

/*
const specifications = {
  "line_mode_specifications": [
    {
      "key": "INVERTER MODEL",
      "value": [
        "1.5KW",
        "3KW",
        "5KW",
      ],
    },
    {
      "key": "Input Voltage Waveform",
      "value": ["Sinusoidal (utility or generator)"],
    },
    {
      "key": "Nominal Input Voltage",
      "value": ["230Vac"],
    },
    {
      "key": "Low Loss Voltage",
      "value": ["""170Vac± 7V (UPS);
90Vac± 7V (Appliances)"""],
    },
    {
      "key": "Low Loss Return Voltage",
      "value": ["""180Vac± 7V (UPS);
100Vac± 7V (Appliances)"""],
    },
    {
      "key": "High Loss Voltage",
      "value": ["280Vac± 7V"],
    },
    {
      "key": "High Loss Return Voltage",
      "value": ["270Vac± 7V"],
    },
    {
      "key": "Max AC Input Voltage",
      "value": ["300Vac"],
    },
    {
      "key": "Nominal Input Frequency",
      "value": ["50Hz / 60Hz (Auto detection)"],
    },
    {
      "key": "Low Loss Frequency",
      "value": ["40± 1Hz"],
    },
    {
      "key": "Low Loss Return Frequency",
      "value": ["42± 1Hz"],
    },
    {
      "key": "High Loss Frequency",
      "value": ["65± 1Hz"],
    },
    {
      "key": "High Loss Return Frequency",
      "value": ["63± 1Hz"],
    },
    {
      "key": "Output Short Circuit Protection",
      "value": ["Circuit Breaker"],
    },
    {
      "key": "Efficiency (Line Mode)",
      "value": [">95% ( Rated R load, battery full charged )"],
    },
    {
      "key": "Transfer Time",
      "value": ["""10ms typical (UPS);
20ms typical (Appliances)"""],
    },
    {
      "key": "Output power derating:",
      // TODO PHOTO OF OUTPUT POWER DERATING
      "value": """

        """,
    },
  ],
  "inverter_mode_specifications": [
    {
      "key": "INVERTER MODEL",
      "value": ["1.5KW", "3KW", "5KW"],
    },
    {
      "key": "Rated Output Power",
      "value": ["1.5KVA/1.5KW", "3KVA/3KW", "5KVA/5KW"],
    },
    {
      "key": "Output Voltage Waveform",
      "value": ["Pure Sine Wave"],
    },
    {
      "key": "Output Voltage Regulation",
      "value": ["230Vac±5"],
    },
    {
      "key": "Output Frequency",
      "value": ["50Hz"],
    },
    {
      "key": "Peak Efficiency",
      "value": ["93"],
    },
    {
      "key": "Overload Protection",
      "value": ["5s@≥130% load 10s@105%~13 0% load"],
    },
    {
      "key": "Surge Capacity",
      "value": ["2* rated power for 5 seconds"],
    },
    {
      "key": "Nominal DC Input Voltage",
      "value": ["24Vdc", "48V dc"],
    },
    {
      "key": "Cold Start Voltage",
      "value": ["23.0Vdc", "46.0Vdc"],
    },
    //
    {
      "key": "Low DC Warning Voltage",
      "value": [""],
    },
    {
      "key": "@ load <50%",
      "value": ["23.0Vdc", "46.0Vdc"],
    },
    {
      "key": "@ load ≥ 50%",
      "value": ["22.0 Vdc", "44.0 Vdc"],
    },
    //
    {
      "key": "Low DC Warning Return Voltage",
      "value":[ ""],
    },
    {
      "key": "@ load <50%",
      "value": ["23 .5Vdc", "47.0Vdc"],
    },
    {
      "key": "@ load ≥ 50%",
      "value": ["23 .0 Vdc", "46.0 Vdc"],
    },
    //
    {
      "key": "Low DC Cut-off Voltage",
      "value": [""],
    },
    {
      "key": "@ load <50%",
      "value": ["21.5Vdc", "43.0Vdc"],
    },
    {
      "key": "@ load ≥ 50%",
      "value": ["21.0 Vdc", "42.0 Vdc"],
    },
    //
    {
      "key": "High DC Recovery Voltage",
      "value": ["32Vdc", "62Vdc"],
    },
    {
      "key": "High DC Cut-off Voltage",
      "value": ["33Vdc", "63Vdc"],
    },
    {
      "key": "No Load Power Consumption",
      "value": ["<35W", "<50W"],
    },
  ],
  "charge_mode_specifications":[
    {
      "key": "INVERTER MODEL",
      "value": [
        "1.5KW",
        "3KW",
        "5KW",
      ],
    },],
};
*/
