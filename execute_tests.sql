-- Executa todos os testes
begin
  plunit.run_all_tests(owner => 'HR', package_name => 'TST_HR_TOOLS', show_output => TRUE);
end;
