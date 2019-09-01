CREATE OR REPLACE function BORA.jde_to_tarih(p_sayi number) return date is
begin
   return LAST_DAY(ADD_MONTHS(trunc(to_date((trunc(p_sayi/1000)+1900-1),'YYYY'),'YYYY'),11)) + (p_sayi - (trunc(p_sayi/1000)*1000) );
end;
/

