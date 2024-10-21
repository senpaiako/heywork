import 'package:flutter/material.dart';
import 'package:payroll_vade/utils/constants/image.strings.dart';
import 'package:payroll_vade/utils/constants/text_strings.dart';

class logInHeader extends StatelessWidget {
  const logInHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          width: 100,
          height: 100,
          image: AssetImage(TImages.vadeLogoBlack),
        ),
        Text(
          TTexts.LoginTitle1,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          TTexts.LogingSubTitle1,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
