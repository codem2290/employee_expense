const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

class EmployeeExpenseService extends cds.ApplicationService {
    init() {

        const { TravelRequests } = this.entities;
        this.before("UPDATE", TravelRequests.drafts, async (req) => {
            debugger;
            const { advanceAmount } = req.data;

            if (advanceAmount) {
                if (advanceAmount > 15000) {
                    req.error(400, "Advance amount cannot be greater than 15000", 'advanceAmount');
                }
            }

        });

        this.before("CREATE", TravelRequests.drafts, async (req) => {

            req.data.requestNo = `TR${Math.floor(Math.random() * 1000000)}`;
            return req.data;

        });

        this.on("approveTravelRequest", async (req) => {
            const { requestId } = req.data;
            let checkRequestData = await SELECT.one.from(TravelRequests).where({ ID: requestId });

            if (!checkRequestData) {
                req.error(404, "Travel request not found");
            }

            await UPDATE(TravelRequests, requestId).with({ status_travelStatusCode: 'MANAGER_APPROVED' });
            return "Travel request approved successfully";
        });

        this.on("rejectTravelRequest", async (req) => {
            const { requestId } = req.data;
        });


        // this.on('READ', TravelRequests, async (req) => {

        // })

        return super.init();
    }

}

module.exports = EmployeeExpenseService;