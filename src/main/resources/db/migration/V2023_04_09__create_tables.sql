CREATE TABLE public.animals (
    id BIGINT CONSTRAINT animals__pk__id PRIMARY KEY,
    name VARCHAR(63),
    species VARCHAR(63)
);

CREATE SEQUENCE animals__seq__id START WITH 1 INCREMENT BY 50 OWNED BY public.animals.id;