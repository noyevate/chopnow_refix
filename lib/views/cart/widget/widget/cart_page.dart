import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/size.dart';
import 'package:chopnow/hooks/fetch_cart.dart';
import 'package:chopnow/models/cart_response.dart';
import 'package:chopnow/views/cart/widget/widget/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Carts extends HookWidget {
  const Carts( {super.key,});
  

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCart();
    final List<CartResponse> carts = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    final apiError = hookResult.error;
    final refetch = hookResult.refetch;

    
    

    return Container(
      color: Tcolor.BACKGROUND_Regaular,
      child: isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.w,
              child: const CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: SizedBox(
                width: width,
                height: height,
                child: ListView.builder(
                  itemCount: carts.length + 1,
                  itemBuilder: (context, i) {
                    if (i == carts.length) {
                      return SizedBox(
                          height:
                              1000.h); // Add extra space at the end of the list
                    }
                    var cart = carts[i];
                    return CartTile(
                      cart: cart, refetch: refetch,
                    );
                  },
                ),
              ),
            ),
    );
  }
}
