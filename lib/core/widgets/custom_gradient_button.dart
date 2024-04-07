import 'package:flutter/material.dart';
import 'package:innovins_task/core/widgets/loader.dart';

import '../theme/app_pallete.dart';

class CustomGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double circularBorderRadius;
  final Size? buttonSize;
  const CustomGradientButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.circularBorderRadius = 30,
      this.buttonSize,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppPallete.gradient1,
                AppPallete.gradient2,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(circularBorderRadius)),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: buttonSize ??
                Size(MediaQuery.sizeOf(context).width,
                    MediaQuery.sizeOf(context).height * 0.03),
            backgroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor,
          ),
          child: isLoading
              ? const SizedBox(
                  height: 15,
                  width: 15,
                  child: Loader(
                    color: AppPallete.whiteColor,
                  ))
              : Text(
                  buttonText,
                  style: const TextStyle(color: AppPallete.whiteColor),
                ),
        ));
  }
}
