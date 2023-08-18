//
//  ContentView.swift
//  GPT_Messenger
//
//  Created by rouzbeh on 17.08.23.
//

import SwiftUI



struct ContentView: View {
    @StateObject var viewModel = ChatViewModel()
    @State private var messageText = ""
    @State private var showChatGPTText = true
    var body: some View {
        VStack {
            if showChatGPTText {
                LoadingAnimation().frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(showChatGPTText ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: showChatGPTText) // Add fade animation
                    .onAppear {
                        // Hide the chatGPT text after 2 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showChatGPTText = false
                            }
                        }
                    }  .background(.black)
            } else {
                VStack {
                    if (viewModel.messages).count > 0 {
                        ScrollViewReader { scrollProxy in
                            ScrollView {
                                ForEach(viewModel.messages, id: \.self) {
                                    value in
                                    MessageView(message: value).id(value)
                                }.listRowBackground(Color.clear).listRowSeparator(.hidden)
                            }.padding().onAppear {
                                print(viewModel.messages)
                                scrollProxy.scrollTo(viewModel.messages[viewModel.messages.endIndex - 1], anchor: .bottom)
                            } .onChange(of: viewModel.messages) { _ in
                                // Scroll to the bottom when messages change
                                withAnimation {
                                    scrollProxy.scrollTo(viewModel.messages.last)
                                }
                            }.background(Color.white.opacity(0.2)).scrollContentBackground(.hidden)
                                .padding(.top, 20)
                        }
                    } else {
                        ZStack { Color.clear
                            Text("Start by writing something").font(.largeTitle).foregroundColor(.black).padding()
                        }
                    }
                    
                    if viewModel.isTyping {
                        HStack(alignment: .center) {
                            Spacer()
                            TypingAnimationView()
                            Spacer()
                        }
                    }
                    HStack {
                        TextField("Type your message...", text: $messageText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            sendMessage()
                            messageText = ""
                        }) {
                            Image(systemName: "paperplane.fill").resizable().frame(width: 30, height: 30).padding(4)
                            
                        }.accentColor(.white)
                        Spacer()
                    }
                    .padding()
                }
                .navigationBarTitle("Chat")
                .background(AnimatedBackground())
            }
        }
    }
    
    func sendMessage() {
        viewModel.sendMessage(message: messageText)
    }
}


extension View {
    func chatBubble(isUser: Bool) -> some View {
        self
            .padding(10)
            .background(isUser ? Color.blue : Color.green)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
            .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct AnimatedBackground: View {
    
@State private var animateGradient = false
    
    var body: some View {
        
        LinearGradient(colors: [.blue, .cyan, .purple], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }

    }
}

