import 'package:flutter/material.dart';

class DialogBox {
  Future<void> dialogShow(
      TextEditingController textController,
      TextEditingController amountController,
      String title,
      String amount,
      String text,
      void Function() onTap,
      BuildContext context,
      ) async {
    textController.text = title;
    amountController.text = amount;

    // Create a GlobalKey for the form
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Expenditure'),
          content: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: textController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter Text',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        final n = num.tryParse(value);
                        if (n == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onTap();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(text),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
