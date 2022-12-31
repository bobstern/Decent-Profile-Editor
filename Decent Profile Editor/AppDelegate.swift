//  AppDelegate.swift
//  Decent Profile Editor


import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    
    var viewModels = [Model] ()
    
    // var window: NSWindow! //  Deleted cuz superseded by newWindow()
    
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
    
    // Hudson's example of NSHostingController says nothing about ViewModel.
    
    // 7/6/22: This instantiation hierarchy is WRONG.
    // newWindow() should instantiate a WindowController
    // whose init should instantiate a ViewModel (retained as a property of the WindowController),
    // then instantiate NSHostingController (also retained by WinCon).
    // I did it backwards, with the ViewModel retaining the WindowController.
    // Q: who should retain the WindowController instances?
    // This is a standard AppKit scenario.
    // Replace AppDelegate's viewModels array with a windowControllers array?

    func newWindow() {
        let vm = Model()
        viewModels.append(vm) // Closing window does not de-init VM.
        
        /*
         let rootView = ProfileMainView(vm: vm)
         let controller = WindowController(rootView: rootView, vm: vm)
         
         // Remaining commands can be moved to WindowController.init(),
         // but OpenDialog() is more conspicuous here:
         
         vm.shotFilesOpenDialog(window: controller.window!)
         controller.showWindow(nil) // nil=sender, not receiver.
         
         // controller is local var of this func, so
         // controller now de-inits, but window persists!
         */
    }
    
    // Compiler says vm=nil is illegal, even if vm is inout parameter.
    // If vm is held by WindowController, can deinit vm by calling dismissController()?
    // dismiss may not de-init.
    func windowClosed(vm: inout Model) {
//            vm = nil
    }
}

