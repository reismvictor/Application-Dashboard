//
//  WorkflowCard.swift
//  Xtracta Dashboard3
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

struct WorkflowCard: View {
    var workflow: WorkflowModel
    
    var body: some View {
        // Wrap the entire VStack in a NavigationLink to make the entire card clickable
        NavigationLink(destination: WorkflowDetailView(documents: workflow.documents)) {
            VStack(alignment: .leading) {
                // Workflow title
                Text(workflow.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding([.top, .horizontal])
                
                // Circle Progress Indicators for Indexing, Rejected, and QA
                HStack(spacing: 20) {
                    progressCircle(title: "Indexing", count: workflow.indexingCount, color: .cyan)
                    progressCircle(title: "Rejected", count: workflow.rejectedCount, color: .indigo)
                    progressCircle(title: "QA", count: workflow.qaCount, color: .pink)
                }
                .padding([.horizontal, .bottom])
                .padding(.top, 10)
                
            }
            .padding([.top, .bottom], 15)
            .frame(maxWidth: .infinity)
            .background(
                Color.blue.opacity(0.8) // Set a single background color for the card
                    .cornerRadius(20)
                    .shadow(radius: 10)
            )
            .padding(.horizontal)
            .transition(.slide) // Optional: Adding animation on transition for smooth effect
        }
        .buttonStyle(PlainButtonStyle()) // Ensure the NavigationLink looks like a card and not a button
    }
    
    private func progressCircle(title: String, count: Int, color: Color) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
                .padding(.bottom, 5)
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(color.opacity(0.3)) // Light background color for the circle
                
                Circle()
                    .trim(from: 0, to: CGFloat(count) / 100) // Assuming 100 is the max count
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(color) // Circle color based on the status
                    .rotationEffect(.degrees(-90)) // Start at top
                    .animation(.easeInOut(duration: 0.5), value: count) // Smooth animation on count change
                Text("\(count)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }
            .frame(width: 70, height: 70)
            .padding()
            .background(Color.white.opacity(0.2)) // Background behind the circle
            .cornerRadius(35)
            .shadow(radius: 5)
        }
        .frame(maxWidth: .infinity)
    }
}

struct WorkflowCard_Previews: PreviewProvider {
    static var previews: some View {
        WorkflowCard(workflow: WorkflowModel(name: "Workflow 1", indexingCount: 65, rejectedCount: 20, qaCount: 40, documents: []))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)) // Background for preview
    }
}
