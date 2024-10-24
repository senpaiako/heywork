import 'package:flutter/material.dart';
import 'package:payroll_vade/utils/constants/image.strings.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';

class HomeProfile extends StatelessWidget {
  const HomeProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(TImages.vadeLogoBlack),
          maxRadius: 25,
        ),
        SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hhe Name wewewEntity",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Position Po",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        )
      ],
    );
  }
}
