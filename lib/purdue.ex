defmodule Pete do
  def spot(course) do
    {term, crn} = course
    url = "https://selfservice.mypurdue.purdue.edu/" <> 
          "prod/bwckschd.p_disp_detail_sched?" <> 
          "term_in=#{term}&crn_in=#{crn}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Regex.run(~r/No detailed class information found/, body) do
          nil -> {:ok, body
                      |> Floki.find("table .datadisplaytable")
                      |> Enum.at(2)
                      |> Floki.find("td .dddefault")
                      |> Enum.map(fn(x) -> {_, _, [v]} = x; v end)
                      |> Enum.at(2)}
          _ -> {:error, "no detailed class information found"}
        end

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, code}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end      
  def haha do
    formvals = [
      term_in: 201530,
      sel_subj: "dummy",
      sel_day: "dummy",
      sel_schd: "dummy",
      sel_insm: "dummy",
      sel_camp: "dummy",
      sel_levl: "dummy",
      sel_sess: "dummy",
      sel_instr: "dummy",
      sel_ptrm: "dummy",
      sel_attr: "dummy",
      sel_subj: "CS",
      sel_crse: 180,
      sel_title: "",
      sel_schd: "%",
      sel_insm: "%",
      sel_from_cred: "",
      sel_to_cred: "",
      sel_camp: "%",
      sel_ptrm: "%",
      sel_instr: "%",
      sel_sess: "%",
      sel_attr: "%",
      begin_hh: 0,
      begin_mi: 0,
      begin_ap: "a",
      end_hh: 0,
      end_mi: 0,
      end_ap: "a"
    ]
    HTTPoison.post "https://selfservice.mypurdue.purdue.edu/prod/bwckschd.p_get_crse_unsec", {:form, formvals}, %{"Referer" => "https://selfservice.mypurdue.purdue.edu/prod/bwckgens.p_proc_term_date"}
  end
end
