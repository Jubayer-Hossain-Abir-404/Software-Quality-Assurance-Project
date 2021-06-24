		 mtype = { req2log, dis_log_pg};
		 chan toU = [2] of {mtype, bit};
		 chan toL = [2] of {mtype, bit};
			
		              proctype User(chan in, out)
		{
		   bit sndbit, recbit	;
		do
		::  out !req2log, sndbit ->
		     in  ?dis_log_pg, recbit;
	
		od
		}
		
		proctype Login(chan in, out)
		{
		   bit recbit	;
		   do
		   ::  in ? req2log(recbit)  ->
		       out  ! dis_log_pg(recbit);
		   od
		}
		
		init
		{
		  run User (toU, toL);
		  run Login (toL, toU);
		}

