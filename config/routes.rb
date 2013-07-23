TTT::Application.routes.draw do


    root to: "game#introduction"

    post "new_game" => "game#new_game", as: :new_game
    post "game" => "game#update", as: :update_game
    get "restart_game" => "game#restart_game", as: :restart_game
    get "introduction" => "game#introduction", as: :introduction
    
end

