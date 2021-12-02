//  ProfileParameters View.swift
//  Decent Profile Editor


import SwiftUI

struct ProfileGlobalsView: View {
    @ObservedObject var vm : ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
      
            HStack {
                Text("Profile Title:").padding(.trailing, -4)
                TextField("", text: $vm.newProfile.profileTitle).frame(width: 500, alignment: .leading)
                Spacer()
            }//.padding(.vertical, 20)
            
            HStack {
                Text("Track volume AFTER step:").padding(.trailing, -4)
                TextField("", text: $vm.newProfile.volume_track_after_step).multilineTextAlignment(.center).frame(width: 40)
                Spacer()
                Text("Flow limiter range:").padding(.trailing, -4)
                TextField("", text: $vm.newProfile.profileFlowLimiterRange).multilineTextAlignment(.center).frame(width: 50).padding(.trailing, 50)
            }//.padding(.vertical, 20)
            
            HStack {
                Text("Stop at Volume (0 = Off):").padding(.trailing, 4)//.frame(width: 250, alignment: .trailing)
                TextField("", text: $vm.newProfile.stopVolume).multilineTextAlignment(.center).frame(width: 40)
                Spacer()
                Text("Pressure limiter range:").frame(width: 300, alignment: .trailing).padding(.trailing, -4)
                TextField("", text: $vm.newProfile.profilePressureLimiterRange).multilineTextAlignment(.center).frame(width: 50).padding(.trailing, 50)
            }//.padding(.vertical, 20)
        }
        .padding(.leading, 8)
        .padding(.bottom, 0)
        .padding(.top, 20)
        .font(Font.system(size: 18))
    }
}


// Preview omits sub-views:
//struct ProfileParametersView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileParametersView(vm: vm)
//    }
//}
