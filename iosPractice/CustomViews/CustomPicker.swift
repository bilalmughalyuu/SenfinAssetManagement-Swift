import SwiftUI

struct CustomPicker: View {
    let title: String
    @Binding var selectedItem: String
    @Binding var itemLists: [String]
    var body: some View {
        
        Menu {
            ForEach(itemLists, id: \.self) { item in
                Button(action: {
                    selectedItem = item
                }) {
                    Text(item)
                        .foregroundColor(.black)
                }
            }
        } label: {
            HStack{
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.caption2)
                        .foregroundColor(Color.black)
                    Text(selectedItem)
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(.black)
                }
                
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
    }
}


#Preview {
    CustomPickerPreviewWrapper()
}

struct CustomPickerPreviewWrapper: View {
    @State private var title: String = "Select Type"
    @State private var selectedItem = "Type A"
    @State private var itemLists = ["Type A", "Type B", "Type C"]
    
    var body: some View {
        CustomPicker(title: title,selectedItem: $selectedItem, itemLists: $itemLists)
    }
}

