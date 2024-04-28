import SwiftUI

// 定義 QuestAns 結構來保存問題和答案
struct QuestAns {
    let question: String
    let answer: String
}

struct FAQView: View {
    @State private var expandedStates: [Bool]

    // 使用 QuestAns 結構來定義問答數據
    let faqs: [QuestAns] = [
        // ... 其他問答
        QuestAns(question: "How can I help stray animals?", answer: "You can help by adopting, volunteering, and donating to animal shelters."),
        QuestAns(question: "What should I do if I find a stray animal?", answer: "Contact local animal services or a rescue organization for guidance."),
        QuestAns(question: "Is it safe to approach a stray animal?", answer: "Be cautious, as stray animals may be scared or aggressive. Call a professional if in doubt."),
        QuestAns(question: "How can I make a stray animal more comfortable?", answer: "Provide food, water, and a safe space if possible, but let the animal approach you."),
        QuestAns(question: "Should I feed stray animals?", answer: "Yes, but make sure to feed them healthy and appropriate food for their species."),
        QuestAns(question: "How can I help stray animals in the winter?", answer: "Provide shelter, warm blankets, and ensure they have access to non-frozen water."),
        QuestAns(question: "What should I do if a stray animal seems sick?", answer: "Contact a veterinarian or a local animal rescue group for help."),
        QuestAns(question: "Can I keep a stray animal that I find?", answer: "First, try to find the owner and check with local laws, as it may be required to report found animals."),
        QuestAns(question: "How can I help reduce the number of stray animals?", answer: "Support spaying and neutering programs to prevent overpopulation."),
        QuestAns(question: "What vaccinations should stray animals receive?", answer: "Stray animals should receive vaccinations for rabies, distemper, and other common diseases."),
        QuestAns(question: "How can I teach my community about caring for stray animals?", answer: "Organize educational events and collaborate with local animal welfare organizations."),
        // ... 更多問答
    ]


    init() {
        // 根據問答數量初始化展開狀態
        _expandedStates = State(initialValue: [Bool](repeating: false, count: faqs.count))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(faqs.indices, id: \.self) { index in
                    Section {
                        DisclosureGroup(
                            isExpanded: $expandedStates[index]
                        ) {
                            Text(faqs[index].answer)
                                .font(.body)
                                .padding(.vertical)
                        } label: {
                            Text(faqs[index].question)
                                .font(.headline)
                                .foregroundStyle(.blue)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("FAQ")
            .padding(.bottom, 5)
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
