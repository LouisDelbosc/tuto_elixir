defmodule MiniBlog do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: MiniBlog.Worker.start_link(arg1, arg2, arg3)
      # worker(MiniBlog.Worker, [arg1, arg2, arg3]),
      worker(__MODULE__, [], function: :run)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MiniBlog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    routes = [
      {"/", MiniBlog.Handler, []},
      {"/:filename", MiniBlog.Handler, []},
      {"/static/[...]", :cowboy_static, {:priv_dir, :mini_blog, "static_files"}}
    ]

    dispatch = :cowboy_router.compile([{:_, routes}])

    opts = [port: 8000]
    env = [dispatch: dispatch]

    {:ok, _pid} = :cowboy.start_http(:http, 100, opts, [env: env])
  end

end
