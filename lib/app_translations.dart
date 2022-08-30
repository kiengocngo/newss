import 'package:get/route_manager.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'home': 'Home',
          'settings': 'Settings',
          'follow': 'Follow',
          'noti': 'Notifications',
          'message': 'Message',
          'profile': 'Profile',
          'language': 'Language',
          'change_pass': 'Change password',
          'submit_change': 'Submit Change',
          'current_pass': 'Current Password',
          'new_pass': 'New Password',
          'confirm_pass': 'Confirm Password',
        },
        'vi_VN': {
          'home': 'Trang chủ',
          'settings': 'Cài đặt',
          'follow': 'Theo dõi',
          'noti': 'Thông báo',
          'message': 'Tin nhắn',
          'profile': 'Trang cá nhân',
          'language': 'Ngôn ngữ',
          'change_pass': 'Đổi mật khẩu',
          'submit_change': 'Lưu thay đổi',
          'current_pass': 'Mật khẩu cũ',
          'new_pass': 'Mật khẩu mới',
          'confirm_pass': 'Nhập lại mật khẩu',
        }
      };
}
