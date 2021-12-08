//  Window Controller.swift
//  Decent Profile Editor
//
//  Created by bob on 11/26/2021.

import SwiftUI

/// ProfileWindowController retains vm for each profile

class ProfileWindowController<RootView: View>: NSWindowController, ObservableObject {
    @Published var vm: ViewModel
    
    init(rootView: RootView, vm: ViewModel) {
        self.vm = vm
        let hostingController = NSHostingController(
            rootView: rootView // rootView = SwiftUI ProfileView instantiated in AppDelegate.newWindow().
        )
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 1400, height: 1000) ) // Initial size accommodates 8 steps.
        super.init(window: window)
        self.shouldCascadeWindows = true // ignored!
        
        // Windows cascade only vertically; all have same x alignment.
        // x sets offset from screen left.  y ignored, so set to zero.
        window.cascadeTopLeft(from: CGPoint(x: 10, y: 0) ) // Weird position if x=0.
        
        // Failed attempts to increase cascade offset:
        // let winOrigin = window.frame.origin
        // window.cascadeTopLeft(from: CGPoint(x: position.minX+20, y: position.maxY+20))
        // window.setFrameTopLeftPoint(CGPoint(x: position.minX+0, y: position.maxY+0))
        // window.setFrameOrigin(CGPoint(x: winOrigin.x + 0.0, y: winOrigin.y + 0.0))
        
        vm.shotFilesOpenDialog()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

struct MasterView: View {
    var body: some View {
        Button("Show New Window") {
            //            let controller = ProfileWindowController(
            //                rootView: ProfileView(vm: ViewModel() )) )
            let vm = ViewModel()
            let rootView = ProfileMainView(vm: vm)
            let controller = ProfileWindowController(rootView: rootView, vm: vm)
            controller.window?.title = "New window"
            controller.showWindow(nil) // nil=sender, not receiver.
        }
    }
}
