defmodule Gather.Analytics.Metrics do
  defstruct [:page_views, :pages, :referrers]

  def create(page_views) do
    total_page_views = length(page_views)

    top_pages =
      page_views
      |> Enum.reduce(%{}, fn page_view, acc ->
        Map.update(acc, page_view.pathname, 0, &(&1 + 1))
      end)

    top_referrers =
      page_views
      |> Enum.reduce(%{}, fn page_view, acc ->
        Map.update(acc, page_view.referrer, 0, &(&1 + 1))
      end)

    %__MODULE__{
      page_views: total_page_views,
      pages: top_pages,
      referrers: top_referrers
    }
  end
end
