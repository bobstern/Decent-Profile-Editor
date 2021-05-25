//
//  ContentView.swift
//  Decent Profile Editor
//
//  Created by bob on 5/04/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm : ViewModel

    var body: some View {
//        let newSteps = vm.newProfile.shotSteps
//        let newBind = $vm.newProfile.shotSteps
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button("Open Another Profile") {shotFilesOpenDialog()}.padding(.leading, 8)
                Button("Copy to Clipboard") {_ = vm.newProfile.encodeTcl(toClipboard: true)}.padding(.leading, 30)
                if vm.dirty {
                    Button("**SAVE**") {tclSavePanel()}.padding(.leading, 30).font(Font.system(size: 18, weight: .bold)) //.foregroundColor(.red) // Red distracting.
                } else {
                    Button("  Save  ", action: {tclSavePanel()}).padding(.leading, 30).font(Font.system(size: 18))
                }
                Spacer()
            }
            
/// Profile-wide parameters:
            ProfileParametersView(vm: vm)
            
            Divider().frame(height: 1.5).background(Color.black) // height=thickness
            
/// Shot Steps:

            StepsView(vm: vm)
        } // ContentView outermost VStack
        .frame(minWidth: 1460, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
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
                    action: {tclSaveImmediately()}
                )
            )
        }

        
    }
} // ContentView View


// Preview omits sub-views:
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: vm)
    }
}
