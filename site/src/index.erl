%% -*- mode: nitrogen -*-
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() ->
    #template { file="site/templates/bare.html" }.

title() -> "Home".

body_left() ->
    [
        #label{text="Stock Symbol"},
        #textbox{id=symbol, class='form-control'},
        #br{},
        #button{
            text="Show Quotes",
            postback=get_quotes,
            class=[btn,'btn-success']
        }
    ].

body_right() ->
    #panel{id=quotes}.

event(get_quotes) ->
    Symbol = wf:q(symbol),
    wf:comet(fun() ->
        get_and_insert_quote(Symbol)
    end).

get_and_insert_quote(Symbol) ->
    Quote = stock:lookup(Symbol),
    QuoteTime = qdate:to_string("g:ia"),
    Body = #panel{text=[
        Symbol,
        " (",QuoteTime,"): ",
        Quote
    ]},
    wf:insert_top(quotes, Body),
    wf:flush(),
    timer:sleep(5000),
    get_and_insert_quote(Symbol).
