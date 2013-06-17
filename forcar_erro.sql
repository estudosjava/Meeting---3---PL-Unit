-- Teste com 2 erros no mesmo procedimento
  declare 
    vFirstName varchar2(100) := 'João';
    vLastName varchar2(100) := 'Silva';
    vEmail varchar2(100) := 'JSILVA3';
    vPhone varchar2(100) := '590.423.4570';
    vHireDate date := sysdate;
    vJobID varchar2(100) := 'IT_PROG';
    vSalary number(16,2) := 200000;
    vComissionPCT number(2,2) := 0;
    vManagerId number := 103;
    vDepartmentId number := 60;        
     
  begin        
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
    

  end;
  
