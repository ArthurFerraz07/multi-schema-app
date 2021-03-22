class ApplicationController < ActionController::Base
  def bla
    # binding.pry
    # sleep(6)
    # Thread.new do
      puts '-' * 100
      puts params[:schema]
      Car.change_schema(params[:schema])
      puts Car.all
      sleep(5)
      puts Car.all
    # end
    render json: Car.all.to_json
  end
end
