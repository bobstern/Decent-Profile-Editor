//  AppDelegate.swift
//  Decent Profile Editor


import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        dateFormatter.dateFormat = "yyyy-MM-dd 'T'HHmm"
        // shotFilesOpenDialog() // Move to window init for multi-window.
        
/*
        let contentView = MasterView() // First View.

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 1000),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        // First View:
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
*/
        self.newWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func menuNew (_ sender: NSMenuItem) {
        self.newWindow()
    }
    
    func newWindow() {
        let vm = ViewModel()
        let rootView = ProfileView(vm: vm)
        let controller = ProfileWindowController(rootView: rootView, vm: vm)
        controller.window?.title = "New window"
        controller.showWindow(nil) // nil=sender, not receiver.
    }
}

