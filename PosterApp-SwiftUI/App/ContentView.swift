//
//  ContentView.swift
//  PosterApp-SwiftUI
//
//  Created by hakkı can şengönül on 11.06.2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var isAnimating : Bool = false
    @State private var imageScale : CGFloat = 1
    @State private var imageOffset : CGSize = .zero
    @State private var isDrawerOpen : Bool = false
    let pages : [Page] = pagesData
    @State private var pageIndex : Int = 1
    // MARK: - FUNCTIONS
    func resetImageState(){
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    func currentPage() -> String {
        return pages[pageIndex - 1].imageName
    }
    // MARK: - BODY
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.clear
                Image(currentPage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            resetImageState()
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    }else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            })
                            .onEnded({ _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                }else if imageScale <= 1{
                                    resetImageState()
                                }
                            })
                        
                    )
                
            }//ZStack
            
            .navigationTitle("Poster App")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    isAnimating = true
                }
            }
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset).padding(.horizontal).padding(.top,30),alignment: .top
            )
            .overlay(
                Group{
                    HStack {
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                }
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                }
                                if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                        
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }.padding(.bottom,30),
                alignment: .bottom
            )
            .overlay(
                HStack(spacing: 12){
                    Image(systemName:isDrawerOpen ? "chevron.compact.right" :  "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height:40)
                        .padding()
                        .foregroundColor(Color.secondary)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.6)) {
                                isDrawerOpen.toggle()
                            }
                        }
                    ForEach(pages){item in
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width:80)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5),value: isDrawerOpen)
                            .onTapGesture {
                                
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isDrawerOpen = false
                                    isAnimating = true
                                    pageIndex = item.id
                                }
                            }
                    }
                    Spacer()
                    
                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width: 260)
                    .padding(.top,UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOpen ? 20 : 215)
                ,alignment: .topTrailing
                
            )
        }//NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
