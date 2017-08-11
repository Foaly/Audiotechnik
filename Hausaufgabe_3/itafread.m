function [SampleZahl,SamplingRate,Offset,...
          Kanalanzahl,Kanalliste,KanalNr,...
          VoltageRange,Reserviert,...
          XachsSchriftLen,XachsSchrift,...
          YachsSchriftLen,YachsSchrift,...
          Rand,Cursor,LaufzeitKor,OberkantdB,...
          Dynamik,NulldBVolt,LeftCursor,...
          RightCursor,AddaIdentLen,AddaIdent,...
          KommentarLen,Kommentar,f] = itafread(Name) 

% if (Name == ''),
% 	Name	= input('Welche Datei einlesen?:','s'); % Dateiname abfragen	
% end;


if  strcmp(computer,'SOL2')

	[fid, message]		= fopen (Name,'r','l');		 % Oeffnen Datei

else
	[fid, message]		= fopen (Name,'r');		 % Oeffnen Datei

end;

if (fid == -1),						 % Falls Datei nicht geoeffnet werden
   message,						 % konnte -> Fehlermeldung
   error,

else							 % sonst...
   SampleZahl		= fread (fid,1,'long');			% Einlesen Header
   SamplingRate		= fread (fid,1,'double');
   Offset		= fread (fid,1,'ushort');
   Kanalanzahl		= fread (fid,1,'schar');
   Kanalliste		= fread (fid,15,'schar');
   KanalNr		= fread (fid,1,'schar');
   VoltageRange		= fread (fid,1,'double');
   Reserviert		= fread (fid,64,'schar');
   XachsSchriftLen	= fread (fid,1,'char');
   XachsSchrift		= setstr(fread (fid,3,'char'));
   YachsSchriftLen	= fread (fid,1,'char');
   YachsSchrift		= setstr(fread (fid,3,'char'));
   Rand			= fread (fid,2,'long');
   Cursor		= fread	(fid,2,'long');
   LaufzeitKor		= fread (fid,1,'double');
   OberkantdB		= fread (fid,1,'double');
   Dynamik		= fread (fid,1,'double');
   NulldBVolt		= fread (fid,1,'double');
   LeftCursor		= fread (fid,1,'ushort');
   RightCursor		= fread (fid,1,'ushort');
   AddaIdentLen		= fread (fid,1,'char');
   AddaIdent		= setstr(fread (fid,20,'char'));
   KommentarLen		= fread (fid,1,'char');
   Kommentar		= setstr(fread (fid,71,'char'));
   status		= fseek (fid,256,'bof');         % zum Feld mit Spektralwerten spulen
   if Kanalanzahl == 0 
      Kanalanzahl = 1;
   end

   
   f			= ones(Kanalanzahl,SampleZahl);  % Feld definieren
 

 for l = 1:Kanalanzahl					 % aussere Schleife : Kanaele !
   for k = 1:SampleZahl					 % 1. innere Schleife  : Realteil
        f(l,k)		= fread(fid,1,'float');		 % einlesen Realteil
   end							 % Ende 1. innere Schleife

   for k = 1:SampleZahl					 % 2. innere Schleife : Imaginaerteil
      f(l,k) 	= f(l,k) + j*fread(fid,1,'float');	 % Imag.teil + Realteil ! 
   end 							 % Ende 2. innere Schleife

 end							 % Ende aussere Schleife

   status	= fclose(fid);				 % Schliessen der Datei
   
  


end; 							 % Ende von else im if-Zweig

