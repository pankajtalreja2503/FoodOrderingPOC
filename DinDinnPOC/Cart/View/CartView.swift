//
//  CartView.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 03/04/21.
//

import SwiftUI
import URLImage
///Cart view creation
struct CartView: View, PresentorToCartView {
    @Environment(\.presentationMode) var presentation

    var cartViewToPresentor: CartViewToPresentor!
    @State private var showingAlert = false

    
    @State var selectedCategory: String = "Orders"
    @ObservedObject var viewModel: CartViewModel

    var body: some View {
        VStack(alignment: .leading) {
            
            ///Cart view Header creation
            CartHeader(selectedCategory: $selectedCategory)
            
            List{
                ForEach(viewModel.cart.cartItems, id:\.name) { order in
                    ///Cell creation for List
                    HStack {
                        URLImage(url: URL(string: order.imageURL)!,
                                 content: { image in
                                    image
                                        .resizable()
                                 })
                            .frame(minWidth: 30, maxWidth: 50, minHeight: 30, maxHeight: 50)
                        
                        Text(order.name)
                        Text("\(order.quantity)")
                        
                        
                        Spacer()
                        Text("\(order.price) usd")
                        Image(systemName: "xmark.circle.fill").onTapGesture {
                            cartViewToPresentor.deleteOrder(name: order.name)

                        }
                    }
                }
            }
            Divider()
            HStack {
                Text("Delivery Charge")
                Text("Free")
                    .fontWeight(.bold)
            }
            .padding()
            HStack{
                Text("Total Price")
                Text("\(viewModel.cart.total)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }
            .padding()
            
            //Place Order button
            HStack {
                    Spacer()
                    Button {
                        showingAlert = true
                    } label: {
                        Text("Place Order")
                            .frame(minWidth: 50, maxWidth: 100, minHeight: 30, maxHeight: 50)
                    }
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(3)
                    .cornerRadius(20)
                    Spacer()
            }
            

            Spacer()
            //oder place successfully alert

                .alert(isPresented: $showingAlert) { () -> Alert in
                            let button = Alert.Button.default(Text("Place order")) {
                                cartViewToPresentor.deleteAllData()
                                presentation.wrappedValue.dismiss()
                            }
                            return Alert(title: Text("Confirmation"), message: Text("Do you wamt to place the order"), dismissButton: button)
                        }
            
        }.onAppear(){
            cartViewToPresentor.viewDidLoad()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel())
    }
}

///Cart view Header creation
struct CartHeader: View {
    var CartCategories = ["Orders"]
    @Binding var selectedCategory: String
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(CartCategories, id: \.self) { category in
                    Text(category)
                        .foregroundColor(selectedCategory == category ? .black : .gray)
                        .font(.largeTitle)
                        .background(Color.white)
                        .padding()
                        
                        .onTapGesture(count: 1, perform: {
                            selectedCategory = category
                        })
                }
                
            }
        }
        .background(Color.white)
    }
}
