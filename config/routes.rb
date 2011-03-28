WebScaffold::Application.routes.draw do
  resources :requests

  root :to => "requests#new"

end
