%let access_token = edddd755-a5f1-4065-b637-7c32b98da1e4;
%let algorithm = agti;
%let fill_missing = 0;
run;

filename response  '/home/u63579919/response.txt';
filename headout   '/home/u63579919/headout.txt';
filename minmap    '/home/u63579919/minmap.txt';
filename input1    '/home/u63579919/input_agti.csv';
run;

proc http
	url="https://service-staging.steritas.com/api/v1/&algorithm./multipart/calculateScore"
    method="POST"
	in = MULTI FORM ( "valueMapping" = "{}" ,
	                  "fillMissing" = "&fill_missing." ,
	                  "sync" = "true" ,
	                  "data" = input1 FILENAME="input.csv"
	                    header="Content-Type: text/csv")
	out = response
	headerout = headout;
	headers   "access_token" = "&access_token.";
run;

/* map json paths and load to dataset */
libname results JSON fileref=response map=minmap;

data out;
 set results.scores;
run;

proc print data=out; run;


