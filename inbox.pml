mtype {MSG, ACK};

chan toS = [2] of {mtype, bit};
chan toR = [2] of {mtype, bit};

proctype Sender(chan inp, out)
{
	bit sendbit, recvbit;
	do
	:: out ! MSG, sendbit ->
		inp ? ACK, recvbit;
		if
		:: recvbit == sendbit ->
			sendbit = 1-sendbit
		:: else
		fi
	od
}

proctype Receiver(chan inp, out)
{
	bit recvbit;
	do
	:: inp ? MSG(recvbit) ->
		out ! ACK(recvbit);
	od
}

init
{
	run Sender(toS, toR);
	run Receiver(toR, toS);
}