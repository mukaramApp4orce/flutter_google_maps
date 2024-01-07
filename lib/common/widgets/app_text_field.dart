import '../../flutter_google_maps.dart';

class AppTextField {
  static Widget withPrefixIcon({
    // required VoidCallback onTap,
    required String text,
    // required String icon,
    required TextEditingController controller,
    required Function onChange,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: (val) => onChange(val),
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.colorPinkWhite,
        hintText: text,
        hintStyle: const TextStyle(
          // color: AppColors.greyText,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        constraints: const BoxConstraints(
          maxWidth: 398,
          maxHeight: 56,
          minWidth: 398,
          minHeight: 56,
        ),
        // prefixIcon: GestureDetector(
        //   onTap: onTap,
        //   child: Container(
        //     padding: const EdgeInsets.only(
        //       left: 16,
        //       right: 16,
        //     ),
        //     child: AppSvg.asset(
        //       icon,
        //       width: 19,
        //       height: 19,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
