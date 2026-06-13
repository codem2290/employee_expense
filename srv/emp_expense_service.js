const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

class EmployeeExpenseService extends cds.ApplicationService {
    init() {

        const { TravelRequests, Expenses } = this.entities;
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

        this.before("CREATE", Expenses.drafts, async (req) => {
            let { travelRequest_ID } = req.data;
            let oTravelRequestData = await SELECT.one.from(TravelRequests.drafts).where({ ID: travelRequest_ID });
            req.data.total = oTravelRequestData.advanceAmount;
            return req.data;
        });

        this.before("UPDATE", Expenses.drafts, async (req) => {
            let { amount, ID } = req.data;
            if (amount) {
                let expenseData = await SELECT.one.from(Expenses.drafts).columns("total").where({ ID: ID });
                let expenseTotal = expenseData.total - parseFloat(amount);
                req.data.total = expenseTotal;
                return req.data;
            }
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
            const requestID = req.params[0].ID;
            let checkRequestData = await SELECT.one.from(TravelRequests).where({ ID: requestID });

            if (!checkRequestData) {
                req.error(404, "Travel request not found");
            }

            await UPDATE(TravelRequests, requestID).with({ status_travelStatusCode: 'REJECTED' });
            return "Travel request rejected successfully";

        });

        this.on("callExpenseProcedure", async (req) => {
            let dbquery = `Call "getExpenseDetails"(APPROVALSTATUS => ?,EXPENSEDATA => ?)`;
            let data = await cds.run(dbquery);

            if (data) {
                let result = {
                    approvalStatusData: data.APPROVALSTATUS,
                    expenseData: data.EXPENSEDATA
                };
                return result;
            }
        });


        // this.on('READ', TravelRequests, async (req) => {

        // })

        return super.init();
    }

}

module.exports = EmployeeExpenseService;