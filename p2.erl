%% 11/17/18
%% Lakhan Kamireddy

-module(p2).

-export([start/0, align/0, wait/0, follow/0, cooperate/0, ident/1]).

wait() -> %% wait process terminates when merge is done
	receive
		merge_done ->
			io:format("Merge is done~n", [])
	end.

align() -> %% align process terminates when align is done
	receive
		align_start ->
			io:format("Alignment started~n", []),
			align();
		align_done ->
			io:format("Alignment done~n", [])
	end.

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
	Wait_PID = spawn(p2, wait, []),
	Wait_PID ! merge_done,
	Align_PID = spawn(p2, align, []),
	Align_PID ! align_start,
	Align_PID ! align_done,
	Ident_PID = spawn(p2, ident, [1]),
	Ident_PID ! get_id,
	%% spawns two processes that execute concurrently like follow || cooperate in pi-calc
	Follow_PID = spawn(p2, follow, []),
	Follow_PID ! keep_dist,
	Cooperate_PID = spawn(p2, cooperate, []).