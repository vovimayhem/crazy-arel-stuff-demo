--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- Name: record_score; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE record_score AS (
	id numeric,
	score numeric(8,4)
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: inbound_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE inbound_logs (
    id integer NOT NULL,
    inbound_order_id integer NOT NULL,
    product_id integer NOT NULL,
    properties jsonb DEFAULT '{}'::jsonb NOT NULL,
    quantity integer NOT NULL,
    shelf_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: inbound_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inbound_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inbound_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inbound_logs_id_seq OWNED BY inbound_logs.id;


--
-- Name: inbound_order_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE inbound_order_transitions (
    id integer NOT NULL,
    to_state character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    sort_key integer NOT NULL,
    inbound_order_id integer NOT NULL,
    most_recent boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: inbound_order_transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inbound_order_transitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inbound_order_transitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inbound_order_transitions_id_seq OWNED BY inbound_order_transitions.id;


--
-- Name: inbound_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE inbound_orders (
    id integer NOT NULL,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: inbound_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inbound_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inbound_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inbound_orders_id_seq OWNED BY inbound_orders.id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE items (
    id integer NOT NULL,
    inbound_log_id integer NOT NULL,
    product_id integer NOT NULL,
    properties jsonb DEFAULT '"{}"'::jsonb NOT NULL,
    shelf_id integer,
    rank integer,
    outbound_log_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE items_id_seq OWNED BY items.id;


--
-- Name: outbound_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE outbound_logs (
    id integer NOT NULL,
    sale_order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: outbound_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE outbound_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: outbound_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE outbound_logs_id_seq OWNED BY outbound_logs.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE products (
    id integer NOT NULL,
    category_id integer,
    name character varying,
    brand character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: sale_order_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sale_order_transitions (
    id integer NOT NULL,
    to_state character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    sort_key integer NOT NULL,
    sale_order_id integer NOT NULL,
    most_recent boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sale_order_transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sale_order_transitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sale_order_transitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sale_order_transitions_id_seq OWNED BY sale_order_transitions.id;


--
-- Name: sale_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sale_orders (
    id integer NOT NULL,
    paid boolean,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sale_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sale_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sale_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sale_orders_id_seq OWNED BY sale_orders.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: shelves; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE shelves (
    id integer NOT NULL,
    name character varying NOT NULL,
    warehouse boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: shelves_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE shelves_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shelves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE shelves_id_seq OWNED BY shelves.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inbound_logs ALTER COLUMN id SET DEFAULT nextval('inbound_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inbound_order_transitions ALTER COLUMN id SET DEFAULT nextval('inbound_order_transitions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inbound_orders ALTER COLUMN id SET DEFAULT nextval('inbound_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY items ALTER COLUMN id SET DEFAULT nextval('items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY outbound_logs ALTER COLUMN id SET DEFAULT nextval('outbound_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sale_order_transitions ALTER COLUMN id SET DEFAULT nextval('sale_order_transitions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sale_orders ALTER COLUMN id SET DEFAULT nextval('sale_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY shelves ALTER COLUMN id SET DEFAULT nextval('shelves_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: inbound_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inbound_logs
    ADD CONSTRAINT inbound_logs_pkey PRIMARY KEY (id);


--
-- Name: inbound_order_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inbound_order_transitions
    ADD CONSTRAINT inbound_order_transitions_pkey PRIMARY KEY (id);


--
-- Name: inbound_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inbound_orders
    ADD CONSTRAINT inbound_orders_pkey PRIMARY KEY (id);


--
-- Name: items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: outbound_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY outbound_logs
    ADD CONSTRAINT outbound_logs_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: sale_order_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sale_order_transitions
    ADD CONSTRAINT sale_order_transitions_pkey PRIMARY KEY (id);


--
-- Name: sale_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sale_orders
    ADD CONSTRAINT sale_orders_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shelves_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY shelves
    ADD CONSTRAINT shelves_pkey PRIMARY KEY (id);


--
-- Name: UK_shelf_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "UK_shelf_name" ON shelves USING btree (name);


--
-- Name: index_inbound_logs_on_inbound_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inbound_logs_on_inbound_order_id ON inbound_logs USING btree (inbound_order_id);


--
-- Name: index_inbound_logs_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inbound_logs_on_product_id ON inbound_logs USING btree (product_id);


--
-- Name: index_inbound_logs_on_shelf_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inbound_logs_on_shelf_id ON inbound_logs USING btree (shelf_id);


--
-- Name: index_inbound_order_transitions_parent_most_recent; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_inbound_order_transitions_parent_most_recent ON inbound_order_transitions USING btree (inbound_order_id, most_recent) WHERE most_recent;


--
-- Name: index_inbound_order_transitions_parent_sort; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_inbound_order_transitions_parent_sort ON inbound_order_transitions USING btree (inbound_order_id, sort_key);


--
-- Name: index_items_on_inbound_log_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_inbound_log_id ON items USING btree (inbound_log_id);


--
-- Name: index_items_on_outbound_log_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_outbound_log_id ON items USING btree (outbound_log_id);


--
-- Name: index_items_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_product_id ON items USING btree (product_id);


--
-- Name: index_items_on_shelf_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_shelf_id ON items USING btree (shelf_id);


--
-- Name: index_outbound_logs_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_outbound_logs_on_product_id ON outbound_logs USING btree (product_id);


--
-- Name: index_outbound_logs_on_sale_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_outbound_logs_on_sale_order_id ON outbound_logs USING btree (sale_order_id);


--
-- Name: index_products_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_category_id ON products USING btree (category_id);


--
-- Name: index_sale_order_transitions_parent_most_recent; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sale_order_transitions_parent_most_recent ON sale_order_transitions USING btree (sale_order_id, most_recent) WHERE most_recent;


--
-- Name: index_sale_order_transitions_parent_sort; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sale_order_transitions_parent_sort ON sale_order_transitions USING btree (sale_order_id, sort_key);


--
-- Name: fk_rails_04ddb91cd5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inbound_logs
    ADD CONSTRAINT fk_rails_04ddb91cd5 FOREIGN KEY (inbound_order_id) REFERENCES inbound_orders(id);


--
-- Name: fk_rails_05a16c0ecc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_rails_05a16c0ecc FOREIGN KEY (inbound_log_id) REFERENCES inbound_logs(id);


--
-- Name: fk_rails_38c55b2f37; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_rails_38c55b2f37 FOREIGN KEY (outbound_log_id) REFERENCES outbound_logs(id);


--
-- Name: fk_rails_441ddf26ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inbound_logs
    ADD CONSTRAINT fk_rails_441ddf26ab FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: fk_rails_5f0941df6b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inbound_logs
    ADD CONSTRAINT fk_rails_5f0941df6b FOREIGN KEY (shelf_id) REFERENCES shelves(id);


--
-- Name: fk_rails_79bfae626c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY outbound_logs
    ADD CONSTRAINT fk_rails_79bfae626c FOREIGN KEY (sale_order_id) REFERENCES sale_orders(id);


--
-- Name: fk_rails_9a56345cfd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_rails_9a56345cfd FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: fk_rails_e89b975408; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY outbound_logs
    ADD CONSTRAINT fk_rails_e89b975408 FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: fk_rails_fb915499a4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY products
    ADD CONSTRAINT fk_rails_fb915499a4 FOREIGN KEY (category_id) REFERENCES categories(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO public,partitioning;

INSERT INTO schema_migrations (version) VALUES ('20160723024634'), ('20160723024742'), ('20160723025906'), ('20160723034732'), ('20160723174156');


