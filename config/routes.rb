Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'dogs#index'

  get 'populate/dogs' => 'dogs#populate', defaults: {format: :json}

  get 'dogs' => 'dogs#list', defaults: {format: :json}

end
