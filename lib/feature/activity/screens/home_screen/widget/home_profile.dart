import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/dto/account_dto.dart';
import 'package:payroll_vade/utils/constants/image.strings.dart';

class HomeProfile extends StatelessWidget {
  final AccountDto accountDTO;

  const HomeProfile({
    Key? key,
    required this.accountDTO,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;

    // Decode the base64 string if it exists
    if (accountDTO.image != null) {
      try {
        bytes = base64Decode(accountDTO.image!);
      } catch (e) {
        // Handle any errors in decoding
        print("Error decoding image: $e");
      }
    }

    return Row(
      children: [
        CircleAvatar(
          backgroundImage: bytes != null
              ? MemoryImage(bytes)
              : AssetImage(TImages
                  .vadeLogoBlack), // Use a default image if decoding fails
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
              "Position not specified", // Handle nullable position
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}
