//
//  ContentView.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 30/03/21.
//

import SwiftUI
import URLImage
import ActivityIndicatorView

struct ContentView: View, PresentorToHomeView {
    
    
    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
    }
    @State private var selection: Int? = 0
    @State private var tapOnSection = false
    @State var dragOffset: CGSize = CGSize(width: 0, height: (UIScreen.main.bounds.height/2 + UIScreen.main.bounds.height/4) - 100)
    

    @ObservedObject var viewModel: HomeScreenViewModel
    public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    @State private var tabSelection = 0

    var body: some View {
        NavigationView {
            
            ZStack(alignment: .leading) {
                
                ///To show the activity indicator until data load up
                ActivityIndicatorView(isVisible: $viewModel.loading, type: .growingCircle)
                    .foregroundColor(.red)
                    .zIndex(1)
                
                GeometryReader { g in
                    ///Auto scrolling images on Home Screen
                    TabView(selection : $tabSelection) {
                        ForEach(0..<7){ i in
                            Image("\(viewModel.imageData[i])")
                                  .resizable()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: g.size.height - 200)
                          }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(width: g.size.width, height: g.size.height/2 + g.size.height/4)
                    .onReceive(timer, perform: { _ in
                                    
                                withAnimation{
                                    print("selection is",tabSelection)
                                    tabSelection = tabSelection < 5 ? tabSelection + 1 : 0
                                }
                                
                                
                            })
                    
                    ///Load Table View
                    TableviewRouter.assumblyModule(items: $viewModel.items, selectedCategory: $viewModel.selectedCategory, tapOnSection: $tapOnSection, onDragStarted: { (value) in
                        self.dragOffset = value.translation
                    }, onDragEnd: { (value) in
                        if value.translation.height < 0 {
                            self.dragOffset = CGSize(width: 0, height: 100)
                        } else {
                            self.dragOffset = CGSize(width: 0, height: (UIScreen.main.bounds.height/2 + UIScreen.main.bounds.height/4) - 100)

                        }                }, g: g)
                    .frame(width: g.size.width, height:(UIScreen.main.bounds.height - 100))
                    .animation(.spring())
                    .offset(y: self.dragOffset.height)
                    
                    ///Put the navigation to Next Screen
                    NavigationLink(destination: homeViewToPresentor.navigateToCart(), tag: 1, selection: $selection) {
                    }
                    Button(action: {
                        self.selection = 1
                    }, label: {
                        Image("cart")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    })
                    .offset(x: UIScreen.main.bounds.width - 100 ,y: UIScreen.main.bounds.height - 250)
                    
                    ///Show alert on network failure
                    .alert(isPresented: $viewModel.error) {
                                Alert(title: Text("Network Error"), message: Text("Please kill the app & retry"), dismissButton: .default(Text("Got it!")))
                            }
                    
                }
            }.onAppear(){
                homeViewToPresentor.viewDidLoad()
            }
            .navigationBarTitle("Menu", displayMode: .inline)
            
        }.edgesIgnoringSafeArea(Edge.Set(.bottom))
    }
    var homeViewToPresentor: HomeViewToPresentor!

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let homeviewModel = HomeScreenViewModel()
        ContentView(viewModel: homeviewModel)
    }
}
