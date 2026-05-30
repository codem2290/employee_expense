using EmployeeExpenseService as service from '../../srv/emp_expense_service';

annotate service.TravelRequests with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: requestNo,
        Label : '{i18n>RequestNo}',
    },
    {
        $Type: 'UI.DataField',
        Value: startDate,
        Label : '{i18n>StartDate}',
    },
    {
        $Type: 'UI.DataField',
        Value: endDate,
        Label : '{i18n>EndDate}',
    },
    {
        $Type : 'UI.DataField',
        Value : advanceAmount,
        Label : '{i18n>AddvanceAmount}',
    },
    {
        $Type : 'UI.DataField',
        Value : createdBy,
    },
    {
        $Type : 'UI.DataField',
        Value : employee_ID,
        Label : '{i18n>EmployeeId}',
    },
    {
        $Type : 'UI.DataField',
        Value : purpose,
        Label : '{i18n>Purpose}',
    },
    {
        $Type : 'UI.DataField',
        Value : status.travelStatusName,
        Label : '{i18n>Status}',
        Criticality : status.colorCode,
        CriticalityRepresentation : #WithIcon,
    },
],
    UI.SelectionFields : [
        country_countryCode,
        city_cityCode,
        status_travelStatusCode,
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>TravelRequestDetails}',
            ID : 'i18nTravelRequestDetails',
            Target : '@UI.FieldGroup#i18nTravelRequestDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>ExpenseDetails}',
            ID : 'i18nExpenseDetails',
            Target : 'expenses/@UI.LineItem#i18nExpenseDetails',
        },
    ],
    UI.FieldGroup #i18nTravelRequestDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : requestNo,
                Label : '{i18n>RequestNo}',
            },
            {
                $Type : 'UI.DataField',
                Value : purpose,
                Label : '{i18n>Purpose}',
            },
            {
                $Type : 'UI.DataField',
                Value : startDate,
                Label : '{i18n>StartDate}',
            },
            {
                $Type : 'UI.DataField',
                Value : endDate,
                Label : '{i18n>EndDate}',
            },
            {
                $Type : 'UI.DataField',
                Value : country_countryCode,
            },
            {
                $Type : 'UI.DataField',
                Value : city_cityCode,
            },
            {
                $Type : 'UI.DataField',
                Value : advanceAmount,
                Label : '{i18n>AdvanceAmount}',
            },
            {
                $Type : 'UI.DataField',
                Value : status.travelStatusName,
                Label : 'Status',
                Criticality : status.colorCode,
                CriticalityRepresentation : #WithoutIcon,
            },
        ],
    },
    UI.DataPoint #requestNo : {
        $Type : 'UI.DataPointType',
        Value : requestNo,
        Title : '{i18n>RequestNo}',
    },
    UI.HeaderFacets : [
        
    ],
    UI.HeaderInfo : {
        TypeName : 'Travel Details',
        TypeNamePlural : '',
        Title : {
            $Type : 'UI.DataField',
            Value : requestNo,
        },
    },);
annotate service.TravelRequests with {
    country @(
        Common.Label : '{i18n>Country1}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Countries',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : country_countryCode,
                    ValueListProperty : 'countryCode',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'countryName',
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : country.countryName,
    )
};

annotate service.TravelRequests with {
    city @(
        Common.Label : '{i18n>City}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Cities',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : city_cityCode,
                    ValueListProperty : 'cityCode',
                },
                {
                    $Type : 'Common.ValueListParameterIn',
                    ValueListProperty : 'country_countryCode',
                    LocalDataProperty : country_countryCode,
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : city.cityName,
    )
};

annotate service.TravelRequests with {
    status @(
        Common.Label : '{i18n>Status}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'TravelStatus',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status_travelStatusCode,
                    ValueListProperty : 'travelStatusCode',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.TravelStatus with {
    travelStatusCode @(
        Common.Text : travelStatusName,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate service.Expenses with @(
    UI.LineItem #i18nExpenseDetails : [
        {
            $Type : 'UI.DataField',
            Value : expenseDate,
            Label : '{i18n>ExpenseDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : amount,
            Label : '{i18n>Amount}',
        },
        {
            $Type : 'UI.DataField',
            Value : expenseType_expenseType,
            Label : '{i18n>ExpenseType}',
        },
        {
            $Type : 'UI.DataField',
            Value : remarks,
            Label : '{i18n>Remarks}',
        },
        {
            $Type : 'UI.DataField',
            Value : attachments.fileName,
            Label : '{i18n>FileName}',
        },
    ]
);

annotate service.Cities with {
    cityCode @Common.Text : cityName
};

annotate service.TravelRequests with {
    requestNo @Common.FieldControl : #ReadOnly
};

