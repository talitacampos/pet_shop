Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'dog#index'

  get 'dogs' => 'dog#list', defaults: {format: :json}

end
