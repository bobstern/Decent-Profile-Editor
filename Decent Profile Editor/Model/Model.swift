//  ViewModel.swift
//  Decent Profile Editor

import SwiftUI
import AppKit

class Model : ObservableObject {

//    var window: NSWindow?
    var windowController: WindowController<ProfileMainView>!
    
    init () {
        let rootView = ProfileMainView(vm: self)
/*
        let hostingController = NSHostingController(rootView: rootView)
        self.window = NSWindow(contentViewController: hostingController)
        window?.delegate = self
        window?.setContentSize(NSSize(width: 1400, height: 1000) ) // Initial size accommodates 8 steps.
        let windowController = NSWindowController(window: self.window)
*/
        windowController = WindowController(rootView: rootView)
        shotFilesOpenDialog(window: self.windowController.win)
        windowController.window?.title = profile.profileTitle
        windowController.showWindow(nil) // nil=sender, not receiver.
        
        // controller is local var of this func, so
        // controller now de-inits, but window persists!
    }
    
    
    
    // Initializing to default values reqd to instantiate singleton.
    // Defaults are reasonable for Profile but arbitrary for ShotStep.
    // @Published var oldProfile = Profile()
    @Published var profile = Profile() {didSet {dirty = true} }
    @Published var overwriteFileAlert = false
    @Published var overwriteFilePath = ""
    @Published var dirty = false
    @Published var deleteBugBlankDisplay = false
    var saveButtonTxt : String {
        switch dirty {
        case true:
            return "**SAVE**"
        case false:
            return "  Save  "
        }
    }
    // @Published var overwriteFileConfirmed = false
    // @Published var currentStep = ShotStep()
    
    var dummyShotStep = ShotStep()

    
//    func setDirty() {
//        dirty = true
//    }
    
    // Controller deinits immediately, but window persists.
    // Why does window appear to retain view model?
    // View model de-inits when window closed.
    deinit {
        print("De-init of view model \(self.profile.profileTitle)")
    }
}
