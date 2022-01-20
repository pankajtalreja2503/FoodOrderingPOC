//
//  HomeTableView.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 04/04/21.
//

import SwiftUI
import URLImage

struct HomeTableView: View, PresentorToHomeTableView {
    let screenSize = UIScreen.main.bounds.size

    var homeTableViewToPresentor: HomeTableViewToPresentor!
    
    @Binding private var items: [Categories]
    
    @State private var categoryItems = [CategoryItems]()
        
    init(items: Binding<[Categories]>, selectedCategory: Binding<String>, tapOnSection: Binding<Bool>, onDragStarted: @escaping (DragGesture.Value) -> (), onDragEnd: @escaping (DragGesture.Value) -> (), g: GeometryProxy, viewModel: HomeScreenTableViewModel) {
        self._selectedCategory = selectedCategory
        self._tapOnSection = tapOnSection
        self.onDragStarted = onDragStarted
        self.onDragEnd = onDragEnd
        self.g = g
        self.viewModel = viewModel
        self._items = items
    }
    
    @ObservedObject var viewModel: HomeScreenTableViewModel
    
    @Binding private var selectedCategory: String
    @Binding private var tapOnSection: Bool
    @State private var buttonTapped: Bool = false
    @State private var selectedProduct = ""
    var onDragStarted: (DragGesture.Value) -> ()
    var onDragEnd: (DragGesture.Value) -> ()
    
    private var g: GeometryProxy
    
    var body: some View {
        List {
            
            ///Table view section creation
            Section(header: ListHeader(items: $items,tapOnSection: $tapOnSection, selectedCategory: $selectedCategory, onDragStarted: onDragStarted, onDragEnd: onDragEnd)) {
                
                ForEach(categoryItems, id: \.title) { item in
                    
                    ///Table viewCell creation
                    VStack(alignment: .leading) {
                        
                        URLImage(url: URL(string: item.imageURL)!,
                                 content: { image in
                                    image
                                        .resizable()
                                 })
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 250)
                            .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                        
                        HStack {
                            Text(item.title)
                                .bold()
                                .font(.title)
                            Spacer()
                        }
                        
                        Text(item.ingredients)
                            .font(.title)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        HStack {
                            Text(item.sizeAndWight)
                            
                            Spacer()
                            
                            Button {
                                buttonTapped = true
                                selectedProduct = item.title
                                let cartModel = CartModel(name: item.title, categoryName: selectedCategory, price: item.price, quantity: 1, imageURL: item.imageURL)
                                cartModel.saveOrder()
                                
                                let deadlineTime = DispatchTime.now() + .seconds(1)
                                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                                    buttonTapped = false
                                }
                                
                            } label: {
                                Text((buttonTapped && selectedProduct == item.title) ? "Added + 1" : "\(item.price, specifier: "%.2f") usd")
                                    .frame(minWidth: 50, maxWidth: 100, minHeight: 30, maxHeight: 50)
                                
                            }
                            .background((buttonTapped && selectedProduct == item.title) ? Color.green : Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(3)
                            .cornerRadius(20)
                        }
                        
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .cornerRadius(20)
            .onChange(of: selectedCategory, perform: { (_) in
                categoryItems = homeTableViewToPresentor.filterMenu(onSelection: selectedCategory, itemsArray: items)
                
            })
            .background(Color.white)
        } .listStyle(GroupedListStyle())
        .background(Color(#colorLiteral(red: 0.7940633893, green: 0.8789027929, blue: 0.8980514407, alpha: 1)))
        .cornerRadius(20.0)
    }
}


///Section view creation
struct ListHeader: View {
    @Binding var items: [Categories]
    @Binding var tapOnSection: Bool
    @Binding var selectedCategory: String
    var onDragStarted: (DragGesture.Value) -> ()
    var onDragEnd: (DragGesture.Value) -> ()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(items, id: \.categoryName) { category in
                    Text(category.categoryName)
                        .foregroundColor(selectedCategory == category.categoryName ? .black : .gray)
                        .font(.largeTitle)
                        .background(Color.white)
                        .padding()
                        
                        .onTapGesture(count: 1, perform: {
                            selectedCategory = category.categoryName
                        })
                }
                
            }
        }
        .gesture(DragGesture()
                    .onChanged    (onDragStarted)
                    .onEnded(onDragEnd))
        //        .onTapGesture(count: 1, perform: {
        //            tapOnSection = true
        //        })
        //        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
    }
}
