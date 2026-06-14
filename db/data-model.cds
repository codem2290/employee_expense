namespace travel.management;

using {
    cuid,
    managed
} from '@sap/cds/common';

type nameDataType : String(50);

entity Employees : cuid, managed {
    //key ID            : UUID;
    employeeID    : String(20);
    firstName     : nameDataType;
    lastName      : nameDataType;
    email         : String(100);
    phone         : String(20);
    designation   : String(100);
    joiningDate   : Date;
    manager       : String;
    department    : Association to Departments; // Managed association
    // departmentNav : Association to Departments
    //                     on department.code = department_ID; // unmanaged association
    department_ID : String; // unmanaged association
    travelRequest : Association to many TravelRequests
                        on travelRequest.employee = $self;
    role          : Association to Roles;
}

entity Roles : cuid {
    roleCode  : String;
    roleName  : String;
    employees : Association to many Employees
                    on employees.role = $self;
}

entity TravelRequests : cuid, managed {
    //key ID            : UUID;
    requestNo     : String(30);
    employee      : Association to Employees;
    country       : Association to Countries;
    city          : Association to Cities;
    purpose       : String(500);
    startDate     : Date;
    endDate       : Date;
    advanceAmount : Decimal(10, 2);
    status        : Association to TravelStatus;
    expenses      : Composition of many Expenses
                        on expenses.travelRequest = $self;
    approvals     : Association to Approvals;
    attachments   : Association to Attachments;
}

entity Expenses : cuid, managed {
    //key ID            : UUID;
    travelRequest : Association to TravelRequests;
    expenseType   : Association to ExpenseType;
    expenseDate   : Date;
    amount        : Decimal(10, 2);
    remarks       : String(500);
    total         : Decimal(10, 2);
    attachments   : Composition of many Attachments
                        on attachments.expense = $self;
}

entity Approvals : cuid, managed {
    //key ID            : UUID;
    travelRequest : Association to TravelRequests;
    approver      : String;
    status        : Association to ApprovalStatus;
    comments      : String;
    approvalDate  : Timestamp;
}

entity Attachments : cuid, managed {
    //key ID            : UUID;
    travelRequest : Association to TravelRequests;
    fileName      : String;
    mediaType     : String;
    fileURL       : String;
    expense       : Association to Expenses;
}


entity Departments {
    key code     : String;
        name     : String;
        location : String;
}

entity Countries {
    key countryCode : String;
        countryName : String;
        cities      : Association to many Cities
                          on cities.country = $self;
}

entity Cities {
    key cityCode : String;
        cityName : String;
        country  : Association to Countries;
}

entity ExpenseType {
    key expenseType : String;
        expenseName : String;
}

entity TravelStatus {
    key travelStatusCode : String;
        travelStatusName : String;
        colorCode        : Integer;
}

entity ApprovalStatus {
    key statusCode : String;
        statusName : String;
}

@cds.persistence.exists
entity Managers {
    key managerId : Integer;
        name      : String(100);
        email     : String(100);
        phone     : String(20);
}
