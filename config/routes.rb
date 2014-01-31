BanjoChallenge::Application.routes.draw do
  root to: "root#root"
  get "photos" => 'photos#index'


 
end
