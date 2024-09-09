module.exports = cds.service.impl(async function (srv) {
    //Get the object of our ODATA entities
    const { POSet, EmployeeSet } = this.entities;

    //Opeartion before the db call
    this.before('UPDATE', EmployeeSet, (req) => {   //'*' means it will be work for CREATE and UPDATE both
        let salary = parseInt(req.data.salaryAmount);
        if (salary >= 100000) {
            req.error('500', 'Salary Limit is 100000'); //Its an Exception so req is given
        }
    });

    this.after('READ', EmployeeSet, (data) => {
        data.push({
            "ID": "CUSTOM_ID",
            "nameFirst": "Amazon"
        });
    })

    this.on('boost', async (req, res) => {
        try {
            //Since its instance bound we will get the key of PO
            let id = req.params[0];
            //Print key in console
            console.log('Hey your id is : ' + id);
            //Start the db transaction
            const tx = cds.tx(req);
            //UPDATE dbtab set GROSS_AMOUNT = Current + 20000 WHERE Id = key
            await tx.update(POSet).with({
                GROSS_AMOUNT: { '+=': 20000 }
            }).where(id);
        } catch (error) {
            return "Error: " + error.toString();
        }
    });

    this.on('getLargestOrder', async (req, res) => {
        try {
            const result = await srv.run(SELECT.from('POSet').orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1));
            // OR
            // const tx = cds.tx(req);
            // const result = await tx.read(POSet).orderBy({
            //     GROSS_AMOUNT: 'desc'
            // }).limit(1);
            return result
        } catch (error) {
            return "Error: " + error.toString()
        }
    });

    this.on('setDefaultStatus', (req, res) =>{
        return {
            "OVERALL_STATUS_STATUS_ID": 'N'
        };
    });
})