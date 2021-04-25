
DROP TABLE general.message_log CASCADE;
DROP TABLE general.message_master CASCADE;
DROP TABLE general.sender_master CASCADE;


CREATE TABLE general.sender_master (
    id SERIAL primary key ,
    mobile varchar(20) ,
    generated integer not null default extract (epoch from now()) ,
    UNIQUE (mobile)
);

CREATE TABLE general.message_master
(
    id serial primary key,
    message text not null,
    message_signature varchar(255) not null,
    generated integer not null default extract (epoch from now()) ,
    first_reported integer not null,
    last_reported integer not null, 
    report_count integer not null
);

CREATE TABLE general.message_log
(
    id serial primary key,
    gateway_id varchar(255) not null,
    server_generated integer not null ,
    generated integer not null default extract (epoch from now()) ,
    message_type varchar(20) not null,
    value text ,
    text_value text,
    sender_id integer not null references general.sender_master(id) ,
    message_id integer not null references general.message_master (id)
);

CREATE INDEX message_log_message_id ON general.message_log(message_id);
CREATE INDEX message_log_sender_id ON general.message_log(sender_id);
