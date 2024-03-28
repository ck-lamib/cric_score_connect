import 'package:flutter/material.dart';

class CustomDatePicker {
  Future<int?> pickMonth({
    required BuildContext context,
    int? selectedMonth,
  }) async {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    var result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Month'),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          content: SizedBox(
            // Giving some size to the dialog so the gridview know its bounds

            height: height / 4,
            width: width,
            //  Creating a grid view with 3 elements per line.
            child: GridView.count(
              childAspectRatio: 2,
              crossAxisCount: 3,
              children: [
                // Generating a list of 123 years starting from 2022
                // Change it depending on your needs.
                ...List.generate(
                  12,
                  (index) {
                    if (selectedMonth != null && selectedMonth == index + 1) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context, index + 1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          margin: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              (index + 1).toString(),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.dialogBackgroundColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (index + 1 == DateTime.now().month) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context, index + 1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedMonth != null
                                ? Colors.transparent
                                : Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: selectedMonth == null
                                  ? Colors.transparent
                                  : Colors.deepPurpleAccent,
                            ),
                          ),
                          margin: const EdgeInsets.all(5),
                          child: Center(
                            child: Center(
                              child: Text(
                                (index + 1).toString(),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: selectedMonth == null
                                      ? theme.dialogBackgroundColor
                                      : Colors.deepPurpleAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, index + 1);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: Center(
                          child: Center(
                            child: Text(
                              (index + 1).toString(),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                  // color: theme.dialogBackgroundColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
  }

  Future<DateTime?> pickYear({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? selectedDate,
  }) async {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    DateTime? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            // Need to use container to add size constraint.
            height: height / 3,
            width: width,
            child: YearPicker(
              firstDate: firstDate,
              lastDate: lastDate,
              selectedDate: selectedDate ?? DateTime.now(),
              onChanged: (DateTime dateTime) {
                Navigator.pop(context, dateTime);
              },
            ),
          ),
        );
      },
    );
    return result;
  }

  Future<DateTime?> pickDate({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? selectedDate,
  }) async {
    DateTime? result = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: DateTime.now(),
      fieldLabelText: "Select Date",
      fieldHintText: "Select Date",
      helpText: "Select Date",
    );
    return result;
  }
}
