using {ust.reuse as reuse} from './ust-reuse';
using {
    cuid,
    managed,
    temporal
} from '@sap/cds/common';


namespace ust.demo;

context master {
    entity student : reuse.address { //Reusable Structure
        key id        : reuse.Guid; //Reusable Data type
            nameFirst : String(80);
            nameLast  : String(80);
            age       : Integer;
            // Forign Key - @Runtime creates field with name class_id
            class     : Association to semester; //Association to one OR Association to many
    }

    entity semester {
        key id             : reuse.Guid;
            name           : String(80);
            specialization : String(30);
            hod            : String(40);
    }

    entity books {
        key code   : reuse.Guid;
            name   : localized String(80);
            author : String(40);
    }
}

context transaction {
    entity subs : cuid, managed, temporal {
        student : Association to one master.student;
        book    : Association to one master.books;
    }
}
