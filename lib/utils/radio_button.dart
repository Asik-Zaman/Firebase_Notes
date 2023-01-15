import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;
  final bool isLoading;
  const RadioButton(
      {super.key,
      required this.title,
      this.color = Colors.white,
      required this.onTap,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 3,
                )
              : Text(
                  title,
                  style: TextStyle(color: Colors.black87),
                ),
        ),
      ),
    );
  }
}
