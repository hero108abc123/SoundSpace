import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 25,right: 357),
        child: Container(
          height: 32,
          width: 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
          ),
          child: const Icon(
            Icons.chevron_left,
            color: Color(0xff001A72),
          ),
        ),
      ),
    );
  }
}