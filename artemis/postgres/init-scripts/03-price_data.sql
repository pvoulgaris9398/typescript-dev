create table if not exists :"schema_name".price_data (
    id BIGSERIAL PRIMARY KEY, -- Using 64-bit integer for large time-series growth
    profile_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE,
    ticker VARCHAR(20) NOT NULL,
    price NUMERIC(18, 4) NOT NULL,
    volume NUMERIC(18, 4) NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX idx_price_data_query 
ON price_data (profile_id, ticker, timestamp DESC);