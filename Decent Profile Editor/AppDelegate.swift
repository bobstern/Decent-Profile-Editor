//  AppDelegate.swift
//  Decent Profile Editor


import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

//    var window: NSWindow! //  Deleted cuz superseded by newWindow()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        dateFormatter.dateFormat = "yyyy-MM-dd 'T'HHmm"
        self.newWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    @IBAction func menuNew (_ sender: NSMenuItem) {
        self.newWindow()
    }
    
    // controller retains vm, but controller de-inits immediately!
    // ViewModel.deinit() print shows vm de-inits when window closed,
    // so window somehow retains vm.
    func newWindow() {
        let vm = ViewModel()
        let rootView = ProfileMainView(vm: vm)
        let controller = WindowController(rootView: rootView, vm: vm)
        
        // Remaining commands can be moved to WindowController.init(),
        // but OpenDialog() is more conspicuous here:
        
        vm.shotFilesOpenDialog(window: controller.window!)
        controller.showWindow(nil) // nil=sender, not receiver.
        
        // controller is local var of this func, so
        // controller now de-inits, but window persists!
    }
}

