defmodule UsersBackend.Users.Supervisor do
  use Supervisor

  alias UsersBackend.Users

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init(
      [
        Users.Projectors.User
      ],
      strategy: :one_for_one
    )
  end
end
