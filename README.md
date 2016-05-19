# Brando Analytics

## Installation

Add brando_analytics to your list of dependencies in `mix.exs`:

```diff
    def deps do
      [
        {:brando, github: "twined/brando"},
+       {:brando_analytics, github: "twined/brando_analytics"}
      ]
    end
```

Add to your `web/router.ex`:

```diff

    defmodule MyApp.Router do
      use MyApp.Web, :router
      # ...
+     import Brando.Analytics.Routes.Admin

      scope "/admin", as: :admin do
        pipe_through :admin
        dashboard_routes   "/"
        user_routes        "/users"
+       analytics_routes   "/analytics"
      end
    end
```

Add to your `lib/my_app.ex`:

```diff
    def start(_type, _args) do
      import Supervisor.Spec, warn: false

      children = [
        # Start the endpoint when the application starts
        supervisor(MyApp.Endpoint, []),
        # Start the Ecto repository
        supervisor(MyApp.Repo, []),
+       # Start the Analytics supervisor
+       worker(Brando.Analytics, []),
        # Here you could define other workers and supervisors as children
        # worker(MyApp.Worker, [arg1, arg2, arg3]),
      ]

+     Brando.Registry.register(Brando.Analytics)
```

Install the scss file:

    $ mix brando_analytics.install

Add to your `web/static/css/custom/brando.custom.scss`

```diff
+ @import
+   "includes/analytics"
```

## Token files

`Brando.Analytics` is just a wrapper around `Eightyfour`.

Create a Google service account:

* Go to https://console.developers.google.com/
* `APIs & auth` -> `Credentials`
* `Add credentials` -> `Service account`
* We need both key types, so start with `JSON`
* Save as `token.json`
* Click the email address under `Service accounts`.
* `Generate new P12 key`
* Save as `token.p12`
* Move tokens to `priv/tokens/google` under your otp_app.
* `openssl pkcs12 -in token.p12 -out token.crt.pem -clcerts -nokeys`
* `openssl pkcs12 -in token.p12 -out token.key.pem -nocerts -nodes`

Find your google service account's email:

* Go to https://console.developers.google.com/
* `APIs & auth` -> `Credentials`
* Copy `Email address` field

Add your google service account's email to the Analytics account you want to track. Make sure that its only permissions are `Read & analyze`.


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
