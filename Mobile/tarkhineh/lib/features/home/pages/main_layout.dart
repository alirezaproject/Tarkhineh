import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/core/theme.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  static Color primaryColor = AppTheme.lightTheme.primaryColor;

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
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: _HomeActiveIcon(),
                label: 'خانه',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'جستجو',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'سبد خرید',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: 'سفارشات',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'پروفایل',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// آیکن سفارشی خانه که پس‌زمینه سبز دارد مثل عکس
class _HomeActiveIcon extends StatelessWidget {
  const _HomeActiveIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      //  decoration: const BoxDecoration(color: tarkhinehGreen, borderRadius: BorderRadius.all(Radius.circular(8))),
      alignment: Alignment.center,
      child: Icon(
        Icons.home,
        color: AppTheme.lightTheme.primaryColor,
        size: 22,
      ),
    );
  }
}
