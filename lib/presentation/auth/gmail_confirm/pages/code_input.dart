import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../widgets/global_text_fields.dart';

class CodeInput extends StatefulWidget {
  const CodeInput({super.key, required this.pinController});
  final TextEditingController pinController;
  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.blue;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Colors.black;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Directionality(
          // Specify direction if desired
          textDirection: TextDirection.ltr,
          child: Pinput(
            length: 6,
            controller: widget.pinController,
            focusNode: focusNode,
            androidSmsAutofillMethod:
            AndroidSmsAutofillMethod.smsUserConsentApi,
            listenForMultipleSmsOnAndroid: true,
            defaultPinTheme: defaultPinTheme,
            separatorBuilder: (index) => const SizedBox(width: 8),
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onCompleted: (pin) {
              debugPrint('onCompleted: $pin');
            },
            onChanged: (value) {
              debugPrint('onChanged: $value');
            },
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width: 22,
                  height: 1,
                  color: focusedBorderColor,
                ),
              ],
            ),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: focusedBorderColor),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: fillColor,
                borderRadius: BorderRadius.circular(19),
                border: Border.all(color: focusedBorderColor),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}