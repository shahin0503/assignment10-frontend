import 'package:assignment10/core/ui.dart';
import 'package:flutter/cupertino.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        color: AppColors.accent,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
