//
//  LandmarkList.swift
//  Landmarks
//
//  Created by sjp on 2021/11/19.
//

import SwiftUI

struct SearchBar: View {
    //Binding은 외부에서 값을 바인딩시킬수있다.
    //택스트필드에 들어갈 값을 저장하기위한 변수
    @Binding var text : String
    @State var editText : Bool = false
    
    var body: some View {
        HStack{
            //검색창을 받을수있는 택스트필드
            TextField("검색어를 넣어주세요" , text : self.$text)
            //hint와 태두리에 간격을 띄우기위해 15정도의 간격을주고
                .padding(15)
            //양옆은 추가로 15를 더줌
                .padding(.horizontal,15)
            //배경색상은 자유롭게선택
                .background(Color(.systemGray6))
            //검색창이 너무각지면 딱딱해보이기때문에 모서리를 둥글게
            //숫자는 취향것
                .cornerRadius(15)
            //내가만든 검색창 상단에
            //돋보기를 넣어주기위해
            //오버레이를 선언
                .overlay(
                    //HStack을 선언하여
                    //가로로 view를 쌓을수있도록 하나 만들고
                    HStack{
                        //맨오른쪽으로 밀기위해 Spacer()로 밀어준다.
                        Spacer()
                        //xcode에서 지원해주는 이미지
                        
                        if self.editText{
                            //x버튼이미지를 클릭하게되면 입력되어있던값들을 취소하고
                            //키입력 이벤트를 종료해야한다.
                            Button(action : {
                                self.editText = false
                                self.text = ""
                                //키보드에서 입력을 끝내게하는 코드
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }){
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color(.black))
                                    .padding()
                            }
                        }else{
                            //magnifyingglass 를 사용
                            //색상은 자유롭게 변경가능
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.black))
                                .padding()
                        }
                        
                    }
                ).onTapGesture {
                    self.editText = true
                }
        }
    }
}

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    @State var text : String = ""
    var leadingBarButton: AnyView?
    
    var filteredLandmarks: [Landmark] {
        if text.isEmpty {
            return modelData.landmarks.filter { landmark in
                (!showFavoritesOnly || landmark.isFavorite)
            }
        }
        else {
            return modelData.landmarks.filter {
                landmark in (landmark.name.lowercased().contains(text.lowercased()) && (!showFavoritesOnly || landmark.isFavorite))
//                $0.name.lowercased().contains(text.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List{
//                SearchBar(text: self.$text)
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
            .navigationBarItems(
                leading: self.leadingBarButton,
                // Edit button on the right to enable rearranging items
                trailing: EditButton())
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Landmark")
//        {
//            ForEach(filteredLandmarks.prefix(3), id: \.id)
//            { landmark in
//                    Text(landmark.name).searchCompletion(landmark.name)
//            }
//        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        //        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
        //            LandmarkList()
        //                .previewDevice(PreviewDevice(rawValue: deviceName))
        //                .previewDisplayName(deviceName)
        //        }
        LandmarkList()
            .environmentObject(ModelData())
    }
}
