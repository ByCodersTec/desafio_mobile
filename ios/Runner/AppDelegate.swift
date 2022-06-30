import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSService.provideAPIKey("AIzaSyDXiOvvEt2PO1BDMkATZXEjjU_VtDGlJc0")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
