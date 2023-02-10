// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_integaration/providers/payment_provider.dart';
// import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_integaration/views/widgets.dart';
// import 'package:social_media_services/utils/animatedSnackBar.dart';

// class PaymentScreen extends StatefulWidget {
//   final double amount;
//   // final Packages packages;
//   // final String taxTotalAmount;
//   const PaymentScreen({
//     super.key,
//     required this.amount,
//     // required this.packages,
//     // required this.taxTotalAmount,
//   });

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   void _showSnackBar(String message) {
//     var snackBar = SnackBar(
//       elevation: 0,
//       backgroundColor: Colors.black,
//       duration: const Duration(seconds: 3),
//       content: Text(
//         message,
//         textAlign: TextAlign.left,
//         style: const TextStyle(
//           fontSize: 15,
//           color: Colors.white,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   @override
//   void initState() {
//     super.initState();
//     var paymentProvider = context.read<PaymentProvider>();
//     paymentProvider.init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PaymentProvider>(
//       builder: (context, paymentProvider, _) {
//         return Scaffold(
//           appBar: AppBar(title: const Text('Payment')),
//           body: Stack(
//             children: [
//               _buildPaymentMethods(),
//               if (paymentProvider.loading) const Loading(),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPaymentMethods() {
//     var paymentProvider = context.read<PaymentProvider>();

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         PaymentMethodTile(
//           icon: Icons.credit_card,
//           name: 'Credit or Debit Card',
//           onPressed: () {
//             log('1');
//             paymentProvider.paymentWithCreditOrDebitCard(
//               grandTotal: widget.amount,
//               // packages: widget.packages,
//               // taxTotalAmount: widget.taxTotalAmount,
//               context: context,
//               onSucceeded: (result) {
//                 log("Payment Success");
//                 print(result);
//                 _showSnackBar('Transaction succeeded: ${result.fortId}');
//               },
//               onFailed: (error) {
//                 _showSnackBar(error);
//               },
//               onCancelled: () {
//                 showAnimatedSnackBar(context, 'Payment cancelled');
//               },
//             );
//           },
//         ),
//         Divider(
//           height: 0,
//           indent: 10,
//           endIndent: 10,
//           color: Colors.grey.shade400,
//         ),
//         if (Platform.isIOS)
//           PaymentMethodTile(
//             icon: Icons.apple,
//             iconSize: 28,
//             name: 'Apple Pay',
//             onPressed: () {
//               paymentProvider.paymentWithApplePay(
//                 onSucceeded: (result) {
//                   _showSnackBar('Transaction succeeded: ${result.fortId}');
//                 },
//                 onFailed: (error) {
//                   _showSnackBar(error);
//                 },
//               );
//             },
//           ),
//       ],
//     );
//   }
// }
