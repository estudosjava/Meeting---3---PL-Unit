create or replace package HR_TOOLS is
  procedure InsertCountry(pCountryId   in char,
                          pCountryName in varchar2,
                          pRegionId    in number);
                          
  procedure InsertDepartment(pDepartmentId   in number,
                             pDepartmentName in varchar2,
                             pManagerId      in number,
                             pLocationId     in number);
                             
  procedure InsertEmployee(pFirstName     in varchar2,
                           pLastName      in varchar2,
                           pEmail         in varchar2,
                           pPhoneNumber   in varchar2,
                           pHireDate      in date,
                           pJobId         in varchar2,
                           pSalary        in number,
                           pCommissionPct in number,
                           pManagerId     in number,
                           pDepartmentId  in number);

  function CheckJobSalary (pJobId in varchar2, pSalary in number) return boolean;

end HR_TOOLS;
/
create or replace package body HR_TOOLS is
  procedure InsertCountry(pCountryId   in char,
                          pCountryName in varchar2,
                          pRegionId    in number) is
  begin
    insert into COUNTRIES
      (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
    VALUES
      (pCountryId, pCountryName, pRegionId);
  end;

procedure InsertDepartment(pDepartmentId   in number,
                           pDepartmentName in varchar2,
                           pManagerId      in number,
                           pLocationId     in number) is
begin
  insert into DEPARTMENTS
    (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
  values
    (pDepartmentId, pDepartmentName, pManagerId, pLocationId);
end;


  procedure InsertEmployee(pFirstName     in varchar2,
                           pLastName      in varchar2,
                           pEmail         in varchar2,
                           pPhoneNumber   in varchar2,
                           pHireDate      in date,
                           pJobId         in varchar2,
                           pSalary        in number,
                           pCommissionPct in number,
                           pManagerId     in number,
                           pDepartmentId  in number) is
  begin
    insert into EMPLOYEES
      (EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       EMAIL,
       PHONE_NUMBER,
       HIRE_DATE,
       JOB_ID,
       SALARY,
       COMMISSION_PCT,
       MANAGER_ID,
       DEPARTMENT_ID)
    values
      (employees_seq.nextval,
       pFirstName,
       pLastName,
       pEmail,
       pPhoneNumber,
       pHireDate,
       pJobId,
       pSalary,
       pCommissionPct,
       pManagerId,
       pDepartmentId);
  end;

  function GetJobs (pJobId in varchar2) return Jobs%Rowtype is
    cursor cJobs is
    select * from jobs where job_id = pJobId;

    rJob cJobs%Rowtype;
  begin
    open cJobs;
    fetch cJobs into rJob;
    close cJobs;

    return rJob;
  end;


  function CheckJobSalary (pJobId in varchar2, pSalary in number) return boolean is
    rJob jobs%rowtype;
  begin
    rJob := GetJobs(pJobId);

    if pSalary between rJob.min_Salary and rJob.max_Salary then
      return true;
    else
      return false;
    end if;
  end;

end HR_TOOLS;
/
