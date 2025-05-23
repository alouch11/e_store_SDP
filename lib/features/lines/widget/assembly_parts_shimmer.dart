import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:shimmer/shimmer.dart';

class AssemblyPartsShimmer extends StatelessWidget {
  const AssemblyPartsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: Container(margin: const EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorResources.white,
      )),
    );
  }
}
