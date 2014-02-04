BanjoChallenge::Application.routes.draw do
  root to: "root#root"
  resources :photo_sets, :only => [:create] do
    resources :photos, :only => [:index]
  end
end
