class DogsController < ApplicationController
  # GET /
  def index
  end

  # GET /dogs
  def list
    page = (request.query_parameters.key?('page') ? request.query_parameters['page'].to_i : 1)
    offset = (page - 1) * RECORDS_PER_PAGE

    params = {
      'query': request.query_parameters.key?('query') ?
              ('%' + request.query_parameters['query'] + '%') : '%',
      'genre': request.query_parameters.key?('genre') ?
              [ request.query_parameters['genre'] ] : ['male', 'female'],
      'castrated': request.query_parameters.key?('castrated') ?
              [ (request.query_parameters['castrated'] == 'true') ? true : false ] : [true, false],
      'breed': request.query_parameters.key?('breed') ?
              ('%' + request.query_parameters['breed'] + '%') : '%',
    }

    response = {}

    response['items'] = Dog.where(
        '(name LIKE ? OR owner_name LIKE ?) AND genre IN (?) AND castrated IN (?) and breed LIKE ?',
        params[:query], params[:query], params[:genre], params[:castrated],
        params[:breed])
      .order(:name)
      .limit(RECORDS_PER_PAGE)
      .offset(offset)

    response['total'] = Dog.where(
        '(name LIKE ? OR owner_name LIKE ?) AND genre IN (?) AND castrated IN (?) and breed LIKE ?',
        params[:query], params[:query], params[:genre], params[:castrated],
        params[:breed])
      .count

    response['pages'] = response['total'] / RECORDS_PER_PAGE

    if (response['total'] % RECORDS_PER_PAGE) != 0
      response['pages'] += 1
    end

    respond_to do |format|
      format.json { render json: response }
    end
  end

  # GET /dogs/breeds
  def get_breeds
    respond_to do |format|
      format.json { render json: BREEDS }
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
      Faker::Config.locale = 'pt-BR'

      # We store the birth in a variable because we will use it to determine the last visit
      birth = Time.at(rand * (Time.now.to_f))

      data = {
        :breed => BREEDS[rand(414)],
        :genre => (rand(100) % 2 == 1) ? 'male' : 'female',
        :castrated => (rand(100) % 2 == 1) ? true : false,
        :birth => birth.strftime('%d/%m/%Y'),
        :owner_name => Faker::Name.name,
        :owner_phone => Faker::PhoneNumber.phone_number
      }
      data[:name] = (data[:genre] == 'male') ? MALE_DOGS[rand(100)] : FEMALE_DOGS[rand(100)]

      # The dogs live on average 10 years, so we can't let the last visit be bigger than
      # this nor greater than today
      maxDate = birth + 10.years

      if maxDate >= Time.now
        maxDate = Time.now
      end

      # The last visit will be between birth and max date
      data[:last_visit] = Time.at(birth + rand * (maxDate.to_f - birth.to_f)).strftime('%d/%m/%Y')

      dog = Dog.new(data)

      dog.save
    end
end
