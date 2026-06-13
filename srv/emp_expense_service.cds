using {travel.management as dbTables} from '../db/data-model';
@impl: ''
service EmployeeExpenseService {
    entity Departments    as projection on dbTables.Departments;
    entity Countries      as projection on dbTables.Countries;
    entity Cities         as projection on dbTables.Cities;
    entity TravelStatus   as projection on dbTables.TravelStatus;
    entity ExpenseType    as projection on dbTables.ExpenseType;
    entity Employees      as projection on dbTables.Employees;
    entity Roles          as projection on dbTables.Roles;
    @odata.draft.enabled
    entity TravelRequests @(restrict: [
        {
            grant: 'READ',
            to: 'Employees'
        },
        {
            grant: '*',
            to: 'Managers'
        }
    ]) as projection on dbTables.TravelRequests actions {
        //Bound Action
        @(
            cds.odata.bindingparameter.name : '_TravelRequest',
            Common.SideEffects : {
                TargetEntities : ['_TravelRequest'],
                TargetProperties : ['TravelRequest/status_travelStatusCode'],
            },
        )
        action rejectTravelRequest() returns String;
    };
    entity Expenses       as projection on dbTables.Expenses;
    entity Approvals      as projection on dbTables.Approvals;
    entity Attachments    as projection on dbTables.Attachments;
    entity ApprovalStatus as projection on dbTables.ApprovalStatus;

    //unbound action
    action approveTravelRequest(requestId: UUID) returns String;
    // action rejectTravelRequest(requestId: UUID) returns String;

    function calculateTotalAmount(expenseId: UUID) returns Decimal(10, 2);

    function callExpenseProcedure() returns String;
}
