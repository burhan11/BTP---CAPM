using {
    anubhav.db.master,
    anubhav.db.transaction
} from '../db/datamodel';
// using {capmapp.db.CDSViews} from '../db/CDSViews';

service catalogService @(
    path   : 'catalogService', //Service name
    require: 'authenticated-user' //Authentication i.e., IDP (Identity Provider) ask for login credentails
) {

    entity BusinessPartnerSet                 as projection on master.businesspartner;
    entity AddressSet                         as projection on master.address;

    // @readonly
    entity EmployeeSet @(restrict: [ //Authorization
        {
            grant: 'READ',
            to   : 'Viewer', //Scope
            where: 'bankName = $user.BankName' //Row level Security - Attribute
        },
        {
            grant: ['WRITE'],
            to   : 'Admin'
        }
    ])                                        as projection on master.employees;

    entity ProductSet                         as projection on master.product;

    @Capabilities: {Deletable: false}
    entity POSet @(odata.draft.enabled: true) as
        projection on transaction.purchaseorder {
            *,
            OVERALL_STATUS,
            Items,
            case OVERALL_STATUS.STATUS_ID
                when
                    'P'
                then
                    'Pending'
                when
                    'N'
                then
                    'New'
                when
                    'A'
                then
                    'Approved'
                when
                    'R'
                then
                    'Rejected'
            end as OverallStatus     : String(10),
            case OVERALL_STATUS.STATUS_ID
                when
                    'P'
                then
                    2
                when
                    'N'
                then
                    2
                when
                    'A'
                then
                    3
                when
                    'R'
                then
                    1
            end as OverallStatusCode : Integer
        }
        actions { //Instance Bound
            @Common.SideEffects: { //To reflect changes without loading the page again
                $Type           : 'Common.SideEffectsType',
                TargetProperties: ['in/GROSS_AMOUNT']
            }
            action boost() returns POSet
        };

    entity POItemSet                          as projection on transaction.poitems;
    entity StatusSet                          as projection on master.status;
    function getLargestOrder()  returns array of POSet; //Non-Instance Bound
    function setDefaultStatus() returns POSet;

// entity Products as projection on CDSViews.CDSViews.ProductView;
// //Require to expose associated view to the Service
// entity OrderItems as projection on CDSViews.CDSViews.ItemView;

}
