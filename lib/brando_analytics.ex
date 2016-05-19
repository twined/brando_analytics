defmodule Brando.Analytics do
  @moduledoc """
  Brando's interface to Google Analytics' API.

  To use, first add as a worker to your application's
  supervision tree in `lib/my_app.ex`:

      worker(Brando.Analytics, []),

  ## Configuration options

  Configuration is done through `config :eightyfour, `:

    * `credentials`: "priv/tokens/google/token.json"
    * `private_key`: "priv/tokens/google/token.key.pem"
    * `google_view_id`: "XXXXXX"
       find your view id from your analytics url:
       https://www.google.com/analytics/web/#management/Settings/a000w000pVIEW_ID/
    * `start_date`: "2010-01-01"
    * `token_lifetime`: 3600
    * `token_provider`: Eightyfour.AccessToken
  """

  @doc false
  def start_link do
    import Supervisor.Spec, warn: false

    children = [
      worker(Eightyfour, [])
    ]

    opts = [strategy: :one_for_one, name: Brando.Analytics.Supervisor]
    {:ok, _pid} =  Supervisor.start_link(children, opts)
  end
end
