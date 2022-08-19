import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      registerForPushNotifications()
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            //1
            UNUserNotificationCenter.current()
              //2
              .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                //3
                print("Permission granted: \(granted)")
              }
        }
      
    }
}
