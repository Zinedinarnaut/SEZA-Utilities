import SwiftUI

struct ContentView: View {
    @State private var isLoading = true // Control state for splash screen
    @State private var selectedTab = 0 // State to track selected tab

    var body: some View {
        ZStack {
            if isLoading {
                // Splash Screen
                SplashScreen(isLoading: $isLoading)
            } else {
                // Main TabView
                TabView(selection: $selectedTab) {
                    // Home Tab
                    NavigationView {
                        VStack {
                            // News/Blogs Section
                            NewsBlogsView() // New view for news/blogs

                            Divider() // Divider between news/blogs and grid

                            // 2x2 Grid of buttons
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 5) {
                                NavigationLink(destination: TunerView()) {
                                    ColorBlockView(label: "Tuner", colors: [.yellow, .yellow.opacity(0.7)], icon: "tuningfork")
                                }
                                NavigationLink(destination: ChordsView()) {
                                    ColorBlockView(label: "Chords", colors: [.green, .green.opacity(0.7)], icon: "music.note.list")
                                }
                                NavigationLink(destination: MetronomeView()) {
                                    ColorBlockView(label: "Metronome", colors: [.blue, .blue.opacity(0.7)], icon: "metronome")
                                }
                                NavigationLink(destination: JournalView()) {
                                    ColorBlockView(label: "Journal", colors: [.red, .red.opacity(0.7)], icon: "book")
                                }
                            }
                            .padding()
                        }
                        .navigationTitle("Home")
                    }
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)

                    // Settings Tab (Dummy Views for demonstration)
                    VStack {
                        Text("Settings View")
                            .font(.title)
                            .padding()
                        Spacer()
                    }
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    .tag(1)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

// News/Blogs Section View remains the same
struct NewsBlogsView: View {
    var body: some View {
        VStack {
            // Replace with actual content or links
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(0..<2) { index in // Example content, replace with actual news/blog items
                        NewsBlogItemView(index: index)
                    }
                }
                .padding()
            }
            .frame(height: 200) // Adjust height as needed
            .cornerRadius(10)
            .padding()
        }
    }
}

// News/Blog Item View remains the same
struct NewsBlogItemView: View {
    let index: Int // Example index for demo
    
    var body: some View {
        VStack {
            Text("Tutorial \(index + 1)")
                .font(.headline)
                .padding(.bottom, 5)
            Text("Description of the news or blog item goes here. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 300, height: 180) // Adjust size as needed
        .background(Color.white)
        .cornerRadius(5)
    }
}

// Splash Screen View remains the same
struct SplashScreen: View {
    @Binding var isLoading: Bool

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Background color

            VStack {
                Spacer()

                // Logo and App Name
                Image(systemName: "guitars.fill") // Replace with your logo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Text("SEZA Utilities")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                // Sections with logos, descriptions
                VStack(spacing: 30) { // Increased spacing for better separation
                    SectionView(icon: "tuningfork", title: "Tuner", description: "Tune your guitar to perfect pitch using the built-in tuner.")
                    SectionView(icon: "music.note.list", title: "Chords", description: "Explore and practice a variety of guitar chords.")
                    SectionView(icon: "metronome", title: "Metronome", description: "Keep time with the adjustable metronome.")
                    SectionView(icon: "book", title: "Journal", description: "Record your practice sessions and progress.")
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)

                Spacer()

                // Continue Button
                Button(action: {
                    withAnimation {
                        isLoading = false // Transition to main content view
                    }
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

// Section View remains the same
struct SectionView: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(description)
                    .font(.body)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer() // Ensures the section content stays aligned to the left
        }
        .padding(.vertical, 10) // Adds vertical padding for better spacing between sections
    }
}

// Other Views (ChordsView, MetronomeView, TunerView, JournalView) remain the same
struct ChordsView: View {
    var body: some View {
        Text("Chords View")
            .font(.title)
            .padding()
    }
}

struct MetronomeView: View {
    var body: some View {
        Text("Metronome View")
            .font(.title)
            .padding()
    }
}

struct TunerView: View {
    var body: some View {
        Text("Tuner View")
            .font(.title)
            .padding()
    }
}

// ColorBlockView updated with icon parameter
struct ColorBlockView: View {
    let label: String
    let colors: [Color]
    let icon: String // Icon parameter for the tool

    @State private var isHovered = false

    var body: some View {
        ZStack {
            if isHovered {
                LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
                    .mask(
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 150, height: 150)
                            .scaleEffect(1.1) // Scale effect on hover
                            .animation(.easeInOut(duration: 0.3)) // Animation on scale change
                    )
                    .transition(.opacity) // Apply a transition for opacity change
            } else {
                LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
                    .mask(
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 150, height: 150)
                            .scaleEffect(1.0) // Default scale
                            .animation(.easeInOut(duration: 0.3)) // Animation on scale change
                    )
                    .transition(.opacity) // Apply a transition for opacity change
            }

            VStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                
                Text(label)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 150, height: 150)
        .padding()
        .cornerRadius(15)
        .shadow(radius: 5)
        .onHover { hovering in
            withAnimation {
                self.isHovered = hovering
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
