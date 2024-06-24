//
//  ChatBuubble.swift
//  Insta
//
//  Created by Phạm Duy Đạt on 09/04/2024.
//

import SwiftUI

struct ChatBuubble: Shape {
    let isFromCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [
                                    .topLeft,
                                    .topRight,
                                    isFromCurrentUser ? .bottomLeft : .bottomRight
                                ]
                                , cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
    
}

#Preview {
    ChatBuubble(isFromCurrentUser: true)
}
