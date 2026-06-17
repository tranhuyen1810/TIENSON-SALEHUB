import 'dart:async';

class AiService {
  static Future<String> reply(String prompt) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return _localResponse(prompt);
  }

  static String _localResponse(String prompt) {
    final normalized = prompt.toLowerCase();
    if (normalized.contains('thống kê') || normalized.contains('báo cáo')) {
      return 'Hôm nay tổng sản lượng được dự đoán ổn định, số lượng xe chờ cân giảm và tiến độ vận hành trơn tru.';
    }
    if (normalized.contains('lỗi') || normalized.contains('vấn đề') || normalized.contains('không')) {
      return 'Kiểm tra lại trạng thái lệnh và thông tin xe. Nếu cần, tạo lệnh mới hoặc liên hệ phòng kỹ thuật để điều chỉnh cân.';
    }
    if (normalized.contains('mở') || normalized.contains('đăng nhập')) {
      return 'Bạn có thể vào Đăng nhập và sử dụng tài khoản để tiếp tục quản lý lệnh và cân xe.';
    }
    if (normalized.contains('tạo lệnh') || normalized.contains('đơn hàng')) {
      return 'Chọn "Tạo lệnh mới", điền khách hàng, biển số, loại sản phẩm và số lượng rồi nhấn LƯU LỆNH.';
    }
    return 'Zeni AI đã nhận thông tin. Hệ thống đang xử lý và sẽ cập nhật kết quả nhanh nhất cho bạn.';
  }
}
