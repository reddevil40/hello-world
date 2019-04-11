
create view vwRand
as
	select floor(rand()*10 +1) as Random;
go
declare @String varchar(64) = 'RickyD.DavisLovesWorkingDon''t youThink'

select dbo.MakeItNew(@String)
go

create or alter function dbo.MakeItNew(@old varchar(4000))
returns varchar(4000)
as
begin

 declare @new varchar(4000)
 -- lets reverse it
 set @new = reverse(rtrim(@old))
 declare @rot varchar(4000) = ''


 declare @RotationNumber tinyint 

 set @RotationNumber = (Select * from dbo.vwRand);
 
-- nibbler algorithm
declare @strLen smallint
declare @ascii smallint

set @strLen = len(@new)
declare @i smallint =1
while @i <= @strLen
begin
set @ascii = ascii(SUBSTRING(@new,@i,1))
if @ascii + @RotationNumber > 126 
	begin
	  set @ascii = 33 + @RotationNumber -(126 - @ascii) -1
	 
	end
	else
	begin
	 set @ascii = @ascii + @RotationNumber
	end
   
set @rot = @rot + char(@ascii)
set @RotationNumber = (Select * from vwRand);

set @i = @i + 1
end

return @rot
end
