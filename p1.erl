-module(p1).

-export([start/0, leader/0]).

leader() ->
	receive
		finished ->
			io:format("Leader finished~n", []);
		{drive, Drive_PID} ->
			io:format("Leader received the command to drive forward~n", []),
			Drive_PID ! leader,
			leader()
	end.

start() ->
	Leader_PID = spawn(p1, leader, []),
	spawn(p1, drive, [0, Leader_PID]),
	Leader_PID ! {drive, 1}.