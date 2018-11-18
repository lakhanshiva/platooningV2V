%% 11/17/18
%% Lakhan Kamireddy

-module(p2).

-export([start/0, follow/0, cooperate/0, ident/1]).

follow() -> %% This is the follow process function
	receive
		keep_dist ->
			io:format("Maintaining a safe distance 'd' while following the current leader~n", [])
	end.

cooperate() -> %% This is the cooperate process function
	receive
		coop ->
			io:format("Cooperate~n", [])
	end.

ident(Y) -> %% This is the vehicle identification process function
	receive
		get_id ->
			io:format("Returned vehicle identification~n", []) %% returns the identification of the vehicle.
	end.
	

start() -> %% program execution begins here
    %% spawns two processes that execute concurrently like follow || cooperate in pi-calc
	Ident_PID = spawn(p2, ident, [1]),
	Ident_PID ! get_id,
	Follow_PID = spawn(p2, follow, []),
	Follow_PID ! keep_dist,
	Cooperate_PID = spawn(p2, cooperate, []).