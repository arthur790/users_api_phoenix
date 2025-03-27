defmodule UsersBackendWeb.Router do
  use UsersBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UsersBackendWeb do
    pipe_through :api
    resources "/users", UserController
    post "/users/sign_in", UserController, :sign_in
  end
end
