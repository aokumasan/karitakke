class RentalsController < ApplicationController

#  load_and_authorize_resource

  def index
    @rentals = current_user.rentals.all
  end

  def new
    @book = Book.new
    @rental = Rental.new
  end

  def search_book
    @book = Book.where(book_code: params[:book_code]).first
    if @book.nil?
      info = nil
    else
      info = {'Title' => @book.title,
              'Author' => @book.author,
              'Manufacturer' => @book.manufacturer,
              'Id' => @book.id
            }
    end
    render json: info
  end

  def create
    @book = Book.find(params[:book].require(:id))
    if @book.Rental_id.nil?
      @log = Log.create(user_id: current_user.id, username: current_user.name, book_id: @book.id, rental_date: DateTime.now)
      @rental = Rental.new(rental_date: DateTime.now)
      @rental.User = current_user
      @rental.Book = @book
      @rental.Log = @log
      if @rental.save
        @book.increment(:rental_count)
        @book.Rental_id = @rental.id
        @book.save
        redirect_to rentals_path
      else
        render 'new'
      end
    else
      redirect_to new_rental_path, notice: "その本はすでに貸出中です。"
    end
  end

  def destroy
    @rental = current_user.Rentals.find(params[:id])
    @rental.Book.update(Rental_id: nil)
    @rental.Log.update(return_date: DateTime.now)
    @rental.destroy
    redirect_to rentals_path
  end

end
