defmodule UsersBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [

      UsersBackendWeb.Telemetry,
      UsersBackend.Repo,
      {DNSCluster, query: Application.get_env(:users_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: UsersBackend.PubSub},
      # Start a worker by calling: UsersBackend.Worker.start_link(arg)
      # {UsersBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      UsersBackendWeb.Endpoint,
      UsersBackend.App,
      UsersBackend.Users.Supervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UsersBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UsersBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
