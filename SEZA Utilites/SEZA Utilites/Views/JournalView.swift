import SwiftUI

struct JournalEntry: Identifiable {
    let id = UUID()
    var date: Date
    var content: String
}

struct JournalView: View {
    @State private var journalEntries: [JournalEntry] = []
    @State private var isAddingEntry = false
    @State private var selectedEntry: JournalEntry? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                // Header Section
                HStack {
                    Text("Journal")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                    Button(action: {
                        isAddingEntry.toggle()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.trailing)
                }
                .padding(.top)

                Divider()

                // List of Entries
                List {
                    ForEach(journalEntries) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.date, style: .date)
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text(entry.content)
                                .font(.body)
                                .lineLimit(2)
                        }
                        .padding(.vertical, 5)
                        .onTapGesture {
                            selectedEntry = entry
                        }
                    }
                    .onDelete(perform: deleteEntries)
                }
                .listStyle(InsetGroupedListStyle())
                .sheet(item: $selectedEntry) { entry in
                    EditEntryView(entry: $selectedEntry, updateEntry: updateEntry)
                }
            }
            
            .sheet(isPresented: $isAddingEntry) {
                AddEntryView(isAddingEntry: $isAddingEntry, addEntry: addEntry)
            }
        }
    }

    private func addEntry(content: String) {
        guard !content.isEmpty else { return }
        let newEntry = JournalEntry(date: Date(), content: content)
        journalEntries.append(newEntry)
    }

    private func updateEntry(entry: JournalEntry) {
        guard let index = journalEntries.firstIndex(where: { $0.id == entry.id }) else { return }
        journalEntries[index] = entry
    }

    private func deleteEntries(at offsets: IndexSet) {
        journalEntries.remove(atOffsets: offsets)
    }
}

struct EditEntryView: View {
    @Binding var entry: JournalEntry?
    @State private var editedContent: String
    
    var updateEntry: (JournalEntry) -> Void
    
    init(entry: Binding<JournalEntry?>, updateEntry: @escaping (JournalEntry) -> Void) {
        self._entry = entry
        self._editedContent = State(initialValue: entry.wrappedValue?.content ?? "")
        self.updateEntry = updateEntry
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $editedContent)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity) // Full width and height
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()

                Button(action: {
                    if var updatedEntry = entry {
                        updatedEntry.content = editedContent
                        updateEntry(updatedEntry)
                    }
                    entry = nil
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity) // Ensure the view takes up full screen
            .navigationTitle("Edit Entry")
            .navigationBarItems(trailing: Button("Cancel") {
                entry = nil
            })
        }
    }
}

struct AddEntryView: View {
    @Binding var isAddingEntry: Bool
    @State private var newEntryContent: String = ""
    var addEntry: (String) -> Void

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $newEntryContent)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity) // Full width and height
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()

                Button(action: {
                    addEntry(newEntryContent)
                    isAddingEntry = false
                }) {
                    Text("Add Entry")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity) // Ensure the view takes up full screen
            .navigationTitle("New Entry")
            .navigationBarItems(leading: Button("Cancel") {
                isAddingEntry = false
            })
        }
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
