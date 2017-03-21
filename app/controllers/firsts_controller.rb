class FirstsController < ApplicationController
  def new
    @first = First.new
  end

  def show
    @first = First.find(params[:id])
  end

  def edit
    @first = First.find(params[:id])
  end

  def update
    @first = First.find(params[:id])
    if @first.update_this_instance(params)
      redirect_to "/firsts/#{@first.id}"
    else

    end
  end

  def create
    @first = First.generate_new_instance(params)
    if @first.save
      redirect_to "/firsts/#{@first.id}"
    else

    end
  end

  private
end
