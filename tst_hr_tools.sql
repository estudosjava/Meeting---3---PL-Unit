create or replace package tst_hr_tools is
  procedure prRollback;
  
  procedure t_InsertEmployee;
  procedure t_CheckJobSalaryTRUE;
  procedure t_CheckJobSalaryFALSE;
  /*procedure t_query;
  procedure t_QueryResult;*/
  
end tst_hr_tools;
/
create or replace package body tst_hr_tools is
  procedure prRollback is
  begin
    rollback;
  end;

  procedure t_InsertEmployee is
    vFirstName varchar2(100) := 'João';
    vLastName varchar2(100) := 'Silva';
    vEmail varchar2(100) := 'JSILVA4';
    vPhone varchar2(100) := '590.423.4570';
    vHireDate date := sysdate;
    vJobID varchar2(100) := 'IT_PROG';
    vSalary number(16,2) := 200000;
    vComissionPCT number(2,2) := 0;
    vManagerId number := 103;
    vDepartmentId number := 60;
    
    vEmployeeCounter number;
    
    function GetEmployeeCount (pFirstName in varchar2) return number is
      cursor cCountEmployees is
      select count(*)
        from employees a
       where a.first_name like ('%'||pFirstName||'%');
       
       vEmployeeCounter number;
    begin
      open cCountEmployees;
      fetch cCountEmployees into vEmployeeCounter;
      close cCountEmployees;
      
      return vEmployeeCounter;
    end;                 
    
    procedure setup(pFirstName in varchar2) is
    begin
      delete from employees where first_name like ('%'||pFirstName||'%');
    end;
     
  begin        
    setup(vFirstName);
  
    vEmployeeCounter := GetEmployeeCount(vFirstName);
    
    plunit.assert_equals(0,vEmployeeCounter);    
  
    hr_tools.InsertEmployee(vFirstName, 
                            vLastName, 
                            vEmail, 
                            vPhone, 
                            vHireDate, 
                            vJobID, 
                            vSalary, 
                            vComissionPCT, 
                            vManagerId, 
                            vDepartmentId);
    
    vEmployeeCounter := GetEmployeeCount(vFirstName);
    
    plunit.assert_equals(1,vEmployeeCounter);  
       
    prRollback;
  end;
  
  procedure t_CheckJobSalaryTRUE is    
  begin
    plunit.assert_true(hr_tools.CheckJobSalary(pJobId => 'AD_VP',pSalary => 20000));
  end;

  procedure t_CheckJobSalaryFALSE is    
  begin
    plunit.assert_false(hr_tools.CheckJobSalary(pJobId => 'AD_VP',pSalary => 10000));
  end;

  /*procedure t_Query is    
  begin
    plunit.assert_query_equals('select first_name, last_name, email from employees where first_name like ''Alexander''',
                             'select first_name, last_name, email from employees where last_name like ''Hunold'''
                             );
  end;

  procedure t_QueryResult is  
  begin
    plunit.assert_query_equals_value(query => 'select count(*) from employees', expected => 100);
  end;*/


end tst_hr_tools;
/
