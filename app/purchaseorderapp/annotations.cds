using catalogService as service from '../../srv/catalogService';

annotate service.POSet with @(
    Common.DefaultValuesFunction: 'setDefaultStatus',
    UI.SelectionFields   : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        GROSS_AMOUNT,
        OVERALL_STATUS_STATUS_ID
    ],
    UI.LineItem          : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'catalogService.boost',
            Label : 'Boost',
            Inline: true,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        },
        {
            $Type      : 'UI.DataField',
            Value      : OverallStatus,
            Criticality: OverallStatusCode
        }
    ],
    UI.HeaderInfo        : {
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME},
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders'
    },
    UI.Facets            : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Information',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Order Details',
                    Target: '@UI.Identification'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Amount Details',
                    Target: '@UI.FieldGroup#Amount'
                }
            // {
            //     $Type : 'UI.ReferenceFacet',
            //     Target: '@UI.DataPoint#GrossAmount'
            // }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'Items/@UI.LineItem'
        }
    ],
    // UI.HeaderFacets          : [{
    //     $Type : 'UI.ReferenceFacet',
    //     Target: '@UI.DataPoint#GrossAmount'
    // }, ],
    UI.Identification    : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS_STATUS_ID,
            Label: 'Status'
        }
    ],
    UI.FieldGroup #Amount: {Data: [
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        }
    ], }
// UI.DataPoint #GrossAmount: {
//     $Type: 'UI.DataPointType',
//     Value: GROSS_AMOUNT
// }
);

annotate service.POItemSet with @(

    UI.LineItem      : [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID.DESCRIPTION,
        },

    ],
    UI.HeaderInfo    : {
        TypeName      : 'PO Item',
        TypeNamePlural: 'PO Items',
        Title         : {Value: PO_ITEM_POS},
        Description   : {Value: PRODUCT_GUID.DESCRIPTION}
    },
    UI.Facets        : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.Identification'
    }],
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID.DESCRIPTION,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        },
    ]
);

annotate service.POItemSet with {
    PRODUCT_GUID @(
        Common.Text     : PRODUCT_GUID.DESCRIPTION, //To show text column also and bind with F4 column
        ValueList.entity: service.ProductSet
    )
};

annotate service.POSet with {
    OVERALL_STATUS @(
        Common          : {Text: OVERALL_STATUS.STATUS_DESCRIPTION},
        ValueList.entity: service.StatusSet,
        readonly
    )
};

@cds.odata.valuelist
annotate service.ProductSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: DESCRIPTION,
}, ]);

@cds.odata.valuelist
annotate service.StatusSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: STATUS_DESCRIPTION
}]);
