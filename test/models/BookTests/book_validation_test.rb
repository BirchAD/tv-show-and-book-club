require "test_helper"


class BookTest < ActiveSupport::TestCase
  def setup
    @books = FactoryBot.create_list(:book, 3)
  end

  test 'book should be valid' do
    @books.each do |book|
      assert book.valid?
    end
  end

  test 'book should have a title, author, description, genre, published date and image' do
    @books.each do |book|
      assert book.title.present?, 'book should have a title'
      assert book.author.present?, 'book should have an author'
      assert book.isbn.present?, 'book should have an ISBN'
      assert book.published.present?, 'book should have a published date'
      assert book.description.present?, 'book should have a description'
      assert book.genre.present?, 'book should have a genre'
      assert book.image.present?, 'book should have an image'
    end
  end

  test 'book should be invalid with invalid attributes' do
    invalid_book_attributes = { title: nil, author: nil, description: nil, genre: nil, published: nil, image: nil, isbn: nil }
    book = FactoryBot.build(:book, invalid_book_attributes)
    assert_not book.valid?, 'book should be invalid with invalid attributes'
    assert_not_empty book.errors[:title], 'should have an error on title'
    assert_not_empty book.errors[:author], 'should have an error on author'
    assert_not_empty book.errors[:description], 'should have an error on descrption'
    assert_not_empty book.errors[:genre], 'should have an error on genre'
    assert_not_empty book.errors[:published], 'should have an error on published'
    assert_not_empty book.errors[:image], 'should have an error on image'
    assert_not_empty book.errors[:isbn], 'should have an error on isbn'
  end

  test 'book should have a published date in the past' do
    book = FactoryBot.build(:book, published: Date.tomorrow)
    assert_not book.valid?, 'book should be invalid with a future published date'
    assert_not_empty book.errors[:published], 'should have an error on published'
  end

  test 'isbn should be unique' do
    book = FactoryBot.build(:book, isbn: '9780547952017')
    book_two = FactoryBot.build(:book, isbn: '9780547952017')
    book.save
    assert_not book_two.valid?, 'should be invalid with non unique isbn'
  end

  test 'isbn should match format of isbn 10 or 13 based on faker' do
    @books.each do |book|
      assert_match(/\A(97(8|9))?\d{9}-?[\dX]?\z/, book.isbn)
    end
  end

  test 'isbn should match format of google api formats' do
    @books.each do |book|
      book.isbn = '9780547952017'
      assert_match(/\A(97(8|9))?\d{9}-?[\dX]?\z/, book.isbn)
      book.isbn = '0547952015'
      assert_match(/\A(97(8|9))?\d{9}-?[\dX]?\z/, book.isbn)
    end
  end

  test 'isbn should not be valid if incorrect format' do
    book = FactoryBot.build(:book, isbn: "n0rn3nn20n30nfnusnu")
    assert_not book.valid?, 'should be invalid with incorrect format'
    assert_not_empty book.errors[:isbn], 'should have an error message on isbn'
    assert_match(/is invalid/, book.errors[:isbn].join, "error message should contain 'is invalid'")
  end
end
