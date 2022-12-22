protocol PostRepository {
    func getPosts(byPage page:Int, completion: @escaping (Result<[PostApiModel], Error>) -> Void)
}
