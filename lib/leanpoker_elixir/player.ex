defmodule LeanpokerElixir.Player do
  @version "0.0.12"
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
    clojure = find_by_name(players, "AllOfTheParens")
    scala = find_by_name(players, "Enchanting Bear")
    my_cards = player["hole_cards"]
    cond do
      clojure["status"] == "folded" and scala["status"] == "folded" -> current_buy_in + minimum_raise
      length(community_cards) == 0 and has_pair?(my_cards) and current_buy_in < 100 -> 100
      has_pair?(my_cards ++ community_cards) -> current_buy_in + minimum_raise
      has_rank?(my_cards, "K") -> 20 
      has_rank?(my_cards, "Q") -> 10
      has_rank?(my_cards, "J") -> 10
      true -> 0
    end
  end
  defp find_by_name(players, name) do
    Enum.find(players, fn x -> x["name"] == name end)
  end
  defp has_rank?(cards, rank) do
    Enum.any?(cards, fn x -> x["rank"] == rank end)
  end
  def has_pair?(cards) do
      Enum.group_by(cards, fn (x) -> x["rank"] end)
      |> Map.to_list
      |> Enum.any?(fn ({_, x}) -> (length x) > 1 end)
  end
  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
