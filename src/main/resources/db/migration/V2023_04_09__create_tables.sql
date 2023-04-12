CREATE TABLE public.animals (
    id BIGINT CONSTRAINT animals__pk__id PRIMARY KEY,
    name VARCHAR(63) NOT NULL,
    species VARCHAR(63) NOT NULL,
    CONSTRAINT animals__unique__name UNIQUE(name)
);

CREATE SEQUENCE animals__seq__id AS BIGINT START WITH 1 INCREMENT BY 50 OWNED BY public.animals.id;