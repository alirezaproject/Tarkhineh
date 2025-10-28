import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkhineh/common_widgets/image.dart';
import 'package:tarkhineh/core/constants/assets.dart';
import 'package:tarkhineh/core/theme.dart';
import 'package:tarkhineh/features/home/providers/branch_controller.dart';
import 'package:tarkhineh/features/home/widgets/branch_card.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(branchController);

    return Container(
      decoration: BoxDecoration(color: AppTheme.lightTheme.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImage(path: AppAssets.logo, width: 100),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                isScrollControlled: true, // full height scrollable sheet
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // adjust height to content
                      children: [
                        Text(
                          'انتخاب شعبه',
                          style: AppTheme.lightTheme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 400, // fixed height for the list
                          width: double.infinity,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: controller.branchModel.length,
                            itemBuilder: (context, index) => BranchCard(
                              branch: controller.branchModel[index],
                              onTap: () async {
                                final branch = controller.branchModel[index];

                                ref
                                    .read(branchController.notifier)
                                    .selectBranch(branch);

                                if (context.mounted) {
                                  context.pop();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.white),
                  Text(
                    controller.selectedBranch,
                    style: AppTheme.lightTheme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
