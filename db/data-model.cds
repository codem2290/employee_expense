namespace travel.management;

type nameDataType : String(50);

entity Employees {
    key ID            : UUID;
        employeeID    : String(20);
        firstName     : nameDataType;
        lastName      : nameDataType;
        email         : String(100);
        phone         : String(20);
        designation   : String(100);
        joiningDate   : Date;
        manager       : String;
        department    : String;
        travelRequest : String;
}


entity Departments {
    key code : String;
        desc : String;
}
