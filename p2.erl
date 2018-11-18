%% 11/17/18
%% Lakhan Kamireddy

-module(p2).

-export([start/0, align/0, curleader/2, recvldr/2, wait/1, follow/0, cooperate/0, ident/1]).

wait(Y) -> %% wait process terminates when merge is done
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

curleader(0, Recvldr_PID) -> %% current leader
	receive
		get_ldr -> %% return current leader
			curleader(0, Recvldr_PID);
		{set_ldr, 33} -> %% set current leader
			Recvldr_PID ! {self(), 33},
			io:format("Calling from current leader~n", [])
	end.
	
recvldr(0, Curleader_PID) -> %% receives leader information
	receive
		{curleader, 33} ->
			io:format("Received leader number on Y~n", []),
			io:format("Set ldr info~n")
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
	Curleader_PID = spawn(p2, curleader, []),
	Curleader_PID ! {set_ldr, 33},
	Recvldr_PID = spawn(p2, recvldr, [0, Curleader_PID]),
	Recvldr_PID ! {curleader, 33},
	Ident_PID = spawn(p2, ident, [1]),
	Ident_PID ! get_id,
	%% spawns two processes that execute concurrently like follow || cooperate in pi-calc
	Follow_PID = spawn(p2, follow, []),
	Follow_PID ! keep_dist,
	Cooperate_PID = spawn(p2, cooperate, []).