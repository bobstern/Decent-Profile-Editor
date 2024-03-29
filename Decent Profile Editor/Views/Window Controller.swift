//  Window Controller.swift
//  Decent Profile Editor
//
//  Created by bob on 11/26/2021.

import SwiftUI
import AppKit

class WindowController<RootView: View>: NSWindowController, NSWindowDelegate {
    
    let win: NSWindow!
    
    init(rootView: RootView) {
        // rootView = SwiftUI ProfileMainView instantiated in ViewModel init.
        let hostingController = NSHostingController(rootView: rootView)
        win = NSWindow(contentViewController: hostingController) // contentViewController = instance property.
        super.init(window: win) // window = property inherited fm NSWindowController superclass.
        win.delegate = self
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
    
    // NSWindowDelegate:
    func windowWillClose(_ notification: Notification) {
        print("Window will close.")
        self.dismissController(nil)
    }
    
// When window, closes, func windowWillClose is called,
// but dismiss does not de-init controller.
        deinit {
            print("De-init WindowController for window \(self.win.title)")
        }
    
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
