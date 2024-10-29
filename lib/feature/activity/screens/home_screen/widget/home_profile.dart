import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/constants/image.strings.dart';
import 'package:payroll_vade/utils/dto/account_dto.dart';
import 'package:payroll_vade/utils/helpers/image_decoder.dart';

class HomeProfile extends StatelessWidget {
  final AccountDto accountDTO;

  const HomeProfile({
    Key? key,
    required this.accountDTO,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bytes = decodeImage(accountDTO.image);

    return Row(
      children: [
        CircleAvatar(
          backgroundImage: bytes != null
              ? MemoryImage(bytes)
              : const AssetImage(TImages.vadeLogoBlack) as ImageProvider,
          maxRadius: 25,
        ),
        SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              accountDTO.employeeName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Position not specified",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}
