defmodule LeanpokerElixir.Player do
  @version "0.0.10"
  def bet_request(game_state) do
    %{
      "in_action" => in_action,
      "dealer" => dealer,
      "players" => players,
      "current_buy_in" => current_buy_in,
      "minimum_raise" => minimum_raise,
      "community_cards" => community_cards
    } = game_state
    player = Enum.at(players, in_action)
    my_cards = player["hole_cards"]
    cond do
      length(community_cards) == 0 and has_pair?(my_cards) and current_buy_in < 100 -> 100
      has_pair?(my_cards ++ community_cards) -> current_buy_in + minimum_raise
      has_rank?(my_cards, "K") -> 20 
      has_rank?(my_cards, "Q") -> 10
      has_rank?(my_cards, "J") -> 10
      true -> 0
    end
  end
  defp has_rank?(cards, rank) do
    Enum.any?(cards, fn x -> x["rank"] == rank end)
  end
  defp has_pair?(cards) do
    %{"rank" => rank} = hd cards
    has_pair? = Enum.all?(cards, fn(x) -> x["rank"] == rank end)
  end
  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
