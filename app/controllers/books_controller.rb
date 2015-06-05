require 'json'

class BooksController < ApplicationController

#  load_and_authorize_resource
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @search = Book.search(params[:q])
    @books = @search.result
  end

  def show
  end

  def new
    @book = Book.new
  end

  def get_info(isbn=nil)
    if isbn.nil?
      isbn = params[:isbn]
    end
    Amazon::Ecs.debug = true
    res = Amazon::Ecs.item_search(isbn,
         :search_index   => 'Books',
         :response_group => 'Medium',
         :country        => 'jp'
       )
    if res.nil?
      info = nil
    else
      print isbn
      info = {'Title' => res.first_item.get('ItemAttributes/Title'),
            'Author' => res.first_item.get('ItemAttributes/Author'),
            'Manufacturer' => res.first_item.get('ItemAttributes/Manufacturer'),
            'Publication_Date' => res.first_item.get('ItemAttributes/PublicationDate'),
            'S_Image' => res.first_item.get('MediumImage/URL'),
            'L_Image' => res.first_item.get('LargeImage/URL')
              }
    end
    render json: info
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      @book_info = BookRentalInfo.create(rental_count: 0, Book_id: @book.id)
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to books_path
    else
      render 'edit'
    end
  end

  def destroy
    if @book.Rental_id.nil?
      @book.destroy
      redirect_to books_path
    else
      redirect_to books_path, notice: "その本は貸出中のため削除できません。"
    end
  end

  private
    def book_params
        params[:book].permit(:title, :author, :manufacturer, :publication_date, :isbn, :code)
    end

    def set_book
      @book = Book.find(params[:id])
    end

end
