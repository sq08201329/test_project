
declare
i t1.sal%type;
n t1.ename%type;
begin
        i:=0;
        delete from t1;
loop
        if i >= 100 then
                return;
        end if;
        i:=i+1;
        n:='name'||i;
                insert into t1 values(n,i);
end loop;
end;
