import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/core/constants/assets.dart';
import 'package:tarkhineh/core/constants/color.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  static Color primaryColor = AppColor.primaryColor;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    // انتخاب اندکس فعال بر اساس route جاری
    int currentIndex = switch (location) {
      '/profile' => 4,
      '/orders' => 3,
      '/cart' => 2,
      '/search' => 1,
      _ => 0,
    };

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: primaryColor,
            unselectedItemColor: const Color(0xFF9E9E9E),
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Estedad',
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Estedad',
              fontSize: 13,
            ),
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                  context.go('/search');
                  break;
                case 2:
                  context.go('/cart');
                  break;
                case 3:
                  context.go('/orders');
                  break;
                case 4:
                  context.go('/profile');
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.home),
                activeIcon: SvgPicture.asset(AppIcons.homeFilled),
                label: 'خانه',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.search),
                activeIcon: SvgPicture.asset(AppIcons.search),
                label: 'جستجو',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.cart),
                activeIcon: SvgPicture.asset(AppIcons.cartFilled),
                label: 'سبد خرید',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.receipt),
                activeIcon: SvgPicture.asset(AppIcons.receiptFilled),
                label: 'سفارشات',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.user),
                activeIcon: SvgPicture.asset(AppIcons.userFilled),
                label: 'پروفایل',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
