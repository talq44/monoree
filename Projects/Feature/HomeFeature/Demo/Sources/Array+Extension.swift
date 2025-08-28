extension Array {
    func chunked(by size: Int) -> [[Element]] {
        guard size > 0 else { return [Array(self)] }
        return stride(from: 0, to: count, by: size).map { start in
            let end = Swift.min(start + size, count)
            return Array(self[start..<end])
        }
    }
}
