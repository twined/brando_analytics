defmodule Brando.Admin.AnalyticsController do
  @moduledoc """
  A module for analytics.
  """

  use Brando.Web, :controller
  import Brando.Plug.HTML
  import Brando.Analytics.Gettext

  plug :put_section, "analytics"

  @doc """
  Renders the analytics dashboard.
  """
  def views(conn, _params) do
    views_last_week = Eightyfour.Query.page_views(:last_week)
    views_total = Eightyfour.Query.page_views(:total)
    views_yesterday = Eightyfour.Query.page_views(:yesterday)

    conn
    |> assign(:page_title, gettext("Analytics - views"))
    |> assign(:views_total, views_total)
    |> assign(:views_yesterday, views_yesterday)
    |> assign(:views_last_week, views_last_week)
    |> render
  end

  @doc """
  Referrals
  """
  def referrals(conn, _params) do
    referrals_last_month = Eightyfour.Query.referrals(:last_month)
    referrals_total      = Eightyfour.Query.referrals(:forever)

    render conn, :referrals, [
      page_title:           gettext("Analytics - referrals"),
      referrals_total:      referrals_total,
      referrals_last_month: referrals_last_month
    ]
  end
end
