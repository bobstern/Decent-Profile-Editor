//
//  Step View Builder.swift
//  Decent Profile Editor
//
//  Created by test on 9/19/21.
//

import SwiftUI

struct StepViewBuilder: View {
    @ObservedObject var vm : ViewModel
    @Binding var deleteStepAlert : Bool
    @Binding var actionIdx : Int?  // used by Delete alert dialog.
// @State private var stepBindCondx : Binding<ShotStep>
//    let forEachIndex : Int
//    var idx : Int {
//        if forEachIndex < vm.newProfile.shotSteps.count {
//            return forEachIndex
//        } else {
//            return 0
//        }
//    }
//    var stepBindingSafe : Binding<ShotStep> {
//        if forEachIndex < vm.newProfile.shotSteps.count {
//            return $vm.newProfile.shotSteps[forEachIndex]
//        } else {
//            return $vm.dummyShotStep  //$vm.newProfile.shotSteps[0]
//        }
//    }
    let idx: Int
    func stepBindingSafe(idx: Int) -> Binding<ShotStep> {
        if idx < vm.newProfile.shotSteps.count {
            return $vm.newProfile.shotSteps[idx]
        } else {
            return $vm.dummyShotStep  //$vm.newProfile.shotSteps[0]
        }
    }
    
    @ViewBuilder
    var body: some View {
            let stepBinding = stepBindingSafe(idx: idx) // $vm.newProfile.shotSteps[idx]
        
            // HStack has all UX elements except Swap button:
            HStack {
                Group {
                    Text(String(idx+1)).frame(width: 66, alignment: .trailing).padding(.trailing, 10)
                    TextField("", text: stepBinding.descrip).multilineTextAlignment(.leading).frame(width: 320)
                    
                    /// Temperature
                    Text("°C").padding(.leading, 30)
                    TextField("", text: stepBinding.temp).frame(width: 44)
                    
                    Spacer().frame(width: 60)
                    
                    /// Ramp
                    Picker("", selection: stepBinding.ramp) {
                        ForEach (Ramp.allCases, id: \.self) { choice in
                            Text(choice.display)
                        }
                    }.frame(width: 80).padding(.trailing, -8)
                    
                    /// Pump: Pressure or Flow
                    Picker("", selection: stepBinding.pumpType) {
                        ForEach (PumpTypes.allCases, id: \.self) { choice in
                            Text(choice.rawValue)
                        }
                    }.frame(width: 120, alignment: .trailing)
                    TextField("", text: stepBinding.pumpVal).frame(width: 44)
                }
                
                // Time
                Text("sec").frame(width: 80, alignment: .trailing)
                TextField("", text: stepBinding.time).frame(width: 44)
                
                Spacer().frame(width: 60)
                
                // Exit Condition
                Picker("", selection: stepBinding.exitType) {
                    ForEach (ExitTypes.allCases, id: \.self) { choice in
                        Text(choice.display)
                    }
                }.frame(width: 130, alignment: .trailing)
                
                // ZStack used merely to apply frame to align right boundary of blank space before buttons.
                ZStack {
                    if vm.newProfile.shotSteps[idx].exitType == .zero {
                        EmptyView()
                    } else {
                        TextField("", text: stepBinding.exitVal).frame(width: 44, alignment: .center).padding(.trailing, 8)
                    }
                }.frame(width: 100, alignment: .leading) // aligns buttons at right
                
                // Buttons have distinct style:
                Group {
                    /// "Duplicate" button:
                    Button(action: {duplicateStep(atIndex: idx)},
                           label: {Image("doc.on.doc-regular").resizable().frame(width: 24, height: 24)} ).padding(.trailing, 30)
                    /// "Delete" button:
                    Button(
                        action: {
                            actionIdx = idx
                            deleteStepAlert = true
                        },
                        label: {Image("trash-regular").resizable().frame(width: 23, height: 23)}
                    )
                }.buttonStyle(PlainButtonStyle())
                Spacer()
            }.multilineTextAlignment(.center).frame(height: 40) // end HStack
            
            // "Swap" button = row alternating w/ preceding HStack:
            if idx < vm.newProfile.shotSteps.count-1 {
                HStack{
                    Button(action: { moveDownOneStep(fromIndex: idx) },
                           label: {Image("arrow.triangle.swap-heavy").resizable().frame(width: 22, height: 22).opacity(0.5) } )
                        .padding(.leading, 10)
                        .frame(height: 40)
                        .buttonStyle(PlainButtonStyle()) // no border

                    Spacer()
                }
            }
        // } // end if idx < count
        }
    }
