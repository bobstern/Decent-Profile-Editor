//  Window Controller.swift
//  Decent Profile Editor
//
//  Created by bob on 11/26/2021.

import SwiftUI

/// ProfileWindowController retains vm for each profile

class ProfileWindowController<RootView: View>: NSWindowController, ObservableObject {
    @Published var vm: ViewModel
    //    convenience init(rootView: RootView) {
    init(rootView: RootView, vm: ViewModel) {
        print("INIT Profile View Controller")
        self.vm = vm
        let hostingController = NSHostingController(
            rootView: rootView.frame(width: 1400, height: 400)
        )
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 1400, height: 400) )
        super.init(window: window)
        self.shouldCascadeWindows = true // ignored!
        window.cascadeTopLeft(from: CGPoint(x: 20, y: 0))
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
            let rootView = ProfileView(vm: vm)
            let controller = ProfileWindowController(rootView: rootView, vm: vm)
            controller.window?.title = "New window"
            controller.showWindow(nil) // nil=sender, not receiver.
        }
    }
}
