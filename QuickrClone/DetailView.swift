////
////  DetailView.swift
////  QuickrClone
////
////  Created by Aarish Rahman on 29/08/21.
////
//
//import SwiftUI
//import Firebase
//
//struct DetailView: View {
//    @ObservedObject private var viewModel = ListViewModel()
//    var body: some View {
//        VStack{
//            ScrollView{
//                ForEach(viewModel.list){list in
//                    if Auth.auth().currentUser?.email == list.sender{
//                        if listName == list.name{
//                        VStack(alignment: .leading){
//
//                            Image(uiImage: list.imgUrl.load())
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .padding()
//                            VStack(alignment: .leading){
//                                Text(list.name)
//                                    .font(.title)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.white)
//
//
//                                Text(list.category)
//                                    .font(.title2)
//                                    .foregroundColor(.gray)
//                                Text("Description")
//                                    .font(.title3)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.white)
//                                Text(list.description)
//                                    .font(.caption)
//                                    .foregroundColor(.gray)
//                            }
//                            .padding()
//
//                        }
//                        .onAppear(){
//                            self.viewModel.fetchData()
//                            isDisabled = true
//                             }
//                        .matchedGeometryEffect(id: "container \(list.id!)", in: namespace)
//                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//                        .edgesIgnoringSafeArea(.all)
//                        .navigationBarBackButtonHidden(true)
//                        .navigationBarHidden(true)
//                        }
//
//                    }
//                }
//            }
//        }
//        CloseButton()
//            .onTapGesture {
//                withAnimation(.spring()){
//                    show.toggle()
//
//                    DispatchQueue.main.asyncAfter(deadline:.now() + 0.3) {
//                        isDisabled = false
//                    }
//                }
//            }.padding(.trailing,16)
//
//    }
////    }
////}
//
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
