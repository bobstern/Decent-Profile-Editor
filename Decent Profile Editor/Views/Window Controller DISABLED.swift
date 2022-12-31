//  Window Controller.swift
//  Decent Profile Editor
//
//  Created by bob on 11/26/2021.

import SwiftUI
import AppKit

//class Window<RootView: View>: NSWindow, ObservableObject {
//    @Published var vm: ViewModel
//    init(hostingController: NSHostingController<ProfileMainView>, vm: ViewModel) {
////    init(rootView: ProfileMainView, vm: ViewModel) {
//        self.vm = vm
////      let hostingController = NSHostingController(rootView: rootView)
//        let viewController = hostingController as NSViewController
//        super.init(contentViewController: viewController) // error: must call a designated initializer of NSWindow.
//    }
//}

//class HostingController: NSHostingController<ProfileMainView>, ObservableObject {
//    @Published var vm: ViewModel
//    // var coder: NSCoder = NSCoder()
//    init(rootView: ProfileMainView, vm: ViewModel) {
//        self.vm = vm
//        super.init(rootView: rootView)
//    }
//} // error: subclass of NSHostingController must provide initializer init(coder:)

/*
class WindowController<RootView: View>: NSWindowController, ObservableObject {
    @Published var vm: ViewModel
    
    
    init(rootView: RootView, vm: ViewModel) {
        self.vm = vm
        
        // rootView = SwiftUI ProfileView instantiated in AppDelegate.newWindow():
        let hostingController = NSHostingController(rootView: rootView)
        let win = NSWindow(contentViewController: hostingController) // contentViewController = instance property.
        super.init(window: win) // window = property inherited fm NSWindowController superclass.
        super.window!.setContentSize(NSSize(width: 1400, height: 1000) ) // Initial size accommodates 8 steps.
        
        // Windows cascade only vertically; all have same x alignment.
        // x sets offset from screen left.  y ignored, so set to zero.
        self.shouldCascadeWindows = true // ignored.
        super.window!.cascadeTopLeft(from: CGPoint(x: 10, y: 0) ) // Weird position if x=0.
        
        // Failed attempts to increase cascade offset:
        // let winOrigin = window.frame.origin
        // window.cascadeTopLeft(from: CGPoint(x: position.minX+20, y: position.maxY+20))
        // window.setFrameTopLeftPoint(CGPoint(x: position.minX+0, y: position.maxY+0))
        // window.setFrameOrigin(CGPoint(x: winOrigin.x + 0.0, y: winOrigin.y + 0.0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// NSWindowController deinits immediately, but window persists:
    //    deinit {
    //        print("Closed WindowController for window \(self.window?.title)")
    //    }
    
}



//struct MasterView: View {
//    var body: some View {
//        Button("Show New Window") {
//            //            let controller = WindowController(
//            //                rootView: ProfileView(vm: ViewModel() )) )
//            let vm = ViewModel()
//            let rootView = ProfileMainView(vm: vm)
//            let controller = WindowController(rootView: rootView, vm: vm)
//            controller.window?.title = "New window"
//            controller.showWindow(nil) // nil=sender, not receiver.
//        }
//    }
//}
