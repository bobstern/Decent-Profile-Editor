//  AppDelegate.swift
//  Decent Profile Editor


import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var windowControllers = Set<WindowController>()

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
    // Perhaps window.windowController retains controller which retains vm.
    func newWindow() {
        let windowController = WindowController()
//        windowController.showWindow(nil) // nil=sender, not receiver.
        windowControllers.insert(windowController)
        
//        let vm = ViewModel()
//        vm.rootView = ProfileMainView(vm: vm)
//        vm.hostingController = HostingController(rootView: vm.rootView, vm: vm)
//        let windowControllerTemp = WindowController(rootView: vm.rootView, vm: vm)
//
//        // Remaining commands can be moved to WindowController.init(),
//        // but OpenDialog() is more conspicuous here:
//
//        vm.shotFilesOpenDialog(window: windowControllerTemp.window!)
//        windowControllerTemp.showWindow(nil) // nil=sender, not receiver.
        
        // controller is local var of this func, so
        // controller now de-inits, but window persists!
    }
}


//class HostingController: NSHostingController<ProfileMainView> {
//    let vm = ViewModel()
//    var windowControllerTemp: WindowController<ProfileMainView>!
//
//    init() {
//        let rootView = ProfileMainView(vm: vm)
//        super.init(rootView: rootView)
//        windowControllerTemp = WindowController(rootView: rootView, hostingController: self)
//        vm.shotFilesOpenDialog(window: windowControllerTemp.window!)
//        windowControllerTemp.showWindow(nil) // nil=sender, not receiver.
//    }
//
//    @objc required dynamic init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    deinit {
//        print("De-init of HostingController with profile:")
//        print(self.vm.profile.profileTitle ?? "NIL")
//    }
//}
