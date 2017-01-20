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
  def create
    @first = First.generate_new_instance(params)
    puts @first.attributes
  end

  def test
    
  end

  private

  def first_params
    params.require(:first).permit(First.new.attributes.keys.map {|k| k.to_sym})
  end
end
