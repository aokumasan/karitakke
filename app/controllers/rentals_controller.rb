class RentalsController < ApplicationController

#  load_and_authorize_resource

  def index
    @rentals = current_user.rentals.where(is_returned: false)
  end

  def new
    @book = Book.new
    @rental = Rental.new
  end

  def search_book
    @book = Book.where(code: params[:code]).first
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

  def show
  end

  def create
    @book = Book.find(params[:book].require(:id))
    if @book.book_rental_info.is_rentaled == false
      @rental = current_user.rentals.new(rental_date: DateTime.now, user_name: current_user.name)
      @rental.book_id = @book.id
      if @rental.save
        @bookinfo = @book.book_rental_info
        @bookinfo.is_rentaled = true
        @bookinfo.now_rental_id = current_user.id
        @bookinfo.now_rental_name = current_user.name
        @bookinfo.increment(:rental_count)
        @bookinfo.save
        redirect_to rentals_path
      else
        render 'new'
      end
    else
      redirect_to new_rental_path, notice: "その本はすでに貸出中です。"
    end
  end

  def destroy
  end

  def pre_return
    @book = Book.new
  end

  def post_return
    @book = Book.find(params[:book].require(:id))
    puts @book.title
    if @book.book_rental_info.is_rentaled == true
      @rental = @book.rentals.where(user_id: current_user.id).where(is_returned: false).first
      @book.book_rental_info.is_rentaled = false
      @rental.return_date = DateTime.now
      @rental.is_returned = true
      if @rental.save
        @bookinfo = @book.book_rental_info
        @bookinfo.last_rental_id = current_user.id
        @bookinfo.last_rental_name = current_user.name
        @bookinfo.now_rental_id = nil
        @bookinfo.now_rental_name = nil
        @bookinfo.save
        redirect_to rentals_path
      else
        render 'pre_return'
      end
    else
      redirect_to "/rentals/return", notice: "その本はすでに返却済みです。"
    end
  end


end
