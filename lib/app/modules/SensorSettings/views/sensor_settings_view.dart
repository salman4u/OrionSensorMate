import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/sensor_settings_controller.dart';



class SensorSettingsView extends GetView<SensorSettingsController> {
  const SensorSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sensor Settings")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildNumberField("Transmission Timer (s)", controller.transmissionTimer),

            _buildLimitFields("VBat (mV)", controller.vBatMin, controller.vBatMax),
            _buildLimitFields("Temperature (°C)", controller.temperatureMin, controller.temperatureMax),
            _buildLimitFields("Humidity (%)", controller.humidityMin, controller.humidityMax),
            _buildLimitFields("Motion (mg)", controller.motionMin, controller.motionMax),
            _buildLimitFields("Sound (0/1)", controller.soundMin, controller.soundMax),
            _buildLimitFields("Light (Lux)", controller.lightMin, controller.lightMax),
            _buildLimitFields("Analog 1 (mV)", controller.analog1Min, controller.analog1Max),
            _buildLimitFields("Analog 2 (mV)", controller.analog2Min, controller.analog2Max),

            _buildSwitch("Movement (PIR)", controller.movement),
            _buildSwitch("Digital 1 In", controller.digital1),
            _buildSwitch("Digital 2 In", controller.digital2),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.saveSettings,
              child: const Text("Save Settings"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberField(String label, RxInt value) {
    return Obx(() => TextField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      controller: TextEditingController(text: value.value.toString())
        ..selection = TextSelection.collapsed(offset: value.value.toString().length),
      onChanged: (val) {
        if (val.isNotEmpty) value.value = int.tryParse(val) ?? 0;
      },
    ));
  }

  Widget _buildLimitFields(String label, RxInt min, RxInt max) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(child: _buildNumberField("Min", min)),
            const SizedBox(width: 8),
            Expanded(child: _buildNumberField("Max", max)),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSwitch(String label, RxBool value) {
    return Obx(() => SwitchListTile(
      title: Text(label),
      value: value.value,
      onChanged: (val) => value.value = val,
    ));
  }
}

