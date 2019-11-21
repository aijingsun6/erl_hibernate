-module(erl_hibernate_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(SVR_NUM, 10000 * 10).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

-ifdef(hibernate).
svr_mod() -> hibernate_svr.
-else.
svr_mod() -> normal_svr.
-endif.


init([]) ->
  Mod = svr_mod(),
  F =
    fun(X) ->
      Name = Mod:svr_name(X),
      {Name, {Mod, start_link, [X]}, permanent, 5000, worker, [Mod]} end,
  L = lists:map(F, lists:seq(1, ?SVR_NUM)),
  {ok, {{one_for_one, 5, 10}, L}}.


