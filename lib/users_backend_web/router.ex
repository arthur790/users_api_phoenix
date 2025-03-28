defmodule UsersBackendWeb.Router do
  use UsersBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug UsersBackend.GuardianPipeline
  end

  scope "/api", UsersBackendWeb do
    pipe_through :api
    post "/users", UserController, :create
    post "/users/sign_in", UserController, :sign_in
  end

  scope "/api", UsersBackendWeb do
    pipe_through [:api, :auth]
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    get "/info/me/", UserController, :me
    put "/users/register_favorite_color", UserController, :register_favorite_color

  end
end
