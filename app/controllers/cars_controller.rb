class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]

  # GET /cars or /cars.json
  def index
    @cars = Car.all
    @cars_num = Car.all.count
    cars_days = 0
    days = 0
    @cars.each do |car|
      if car.out_time == nil
        days = (Date.today - car.entry_time).to_i
      else
        days = (car.out_time - car.entry_time).to_i
      end
      cars_days += days
    end
    @total_days = cars_days
    @total_price = @total_days*2.67
  end

  def select
    if params["query1"].present?
      @first_month_day = Date.parse("#{params["query2"]}-#{params["query1"]}-01")
      case params["query1"]
      when "01","03","05","07","08","10","12"
        @last_month_day = Date.parse("#{params["query2"]}-#{params["query1"]}-31")
      when "02"
        @last_month_day = Date.parse("#{params["query2"]}-#{params["query1"]}-28")
      else
        @last_month_day = Date.parse("#{params["query2"]}-#{params["query1"]}-30")
      end
      @month = params["query1"]
      @year = params["query2"]
      @year_today = Date.today.strftime("%Y")
      @month_today = Date.today.strftime("%m")

    end


    cars0 = Car.where("entry_time <= ?", @last_month_day)
    cars1 = cars0.where("out_time >= ?", @first_month_day)
    cars2 = cars0.where(out_time: nil)
    @cars = cars1 + cars2

    @cars_num = @cars.count
    cars_days = 0
    days = 0
    @cars.each do |car|
      if car.out_time == nil
        days = (Date.today - @first_month_day).to_i
      else
        days = (car.out_time - @first_month_day).to_i
      end
      cars_days += days
    end
    @total_days = cars_days
    @total_price = @total_days * 2.67
  end

  # GET /cars/1 or /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: "Car was successfully created." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: "Car was successfully updated." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: "Car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:name, :entry_time, :out_time)
    end
end
