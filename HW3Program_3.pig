ln = LOAD 'nyc_taxi_data_2014.csv' USING PigStorage(',');
ln1 = FILTER ln BY $0 != 'vendor_id';
nyctaxi = FOREACH ln1 GENERATE $3 AS passenger_count, $4 AS trip_distance, $12 AS fare_amount, ($15/$17) AS trip_rate;
nyctaxi2 = FILTER nyctaxi BY (passenger_count > 0 AND passenger_count < 10);
nycdata = GROUP nyctaxi2 BY passenger_count;
op = FOREACH nycdata GENERATE AVG(nyctaxi2.trip_distance), AVG(nyctaxi2.fare_amount), AVG(nyctaxi2.trip_rate);
DUMP op;