-- Executar como System

-- Criação do usuário para armazenar a package de teste
create user tst identified by "tst";
  
-- Grants
grant connect to tst;
grant resource to tst;
grant create any sequence to tst;
grant create any synonym to tst;
grant create any table to tst;
grant unlimited tablespace to tst;
