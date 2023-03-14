//
//  AvatarImage.swift
//  GitSearch
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import SwiftUI

struct AvatarImage: View {
    let url: URL?

    var body: some View {
        AsyncImage(
            url: url,
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 80, maxHeight: 80)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}

struct AvatarImage_Previews: PreviewProvider {
    static var previews: some View {
        AvatarImage(
            url: URL(string: "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png")
        )
    }
}
