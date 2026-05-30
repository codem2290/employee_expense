sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/travel/request/travelrequestui/test/integration/pages/TravelRequestsList",
	"com/travel/request/travelrequestui/test/integration/pages/TravelRequestsObjectPage"
], function (JourneyRunner, TravelRequestsList, TravelRequestsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/travel/request/travelrequestui') + '/test/flp.html#app-preview',
        pages: {
			onTheTravelRequestsList: TravelRequestsList,
			onTheTravelRequestsObjectPage: TravelRequestsObjectPage
        },
        async: true
    });

    return runner;
});

