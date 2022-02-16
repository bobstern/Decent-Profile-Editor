//  ViewModel.swift
//  Decent Profile Editor

import SwiftUI


// let vm = ViewModel.singleton // 1-window only.
class ViewModel : ObservableObject {
    // static let singleton = ViewModel()
//    weak var window: NSWindow? // window retains vm.
//    var rootView: ProfileMainView!
//    var hostingController: NSHostingController<ProfileMainView>!
//    init () {
//        let rootView = ProfileMainView(vm: self)
//        let hostingController = NSHostingController(rootView: self.rootView)
//    } // was private for singleton single-window version
    
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

    
    func setDirty() {
        dirty = true
    }
    
    // Controller deinits immediately, but window persists.
    // Why does window appear to retain view model?
    // View model de-inits when window closed.
    deinit {
        print("De-init of view model \(self.profile.profileTitle)")
    }
}
