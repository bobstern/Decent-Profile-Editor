//  Profile Main View.swift
//  Decent Profile Editor

import SwiftUI

struct ProfileMainView: View {
    @ObservedObject var vm : ViewModel
    @State private var actionIdx : Int?
    @State private var deleteStepAlert = false
    
    var body: some View {
        //        let newSteps = vm.newProfile.shotSteps
        //        let newBind = $vm.newProfile.shotSteps
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Button("Open Another Profile") {vm.shotFilesOpenDialog(window: vm.profile.window!)}.padding(.leading, 8)
                    Button("Copy to Clipboard") {_ = vm.profile.encodeTcl(toClipboard: true)}.padding(.leading, 30)
                    if vm.dirty {
                        Button("**SAVE**") {vm.tclSavePanel()}.padding(.leading, 30).font(Font.system(size: 18, weight: .bold)) //.foregroundColor(.red) // Red distracting.
                    } else {
                        Button("  Save  ", action: {vm.tclSavePanel()}).padding(.leading, 30).font(Font.system(size: 18))
                    }
                    Spacer()
                }
                
                /// Profile-wide parameters:
                ProfileGlobalsView(vm: vm)
                
                Spacer().frame(height: 20)
                Divider().frame(height: 1.5).background(Color.black) // height=thickness
                Spacer().frame(height: 30)
                
                
                /// Shot Steps:
                if vm.deleteBugBlankDisplay == true {
                    Text("")
                } else {
                    StepsArrayView(vm: vm, deleteStepAlert: $deleteStepAlert, actionIdx: $actionIdx)
                }
                
            } // ContentView outermost VStack.
            // idealHeight omitted cuz ignored on Mac:
            .frame(minWidth: 1400, maxWidth: 1400, minHeight: 400, maxHeight: .infinity)
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
            } // end .alert(isPresented: $deleteStepAlert)
            
        } // scroll view
        
    } // body
    
} // ContentView View


// Preview omits sub-views:
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(vm: vm)
//    }
//}
