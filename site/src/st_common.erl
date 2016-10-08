-module(st_common).
-include_lib("nitrogen_core/include/wf.hrl").
-export([menu/0]).

%% #bind{} method
menu() ->
    Items = [
        {"Home", "/"},
        {"Saved", "/saved"}
    ],
    Map = {menu_link@text, menu_link@url},
    #list{class=[nav,'navbar-nav'],body=[
        #bind{data=Items, map=Map, body=[
            #listitem{body=[
                #link{id=menu_link}
            ]}
        ]}
    ]}.

%% lists:map method
%menu() ->
%    Items = [
%        {"Home", "/"},
%        {"Saved", "/saved"}
%    ],
%    #list{class=[nav,'navbar-nav'],body=[
%        lists:map(fun({Label, Url}) ->
%            #listitem{body=[
%                #link{text=Label, url=Url}
%            ]}
%        end, Items)
%    ]}.

%% List comprehension method
%menu() ->
%    Items = [
%        {"Home", "/"},
%        {"Saved", "/saved"}
%    ],
%    #list{class=[nav,'navbar-nav'],body=[
%        [draw_item(Item) || Item <- Items]
%    ]}.
%
%draw_item({Label, Url}) ->
%    #listitem{body=[
%        #link{text=Label, url=Url}
%    ]}.
