import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_pgn_controller.dart';

class EditPgnView extends GetView<EditPgnController> {
  EditPgnView({super.key});
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final newPgnController = TextEditingController();
    final newFreqController = TextEditingController(text: "1");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit PGNs'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Add PGN Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: newPgnController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'New PGN',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: newFreqController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Frequency',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final pgn = int.tryParse(newPgnController.text);
                    final freq = int.tryParse(newFreqController.text) ?? 1;

                    if (pgn == null) {
                      Get.snackbar('Error', 'Enter a valid PGN',
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    }

                    bool exists = controller.pgns
                        .any((element) => element["pgn"] == pgn);
                    if (exists) {
                      Get.snackbar('Duplicate', 'PGN already exists',
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    }

                    // Add PGN and get its new index after sorting
                    int newIndex = controller.addPgn(pgn, freq);

                    newPgnController.clear();
                    newFreqController.text = "1";

                    // Scroll to newly added PGN
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (scrollController.hasClients) {
                        scrollController.animateTo(
                          newIndex * 60.0, // approximate row height
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    });
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          // PGN List
          Expanded(
            child: Obx(
                  () => ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.pgns.length,
                itemBuilder: (context, index) {
                  final item = controller.pgns[index];
                  final controllerField = controller.freqControllers[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${item["pgn"]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Frequency',
                              border: OutlineInputBorder(),
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                            controller: controllerField,
                            onChanged: (val) {
                              controller.updateFrequency(index, val);
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            controller.deletePgn(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Save Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                controller.savePgns();
                Get.snackbar('Saved', 'PGNs saved successfully',
                    snackPosition: SnackPosition.BOTTOM);
              },
              icon: const Icon(Icons.save),
              label: const Text('Save PGNs'),
            ),
          ),
        ],
      ),
    );
  }
}

