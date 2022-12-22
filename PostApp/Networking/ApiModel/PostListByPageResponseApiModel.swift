struct PostListByPageResponseApiModel: Codable {
    let data: [PostApiModel]
    let total, page, limit: Int
}
