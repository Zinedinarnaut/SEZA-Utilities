import SwiftUI

struct NewsBlogItemView: View {
    @Environment(\.colorScheme) var colorScheme
    let index: Int
    
    var body: some View {
        VStack {
            Text("Tutorial \(index + 1)")
                .font(.headline)
                .padding(.bottom, 5)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            Text("Description of the news or blog item goes here. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .white : .secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 300, height: 180)
        .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white)
        .cornerRadius(5)
        .shadow(radius: 2)
    }
}
