create or replace package polskie_znaki as
-- funckja zamienia polskie znaki w tekúcie na '/u.', gdzie kropka oznacza odpowienik polskiego znaku
  function bez_polskich_znakow (p_tekst_do_zmiany varchar2) return varchar2;
-- funckja zamienia '/u./ w tekúcie z powrotem na polskie znaki.
  function wstaw_polskie_znaki (p_tekst_na_polski varchar2) return varchar2;
end polskie_znaki;
/
create or replace package body polskie_znaki as
  function bez_polskich_znakow (p_tekst_do_zmiany varchar2)
  return varchar2 is
    type T_ZNAKI is table of VARCHAR2(10);
    t_pol_znaki T_ZNAKI := T_ZNAKI('π', 'Ê', 'Í', '≥', 'Ò', 'Û', 'ú', 'ü', 'ø', '•', '∆', ' ', '£', '—', '”', 'å', 'è', 'Ø', '');
    t_zamienniki T_ZNAKI := T_ZNAKI('/ua', '/uc' ,'/ue', '/ul', '/un', '/uo', '/us', '/ux', '/uz', '/uA', '/uC' ,'/uE', '/uL', '/uN', '/uO', '/uS', '/uX', '/uZ', '/u');
    v_tekst varchar(1000) := p_tekst_do_zmiany;
  begin
    for i in 1..t_pol_znaki.count loop
      v_tekst := replace(v_tekst, t_pol_znaki(i), t_zamienniki(i));
    end loop;
    return v_tekst;
  end bez_polskich_znakow;
  
  function wstaw_polskie_znaki (p_tekst_na_polski varchar2)
  return varchar2 is
    type T_ZNAKI is table of VARCHAR2(10);
    t_pol_znaki T_ZNAKI := T_ZNAKI('π', 'Ê', 'Í', '≥', 'Ò', 'Û', 'ú', 'ü', 'ø', '•', '∆', ' ', '£', '—', '”', 'å', 'è', 'Ø', '');
    t_do_zmiany T_ZNAKI := T_ZNAKI('/ua', '/uc' ,'/ue', '/ul', '/un', '/uo', '/us', '/ux', '/uz', '/uA', '/uC' ,'/uE', '/uL', '/uN', '/uO', '/uS', '/uX', '/uZ', '/u');
    v_tekst varchar(1000) := (p_tekst_na_polski);
  begin
    for i in 1..t_pol_znaki.count loop
      v_tekst := replace(v_tekst, t_do_zmiany(i), t_pol_znaki(i));
    end loop;
    --v_tekst := replace(v_tekst, '/u', '');
    return v_tekst;
  end wstaw_polskie_znaki;
end polskie_znaki;
