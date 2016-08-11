-module(stock).
-export([lookup/1]).

lookup(Symbol) ->
    URL = "http://www.google.com/finance/info?q=NSE:" ++ Symbol,
    {ok, {_, _, Body}} = httpc:request(URL),
    Body2 = strip_google_prefix(Body),
    case wf:json_decode(Body2) of
        undefined -> undefined;
        [Quote|_] -> proplists:get_value(<<"l">>, Quote)
    end.

strip_google_prefix("\n//" ++ Body) -> Body;
strip_google_prefix(Body) -> Body.
