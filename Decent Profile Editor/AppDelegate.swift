//  AppDelegate.swift
//  Decent Profile Editor


import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        dateFormatter.dateFormat = "yyyy-MM-dd 'T'HHmm"
        self.newWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    @IBAction func menuNew (_ sender: NSMenuItem) {
        self.newWindow()
    }
    
    func newWindow() {
        let vm = ViewModel()
        let rootView = ProfileMainView(vm: vm)
        let controller = ProfileWindowController(rootView: rootView, vm: vm)
        controller.window?.title = "New window"
        controller.showWindow(nil) // nil=sender, not receiver.
    }
}

