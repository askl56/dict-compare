qwerty_to_dvorak = %{
  ?a => ?a,
  ?b => ?x,
  ?c => ?j,
  ?d => ?e,
  ?f => ?u,
  ?g => ?i,
  ?h => ?d,
  ?i => ?c,
  ?j => ?h,
  ?k => ?t,
  ?l => ?n,
  ?m => ?m,
  ?n => ?b,
  ?o => ?r,
  ?p => ?l,
  ?r => ?p,
  ?s => ?o,
  ?t => ?y,
  ?u => ?g,
  ?v => ?k,
  ?x => ?q,
  ?y => ?f
}

to_dvorak = fn(word) ->
  dv_word = word
    |> String.downcase
    |> String.to_char_list
    |> Enum.map(fn(c) -> Map.get(qwerty_to_dvorak, c, c) end)
    |> to_string
  {word, dv_word}
end

full_dictionary = File.read!("words.txt")
  |> String.split("\n")

index = for w <- full_dictionary, do: {w, :y}, into: %{}

full_dictionary
  |> Stream.filter(fn(word) -> !String.contains?(word, ["e", "E", "q", "Q", "w", "W", "z", "Z"]) end)
  |> Stream.map(to_dvorak)
  |> Stream.filter(&(Map.has_key?(index, elem(&1, 1))))
  |> Stream.each(fn({word, dv_word}) ->
    IO.puts("qwerty: #{word} | dvorak: #{dv_word}")
  end)
  |> Stream.run

System.halt(0)
