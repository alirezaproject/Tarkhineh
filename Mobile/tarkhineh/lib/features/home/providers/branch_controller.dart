import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tarkhineh/core/extensions/custom_snack_bar.dart';
import 'package:tarkhineh/core/utils/shared_preferences.dart';
import 'package:tarkhineh/core/wrapper/global_result_provider.dart';
import 'package:tarkhineh/features/home/models/branch_model.dart';
import 'package:tarkhineh/features/home/services/branch_service.dart';
import 'package:tarkhineh/service_locator.dart';

final branchController = ChangeNotifierProvider<BranchController>((ref) {
  final controller = BranchController(ref);
  controller.fetchBranches();
  ref.onDispose(controller.dispose);
  return controller;
});

class BranchController extends ChangeNotifier {
  final Ref ref;
  BranchController(this.ref);

  final branchService = sl<IBranchService>();

  final List<BranchModel> _branchModel = [];
  List<BranchModel> get branchModel => _branchModel;

  String _selectedBranch = 'شعبه';
  String get selectedBranch => _selectedBranch;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchBranches() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final res = await branchService.getBranches();

      if (res.success) {
        _branchModel
          ..clear()
          ..addAll(res.data!);

        final selectedBranchId = SharedPreferencesHelper.getBranchId();
        final selectedBranchName = SharedPreferencesHelper.getBranchName();

        if (selectedBranchId != null && selectedBranchName != null) {
          _selectedBranch = selectedBranchName;
        }

        notifyListeners();
      } else {
        ref
            .read(globalResultProvider.notifier)
            .showMessage('خطا در ارتباط با سرور', SnackBarType.error);
      }
    } catch (e) {
      ref
          .read(globalResultProvider.notifier)
          .showMessage('خطا در ارتباط با سرور', SnackBarType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectBranch(BranchModel branch) async {
    await SharedPreferencesHelper.saveBranch(id: branch.id, name: branch.name);
    _selectedBranch = branch.name;
    notifyListeners();
  }
}
