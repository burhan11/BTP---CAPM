namespace ust.reuse;

// Reusable single data type
type Guid : String(32);

//Reusable Structure
aspect address {
    houseno  : Integer;
    street   : String(30);
    sector   : String(30);
    landmark : String(50);
    city     : String(30);
    country  : String(4);
}
