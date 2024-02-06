

import 'package:islamic_quizs_game/consts/views/assets.dart';
import 'package:pay/pay.dart';
import 'package:flutter/material.dart';

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '.10',
    status: PaymentItemStatus.final_price,
  )
];


Future<PaymentConfiguration> getpayment ()async{
  return await   PaymentConfiguration.fromAsset(AppAsset.paymentJson);
}




 Widget setGooglePay( Function(Map<String, dynamic> result) onPaymentResult
     , PaymentItem paymentItem
     ) {
  return  FutureBuilder<PaymentConfiguration>(
       future: getpayment(),
       builder: (context, snapshot) => snapshot.hasData
           ?
       GooglePayButton(

         paymentConfiguration: snapshot.data!,
         paymentItems:  [paymentItem]  ,
         type: GooglePayButtonType.buy,
         margin: const EdgeInsets.only(top: 15.0  , bottom: 10),
         onPaymentResult: onPaymentResult,
         loadingIndicator: const Center(
           child: CircularProgressIndicator(),
         ),
       )
           : const SizedBox.shrink()) ;
 }


