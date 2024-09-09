sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ust/capapp/purchaseorderapp/test/integration/FirstJourney',
		'ust/capapp/purchaseorderapp/test/integration/pages/POSetList',
		'ust/capapp/purchaseorderapp/test/integration/pages/POSetObjectPage',
		'ust/capapp/purchaseorderapp/test/integration/pages/POItemSetObjectPage'
    ],
    function(JourneyRunner, opaJourney, POSetList, POSetObjectPage, POItemSetObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ust/capapp/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOSetList: POSetList,
					onThePOSetObjectPage: POSetObjectPage,
					onThePOItemSetObjectPage: POItemSetObjectPage
                }
            },
            opaJourney.run
        );
    }
);