module BooksHelper
  def book_last_path(book)
    book_path(book, page: (book.total_pages if book.total_pages > 1), anchor: (book.comments_count if book.comments_count > 0))
  end
end
