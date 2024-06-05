

import 'package:flutter/material.dart';

class DialogBox{

  Future<void> dialogShow(TextEditingController textController,TextEditingController amountController,String title,String amount,String text,void onTap(),BuildContext context) async {
    textController.text = title;
    amountController.text = amount;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Expenditure'),
          content: Container(
            height: 150,
            child: Column(
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
                ),
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
                ),
              ],
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
                  onPressed: () async {
                    onTap();
                    Navigator.pop(context);
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}