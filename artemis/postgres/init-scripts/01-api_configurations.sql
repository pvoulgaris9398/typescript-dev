
create table if not exists :"schema_name".api_configurations (
    id UUID primary key default gen_random_uuid(), // how does this affect the index when CRUDing?
    api_name varchar(255) not null, // constraint to not allow blanks?
    target_base_url varchar(255) not null,
    extraction_schema jsonb not null,
    created_at timestampz with time zone default CURRENT_TIMESTAMP NOT NULL,
    updated_at timestampz with time zone default CURRENT_TIMESTAMP NULL
);