//
//  NotificationManager.swift
//  TodoApp
//
//  Created by alican on 19.11.2021.
//

import Foundation
import UserNotifications
import UIKit

struct LocalNotification{
    var id : String
    var title : String
    var body : String
}

enum LocalNotificationDurationType{
    case days
    case hours
    case minutes
    case seconds
}

struct LocalNotificationManager{
    static private var notifications = [LocalNotification]()
    static private func requestPermission() -> Void{
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge , .alert]) { granted, error in
            if granted == true && error == nil{
                // We have a permission
            }
        }
    }
    
    
static private func scheduleNotifications(_ durationInSeconds: Int , repeats: Bool , userInfo: [AnyHashable : Any],notificationId : String , title : String , body : String){
    UIApplication.shared.applicationIconBadgeNumber = 0

    let content = UNMutableNotificationContent()
    content.title = title
    //content.subtitle --> If you want to you can use it
    content.body = body
    content.sound = UNNotificationSound.default
    content.launchImageName = "background"
    content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
    content.userInfo = userInfo
    
    let triggger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(durationInSeconds), repeats: repeats)
    let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: triggger)
    
    UNUserNotificationCenter.current().add(request) { error in
        guard error == nil else {return}
        print("Scheduling notification with id: \(notificationId)")
    }
}
    
static private func scheduleNotifications(_ duration: Int , of type: LocalNotificationDurationType, repeats: Bool , userInfo: [AnyHashable : Any],notificationId :String , title : String , body : String){
    var seconds = 0
    switch type {
    case .days:
        seconds = duration * 60 * 60 * 24
    case .hours:
        seconds = duration * 60 * 60
    case .minutes:
        seconds = duration * 60
    case .seconds:
        seconds = duration
    }
    scheduleNotifications(seconds, repeats: repeats, userInfo: userInfo, notificationId: notificationId, title: title, body: body)
}
    

    
    static private func scheduleNotifications(_ dateComponent: DateComponents , repeats: Bool , userInfo: [AnyHashable : Any],notificationId : String , title : String , body : String){
        UIApplication.shared.applicationIconBadgeNumber = 0

            let content = UNMutableNotificationContent()
            content.title = title
            //content.subtitle --> If you want to you can use it
            content.body = body
            content.sound = UNNotificationSound.default
            content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
            content.launchImageName = "background"
            content.userInfo = userInfo
            
            if let url = URL.localURLForXCAsset(name: "note") {
                do {
                    let attachment = try UNNotificationAttachment.init(identifier: notificationId, url: url, options: .none)
                    content.attachments = [attachment]
                } catch let error {
                    print(error)
                }
            }
           // If your image is not in the asset folder, if it is under the project, you can get the file path of the image with this method.
           //setNotificationImage(notificationId, content)
    
            let triggger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: repeats)
            let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: triggger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else {return}
                print("Scheduling notification with id: \(notificationId)")
            }
            
    }
            
    static func cancel(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    static func cancelThisNotification( _ notificationId : String){
        //UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationId])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
        print("Removed scheduling notification with id: \(notificationId)")
    }
    
    static func setNotification(_ duration: Int , _ notificationId : String , of type: LocalNotificationDurationType , repeats : Bool , title :  String , body : String , userInfo: [AnyHashable : Any]){
        requestPermission()
        scheduleNotifications(duration, repeats: false, userInfo: userInfo, notificationId: notificationId, title: title, body: body)
    }
    
    static func setNotification(_ dateComponent: DateComponents , _ notificationId : String , repeats : Bool , title :  String , body : String , userInfo: [AnyHashable : Any]){
        requestPermission()
        scheduleNotifications(dateComponent, repeats: false, userInfo: userInfo, notificationId: notificationId, title: title, body: body)
    }
    
    fileprivate static func setNotificationImage(_ notificationId: String, _ content: UNMutableNotificationContent) {
        let filePath = Bundle.main.path(forResource: "note", ofType: ".png")
        let fileUrl = URL(fileURLWithPath: filePath!)
        
        do {
            let attachment = try UNNotificationAttachment.init(identifier: notificationId, url: fileUrl, options: .none)
            content.attachments = [attachment]
        } catch let error {
            print(error)
        }
    }
}

extension URL {
static func localURLForXCAsset(name: String) -> URL? {
    let fileManager = FileManager.default
    guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
    let url = cacheDirectory.appendingPathComponent("\(name).png")
    let path = url.path
    if !fileManager.fileExists(atPath: path) {
        guard let image = UIImage(named: name), let data = image.pngData() else {return nil}
        fileManager.createFile(atPath: path, contents: data, attributes: nil)
    }
    return url
}}
