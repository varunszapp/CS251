BEGIN{
comments=0;
strings=0;
olc="\/\/";
str="\"";
mlcs="^\/\*";
mlcstop="\*\/$";
flag=0;
}


{
	if (match($0,olc))
		{
		comments++;
		}
	else if (flag==1)
		{
		comments++;
		if(match($0,mlcstop))
		flag=0;
		}
	else if (match($0,mlcs))
		{
			if(match($0,mlcstop)!=0)
			{
				comments++;	}
			else
			{
				flag=1;
				comments++;	
						}
		}
	else if(match($0,str))
		{ 
		 cs=0;
		 ret=match($0,str);
		 while(ret!=0)
		 {	cs++;
			$0=substr($0,ret+1);
			 ret=match($0,str);
		 }
		strings=strings+cs/2;
		}		
}
END{
print comments;
print strings;
}

