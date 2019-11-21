%%%-------------------------------------------------------------------
%%% @author sunaijing
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 十一月 2019 16:35
%%%-------------------------------------------------------------------
-module(hibernate_svr).
-author('alking').

-behaviour(gen_server).

%% API
-export([
  start_link/1,
  svr_name/1
]).

%% gen_server callbacks
-export([
  init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3
]).

-record(state, {}).

%%%===================================================================
%%% API
%%%===================================================================

start_link(N) ->
  Name = svr_name(N),
  gen_server:start_link({local, Name}, ?MODULE, [], []).

svr_name(N) ->
  erlang:list_to_atom(lists:concat([?MODULE, "_", N])).
%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
  {ok, #state{}, hibernate}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
