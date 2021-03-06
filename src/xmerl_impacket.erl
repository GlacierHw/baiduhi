%%%-------------------------------------------------------------------
%%% @author Feather.et.ELF <fledna@qq.com>
%%% @copyright (C) 2012, Feather.et.ELF
%%% @doc
%%%
%%% @end
%%% Created : 15 Jul 2012 by Feather.et.ELF <fledna@qq.com>
%%%-------------------------------------------------------------------
-module(xmerl_impacket).

%% API
-export([xml_to_tuple/1]).
%% xmerl callbacks
-export(['#xml-inheritance#'/0,
         '#root#'/4,
         '#element#'/5,
         '#text#'/1]).
-include_lib("xmerl/include/xmerl.hrl").

%%%===================================================================
%%% API
%%%===================================================================
xml_to_tuple(Xml) ->
    {Doc, _} = xmerl_scan:string(Xml),
    xmerl:export([Doc], ?MODULE).
%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
%% callbacks
%% Tag := nil | {Tag, AttrsList, Data}
'#xml-inheritance#'() ->
    [].

'#text#'(_Text) ->
    %% no text tag
    [].

'#root#'(Data, _Attrs, [], _E) ->
    Data.

'#element#'(Tag, Data, Attrs, _Parents, _E) ->
    AttrsList = lists:map(fun(#xmlAttribute{name=Name, value=Val}) -> {Name, Val} end,
                          Attrs),
    {Tag, AttrsList, lists:filter(fun([]) -> false;
                                     (_)  -> true
                                  end,
                                  Data)}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
