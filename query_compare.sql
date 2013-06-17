-- Comparação de query

begin
  plunit.assert_query_equals('select first_name from employees where first_name like ''Alexander''',
                             'select first_name from employees where first_name like ''Alexander'''
                             );
end;
