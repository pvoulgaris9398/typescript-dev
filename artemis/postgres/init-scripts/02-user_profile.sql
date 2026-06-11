create table if not exists :"schema_name".user_profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_name VARCHAR(100) NOT NULL,
    ticker_list VARCHAR(20)[] NOT NULL, -- PostgreSQL array type for dynamic lists
    cron_schedule VARCHAR(50) DEFAULT '0 0 * * *' NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    api_configuration_id UUID REFERENCES api_configurations(id) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);