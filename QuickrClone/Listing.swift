//
//  Listing.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 25/08/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import URLImage


struct Listing: View {
    
    @ObservedObject private var viewModel = ListViewModel()
    @State private var showAddScreen = false
    @State var Model = ListsViewModel()
    @Namespace var namespace
    @State private var show = false
    @State var isDisabled = false
    @State var listName = ""
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.fixed( 160), spacing: 16),
                              GridItem(.fixed( 160), spacing: 16)]
                   
                ){
                
                ForEach(viewModel.list){list in
                    
                    if Auth.auth().currentUser?.email == list.sender{
                        
                        VStack{
                            
                            VStack{
                                Image(uiImage: list.imgUrl.load())
                                    .resizable()
                                    .frame(width:100,height: 100)
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                VStack{
                                    Text(list.name)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)

                                    Text(list.category)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()

                            }
                            .matchedGeometryEffect(id: list.id, in: namespace,isSource: !show)
                            .frame( height: 200)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    show.toggle()
                                    isDisabled = true
                                    listName = list.name
                                }
                            }
                            
                            .padding(.bottom)
                            .background(Color("Background 5"))
                            .cornerRadius(15)
                        }
                        .isHidden(isDisabled)
                        .disabled(isDisabled)
                        .matchedGeometryEffect(id: "container \(list.id!)", in: namespace,isSource: !show)
                    }
                    }
                
                
            }
            
            .navigationBarTitle("Browse")
            .padding(16)
            .frame(maxWidth: .infinity)
            .navigationBarItems(trailing:
                                    Button(action: {showAddScreen.toggle()}, label: {
                                        Image(systemName: "plus")
                                    }))
            .onAppear(){
                self.viewModel.fetchData()
                 }
            
            .sheet(isPresented: $showAddScreen, content: {
                AddItem()
            })
        }
        
        .zIndex(1)
        
            
            if show{
                ZStack(alignment: .topTrailing){
                    VStack{
                        ScrollView{
                            ForEach(viewModel.list){list in
                                if Auth.auth().currentUser?.email == list.sender{
                                    if listName == list.name{
                                    VStack(alignment: .leading){
                                        
                                        Image(uiImage: list.imgUrl.load())
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding()
                                        VStack(alignment: .leading){
                                            Text(list.name)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)


                                            Text(list.category)
                                                .font(.title2)
                                                .foregroundColor(.gray)
                                            Text("Description")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            Text(list.description)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                        
                                    }
                                    .onAppear(){
                                        self.viewModel.fetchData()
                                        isDisabled = true
                                         }
                                    .matchedGeometryEffect(id: "container \(list.id!)", in: namespace)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    .edgesIgnoringSafeArea(.all)
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true)
                                    }
                                    
                                }
                            }
                        }
                    }
                    CloseButton()
                        .onTapGesture {
                            withAnimation(.spring()){
                                show.toggle()
                               
                                DispatchQueue.main.asyncAfter(deadline:.now() + 0.3) {
                                    isDisabled = false
                                }
                            }
                        }.padding(.trailing,16)
                    
                }.zIndex(2)
            }
        }
        
    }
    func nameList() -> String{
        return listName
    }
   
}

struct Listing_Previews: PreviewProvider {
    static var previews: some View {
        Listing()
    }
}
extension View {
    
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
extension String{
    func load() -> UIImage{
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        } catch  {
            
        }
        return UIImage()
    }
}
