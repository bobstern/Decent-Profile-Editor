//
//  ContentView.swift
//  Decent Profile Editor
//
//  Created by bob on 5/04/2021.
//

import SwiftUI

let profileViewTemp = ProfileView(vm: ViewModel() )

struct ProfileView: View {
    @ObservedObject var vm : ViewModel
    @State private var actionIdx : Int?
    @State private var deleteStepAlert = false

    var body: some View {
//        let newSteps = vm.newProfile.shotSteps
//        let newBind = $vm.newProfile.shotSteps
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button("Open Another Profile") {vm.shotFilesOpenDialog()}.padding(.leading, 8)
                Button("Copy to Clipboard") {_ = vm.newProfile.encodeTcl(toClipboard: true)}.padding(.leading, 30)
                if vm.dirty {
                    Button("**SAVE**") {vm.tclSavePanel()}.padding(.leading, 30).font(Font.system(size: 18, weight: .bold)) //.foregroundColor(.red) // Red distracting.
                } else {
                    Button("  Save  ", action: {vm.tclSavePanel()}).padding(.leading, 30).font(Font.system(size: 18))
                }
                Spacer()
            }
            
/// Profile-wide parameters:
            ProfileGlobalsView(vm: vm)
            
            Divider().frame(height: 1.5).background(Color.black) // height=thickness
            
/// Shot Steps:
            if vm.deleteBugBlankDisplay == true {
                Text("")
            } else {
                StepsView(vm: vm, deleteStepAlert: $deleteStepAlert, actionIdx: $actionIdx)
            }

        } // ContentView outermost VStack
        .frame(minWidth: 1400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
        .padding(.leading, 8)
        .padding(.top, 20)
        .font(Font.system(size: 18))
        .alert(isPresented: $vm.overwriteFileAlert) {
            Alert(
                title: Text("File already exists. Do you want to replace it?"),
                message: nil,
                primaryButton: .default(
                    Text("Cancel"),
                    action: {}
                ),
                secondaryButton: .destructive(
                    Text("Replace"),
                    action: {vm.tclSaveImmediately()}
                )
            )
        }
        .alert(isPresented: $deleteStepAlert) {
            Alert(
                title: Text("Delete step \(actionIdx! + 1)?"),
                message: nil,
                primaryButton: .default(
                    Text("Cancel"),
                    action: {}
                ),
                secondaryButton: .destructive(
                    Text("Delete"),
                    action: {
                        // vm.deleteBugBlankDisplay = true // fails to fix crash if delete last row.
                        vm.deleteStep(atIndex: actionIdx!)
                    }
                )
            )
        }

        
    }
} // ContentView View


// Preview omits sub-views:
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(vm: vm)
//    }
//}
