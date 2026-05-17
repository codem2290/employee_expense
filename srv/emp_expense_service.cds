using {travel.management as dbTables} from '../db/data-model';

service EmployeeExpenseService {
    entity Departments    as projection on dbTables.Departments;
    entity Countries      as projection on dbTables.Countries;
    entity Cities         as projection on dbTables.Cities;
    entity TravelStatus   as projection on dbTables.TravelStatus;
    entity ExpenseType    as projection on dbTables.ExpenseType;
    entity Employees      as projection on dbTables.Employees;
    entity Roles          as projection on dbTables.Roles;
    entity TravelRequests as projection on dbTables.TravelRequests;
    entity Expenses       as projection on dbTables.Expenses;
    entity Approvals      as projection on dbTables.Approvals;
    entity Attachments    as projection on dbTables.Attachments;
    entity ApprovalStatus as projection on dbTables.ApprovalStatus;
}
