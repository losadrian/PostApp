struct PostApiModel: Codable {
    let id: String
    let image: String
    let likes: Int
    let tags: [String]
    let text: String
    let publishDate: String
    let owner: OwnerApiModel
}
