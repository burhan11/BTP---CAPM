namespace burhan.common;

using {Currency} from '@sap/cds/common';

type Gender      : String(1) enum {
    male        = 'M';
    female      = 'F';
    undisclosed = 'U';
};

type AmountT     : Decimal(10, 2) @(
    Semantic.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit                    : 'CURRENCY_CODE'
);

aspect Amount {
    CURRENCY     : Currency @title: '{i18n>CURRENCY_CODE}';
    GROSS_AMOUNT : AmountT  @(title: '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT   : AmountT  @(title: '{i18n>NetAmount}');
    TAX_AMOUNT   : AmountT  @(title: '{i18n>TaxAmount}');
};

type Guid        : String(32);
type PhoneNumber : String(30) @assert.format: '^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';
type Email       : String(255) @assert.format: '^[a-zA-Z0-9._%±]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$';
