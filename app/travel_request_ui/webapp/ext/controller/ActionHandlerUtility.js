sap.ui.define([
    "sap/m/MessageToast"
], function (MessageToast) {
    'use strict';

    return {
        /**
         * Generated event handler.
         *
         * @param oContext the context of the page on which the event was fired. `undefined` for list report page.
         * @param aSelectedContexts the selected contexts of the table rows.
         */
        approveTravelRequest: function (oContext, aSelectedContexts) {
            const requestId = oContext.getObject().ID;
            const sActionName = "approveTravelRequest";
            let mParameters = {
                model: oContext.getModel(),
                parameterValues: [{
                    "name": "requestId",
                    "value": requestId
                }],
                skipParameterDialog: true
            };
            this.getEditFlow().invokeAction(sActionName, mParameters).then(function (oResult) {
                this._controller.getExtensionAPI().refresh();
                MessageToast.show("Request approved successfully.");
            }.bind(this)).catch(function (oError) { });

        }
    };
});
