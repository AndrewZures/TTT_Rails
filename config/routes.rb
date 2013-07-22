TTT::Application.routes.draw do

    root to: "game#new_game", as: :new_game
    post "game" => "game#update", as: :update_game
    
end

