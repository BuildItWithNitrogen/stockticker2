-module(stock).
-export([lookup/1]).

%-define(CMC_API_KEY, "eed3c7d8-bc46-433b-83e5-028c65add01d").
-define(AV_API_KEY, "BVJ2JHQY6MLA0WGZ").


lookup(Symbol) ->
    BaseURL = "https://www.alphavantage.co/query?",
    QS = wf:to_qs([
        {function, "GLOBAL_QUOTE"},
        {symbol, Symbol},
        {apikey, ?AV_API_KEY}
    ]),
    URL = BaseURL ++ QS,

    {ok, {_, _, Body}} = httpc:request(URL),
    Quote = wf:json_decode(Body),
    GlobalQuote = proplists:get_value(<<"Global Quote">>, Quote),
    proplists:get_value(<<"05. price">>, GlobalQuote).
