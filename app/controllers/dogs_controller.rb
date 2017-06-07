class DogsController < ApplicationController
  # GET /
  def index
  end

  # GET /dogs
  def list
    @dogs = Dog.all

    respond_to do |format|
      format.json { render json: @dogs }
    end
  end

  # GET /populate/dogs
  def populate
    Dog.delete_all

    (1..NUMBER_DOGS).each do |i|
      generate_dog_data()
    end

    respond_to do |format|
      format.json { render json: Dog.all }
    end
  end

  private
    def generate_dog_data
      # We store the birth in a variable because we will use it to determine the last visit
      @birth = Time.at(rand * (Time.now.to_f))

      @data = {
        :name => Faker::Cat.name,
        :breed => BREEDS[rand(414)],
        :genre => (rand(100) % 2 == 1) ? 'male' : 'female',
        :castrated => (rand(100) % 2 == 1) ? true : false,
        :birth => @birth.strftime('%d/%m/%Y'),
        :owner_name => Faker::Name.name,
        :owner_phone => Faker::PhoneNumber.cell_phone,
        :last_visit => Time.at(@birth + rand * (Time.now.to_f - @birth.to_f)).strftime('%d/%m/%Y')
      }
      puts @data

      @dog = Dog.new(@data)

      @dog.save
    end
end
