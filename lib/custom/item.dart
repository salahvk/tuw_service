// import 'package:flutter/material.dart';
// import 'package:social_media_services/model/get_countries.dart';

// Widget customPopupItemBuilderExample2(
//   BuildContext context,
//   Countries? item,
//   bool isSelected,
// ) {
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 8),
//     decoration: !isSelected
//         ? null
//         : BoxDecoration(
//             border: Border.all(color: Theme.of(context).primaryColor),
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.white,
//           ),
//     child: ListTile(
//       selected: isSelected,
//       title: Text(item?.phonecode.toString() ?? ''),
//       subtitle: Text(item?.countryName ?? ''),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:social_media_services/model/get_countries.dart';

Widget customPopupItemBuilderExample2(
  BuildContext context,
  List<Countries>? item,
  bool isSelected,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListView.builder(
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return ListTile(
          selected: isSelected,
          title: Text(item?[index].phonecode.toString() ?? ''),
          subtitle: Text(item?[index].countryName ?? ''),
        );
      },
      itemCount: 100,
    ),
  );
}
