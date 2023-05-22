// The name risk-service.js is the same as the name service .cds
//CAP automatically treats it as a handler file for the
//application defined in there

const cds = require('@sap/cds');

/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */
module.exports = cds.service.impl(async function () {
  this.after('READ', 'Risks', (risksData) => {
    //event triggered after read Risks entity
    const risks = Array.isArray(risksData) ? risksData : [risksData];
    risks.forEach((risk) => {
      if (risk.impact >= 100000) {
        risk.criticality = 1;
      } else {
        risk.criticality = 2;
      }
    });
  });
  this.before('CREATE', 'Risks', async (req) => {
    const tx = this.transaction(req);
    console.log(req);
    const { id } = req.data;

    if (!id) {
      // Retrieve the last ID from the existing entries
      const lastEntry = await tx.run(
        SELECT.one.from('Risks').orderBy({ id: 'desc' })
      );
      console.log(lastEntry);
      // Increment the last ID or start from 1 if no entries exist
      const newId = lastEntry ? lastEntry.id + 1 : 1;

      // Set the new ID in the request data
      req.data.id = newId;
    }
  });
});
