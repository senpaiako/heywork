import 'package:flutter/material.dart';
import 'package:payroll_vade/utils/constants/image.strings.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';

class homeProfile extends StatelessWidget {
  const homeProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Image(
          image: AssetImage(TImages.vadeLogoBlack),
          height: 50,
          width: 50,
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