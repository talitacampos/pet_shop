class DogController < ApplicationController

  def index
  end

  def list
    @dogs = Array.new

    (1..1000).each do |i|
      @dogs.push(generate_dog_data())
    end

    @dogs = @dogs.sort_by { |d| d['name'] }

    respond_to do |format|
      format.html
      format.json { render json: @dogs }
    end
  end

  private
  def generate_dog_data
    # We store the birth in a variable because we will use it to determine the last visit
    birth = Time.at(rand * (Time.now.to_f))

    data = {
      'name' => Faker::Cat.name,
      'breed' => BREEDS[rand(414)],
      'genre' => (rand(100) % 2 == 1) ? 'male' : 'female',
      'castrated' => (rand(100) % 2 == 1) ? true : false,
      'birth' => birth.strftime('%d/%m/%Y'),
      'owner_name' => Faker::Name.name,
      'owner_phone' => Faker::PhoneNumber.cell_phone,
      'last_visit' => Time.at(birth + rand * (Time.now.to_f - birth.to_f)).strftime('%d/%m/%Y')
    }
  end

end
