import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WalletController extends GetxController{

  TextEditingController amountController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<int> amountList = [500,1000,2000];
  RxInt walletAmount = 0.obs;

  onDefaultAmount(int amount){
    amountController.text = amount.toString();
  }

  addWalletAmount(){
    walletAmount.value = int.parse(amountController.text);
    print(walletAmount.value);
  }

  onCheckEmail(){
    if(!emailController.text.isEmail)
    print("Not Valid Email");
    else
    print("Valid Email address");
  }


}