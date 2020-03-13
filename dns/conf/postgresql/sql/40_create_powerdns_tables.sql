--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(10) NOT NULL,
    modified_at integer NOT NULL,
    account character varying(40) DEFAULT NULL::character varying,
    comment character varying(65535) NOT NULL,
    CONSTRAINT c_lowercase_name CHECK (((name)::text = lower((name)::text)))
);


ALTER TABLE public.comments OWNER TO powerdns;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO powerdns;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: cryptokeys; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.cryptokeys (
    id integer NOT NULL,
    domain_id integer,
    flags integer NOT NULL,
    active boolean,
    content text
);


ALTER TABLE public.cryptokeys OWNER TO powerdns;

--
-- Name: cryptokeys_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.cryptokeys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cryptokeys_id_seq OWNER TO powerdns;

--
-- Name: cryptokeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.cryptokeys_id_seq OWNED BY public.cryptokeys.id;


--
-- Name: domainmetadata; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.domainmetadata (
    id integer NOT NULL,
    domain_id integer,
    kind character varying(32),
    content text
);


ALTER TABLE public.domainmetadata OWNER TO powerdns;

--
-- Name: domainmetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.domainmetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domainmetadata_id_seq OWNER TO powerdns;

--
-- Name: domainmetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.domainmetadata_id_seq OWNED BY public.domainmetadata.id;


--
-- Name: domains; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.domains (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    master character varying(128) DEFAULT NULL::character varying,
    last_check integer,
    type character varying(6) NOT NULL,
    notified_serial bigint,
    account character varying(40) DEFAULT NULL::character varying,
    CONSTRAINT c_lowercase_name CHECK (((name)::text = lower((name)::text)))
);


ALTER TABLE public.domains OWNER TO powerdns;

--
-- Name: domains_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.domains_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domains_id_seq OWNER TO powerdns;

--
-- Name: domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.domains_id_seq OWNED BY public.domains.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.migrations (
    domain_id character varying(255),
    record_id integer
);


ALTER TABLE public.migrations OWNER TO powerdns;

--
-- Name: perm_items; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.perm_items (
    id integer NOT NULL,
    name character varying(64),
    descr character varying(1024)
);


ALTER TABLE public.perm_items OWNER TO powerdns;

--
-- Name: perm_items_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.perm_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perm_items_id_seq OWNER TO powerdns;

--
-- Name: perm_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.perm_items_id_seq OWNED BY public.perm_items.id;


--
-- Name: perm_templ; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.perm_templ (
    id integer NOT NULL,
    name character varying(128),
    descr character varying(1024)
);


ALTER TABLE public.perm_templ OWNER TO powerdns;

--
-- Name: perm_templ_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.perm_templ_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perm_templ_id_seq OWNER TO powerdns;

--
-- Name: perm_templ_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.perm_templ_id_seq OWNED BY public.perm_templ.id;


--
-- Name: perm_templ_items; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.perm_templ_items (
    id integer NOT NULL,
    templ_id integer,
    perm_id integer
);


ALTER TABLE public.perm_templ_items OWNER TO powerdns;

--
-- Name: perm_templ_items_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.perm_templ_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perm_templ_items_id_seq OWNER TO powerdns;

--
-- Name: perm_templ_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.perm_templ_items_id_seq OWNED BY public.perm_templ_items.id;


--
-- Name: records; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.records (
    id bigint NOT NULL,
    domain_id integer,
    name character varying(255) DEFAULT NULL::character varying,
    type character varying(10) DEFAULT NULL::character varying,
    content character varying(65535) DEFAULT NULL::character varying,
    ttl integer,
    prio integer,
    change_date integer,
    disabled boolean DEFAULT false,
    ordername character varying(255),
    auth boolean DEFAULT true,
    CONSTRAINT c_lowercase_name CHECK (((name)::text = lower((name)::text)))
);


ALTER TABLE public.records OWNER TO powerdns;

--
-- Name: records_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.records_id_seq OWNER TO powerdns;

--
-- Name: records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.records_id_seq OWNED BY public.records.id;


--
-- Name: records_zone_templ; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.records_zone_templ (
    domain_id integer,
    record_id integer,
    zone_templ_id integer
);


ALTER TABLE public.records_zone_templ OWNER TO powerdns;

--
-- Name: supermasters; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.supermasters (
    ip inet NOT NULL,
    nameserver character varying(255) NOT NULL,
    account character varying(40) NOT NULL
);


ALTER TABLE public.supermasters OWNER TO powerdns;

--
-- Name: tsigkeys; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.tsigkeys (
    id integer NOT NULL,
    name character varying(255),
    algorithm character varying(50),
    secret character varying(255),
    CONSTRAINT c_lowercase_name CHECK (((name)::text = lower((name)::text)))
);


ALTER TABLE public.tsigkeys OWNER TO powerdns;

--
-- Name: tsigkeys_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.tsigkeys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tsigkeys_id_seq OWNER TO powerdns;

--
-- Name: tsigkeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.tsigkeys_id_seq OWNED BY public.tsigkeys.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(64),
    password character varying(128),
    fullname character varying(255),
    email character varying(255),
    description character varying(1024),
    perm_templ integer,
    active integer,
    use_ldap integer
);


ALTER TABLE public.users OWNER TO powerdns;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO powerdns;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: zone_templ; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.zone_templ (
    id integer NOT NULL,
    name character varying(128),
    descr character varying(1024),
    owner integer
);


ALTER TABLE public.zone_templ OWNER TO powerdns;

--
-- Name: zone_templ_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.zone_templ_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zone_templ_id_seq OWNER TO powerdns;

--
-- Name: zone_templ_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.zone_templ_id_seq OWNED BY public.zone_templ.id;


--
-- Name: zone_templ_records; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.zone_templ_records (
    id integer NOT NULL,
    zone_templ_id integer,
    name character varying(255),
    type character varying(6),
    content character varying(255),
    ttl integer,
    prio integer
);


ALTER TABLE public.zone_templ_records OWNER TO powerdns;

--
-- Name: zone_templ_records_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.zone_templ_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zone_templ_records_id_seq OWNER TO powerdns;

--
-- Name: zone_templ_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.zone_templ_records_id_seq OWNED BY public.zone_templ_records.id;


--
-- Name: zones; Type: TABLE; Schema: public; Owner: powerdns
--

CREATE TABLE public.zones (
    id integer NOT NULL,
    domain_id integer,
    owner integer,
    comment character varying(1024),
    zone_templ_id integer
);


ALTER TABLE public.zones OWNER TO powerdns;

--
-- Name: zones_id_seq; Type: SEQUENCE; Schema: public; Owner: powerdns
--

CREATE SEQUENCE public.zones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zones_id_seq OWNER TO powerdns;

--
-- Name: zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: powerdns
--

ALTER SEQUENCE public.zones_id_seq OWNED BY public.zones.id;


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: cryptokeys id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.cryptokeys ALTER COLUMN id SET DEFAULT nextval('public.cryptokeys_id_seq'::regclass);


--
-- Name: domainmetadata id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.domainmetadata ALTER COLUMN id SET DEFAULT nextval('public.domainmetadata_id_seq'::regclass);


--
-- Name: domains id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.domains ALTER COLUMN id SET DEFAULT nextval('public.domains_id_seq'::regclass);


--
-- Name: perm_items id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.perm_items ALTER COLUMN id SET DEFAULT nextval('public.perm_items_id_seq'::regclass);


--
-- Name: perm_templ id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.perm_templ ALTER COLUMN id SET DEFAULT nextval('public.perm_templ_id_seq'::regclass);


--
-- Name: perm_templ_items id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.perm_templ_items ALTER COLUMN id SET DEFAULT nextval('public.perm_templ_items_id_seq'::regclass);


--
-- Name: records id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.records ALTER COLUMN id SET DEFAULT nextval('public.records_id_seq'::regclass);


--
-- Name: tsigkeys id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.tsigkeys ALTER COLUMN id SET DEFAULT nextval('public.tsigkeys_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: zone_templ id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.zone_templ ALTER COLUMN id SET DEFAULT nextval('public.zone_templ_id_seq'::regclass);


--
-- Name: zone_templ_records id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.zone_templ_records ALTER COLUMN id SET DEFAULT nextval('public.zone_templ_records_id_seq'::regclass);


--
-- Name: zones id; Type: DEFAULT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.zones ALTER COLUMN id SET DEFAULT nextval('public.zones_id_seq'::regclass);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.comments (id, domain_id, name, type, modified_at, account, comment) FROM stdin;
\.


--
-- Data for Name: cryptokeys; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.cryptokeys (id, domain_id, flags, active, content) FROM stdin;
\.


--
-- Data for Name: domainmetadata; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.domainmetadata (id, domain_id, kind, content) FROM stdin;
\.


--
-- Data for Name: domains; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.domains (id, name, master, last_check, type, notified_serial, account) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.migrations (domain_id, record_id) FROM stdin;
\.


--
-- Data for Name: perm_items; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.perm_items (id, name, descr) FROM stdin;
41	zone_master_add	User is allowed to add new master zones.
42	zone_slave_add	User is allowed to add new slave zones.
43	zone_content_view_own	User is allowed to see the content and meta data of zones he owns.
44	zone_content_edit_own	User is allowed to edit the content of zones he owns.
45	zone_meta_edit_own	User is allowed to edit the meta data of zones he owns.
46	zone_content_view_others	User is allowed to see the content and meta data of zones he does not own.
47	zone_content_edit_others	User is allowed to edit the content of zones he does not own.
48	zone_meta_edit_others	User is allowed to edit the meta data of zones he does not own.
49	search	User is allowed to perform searches.
50	supermaster_view	User is allowed to view supermasters.
51	supermaster_add	User is allowed to add new supermasters.
52	supermaster_edit	User is allowed to edit supermasters.
53	user_is_ueberuser	User has full access. God-like. Redeemer.
54	user_view_others	User is allowed to see other users and their details.
55	user_add_new	User is allowed to add new users.
56	user_edit_own	User is allowed to edit their own details.
57	user_edit_others	User is allowed to edit other users.
58	user_passwd_edit_others	User is allowed to edit the password of other users.
59	user_edit_templ_perm	User is allowed to change the permission template that is assigned to a user.
60	templ_perm_add	User is allowed to add new permission templates.
61	templ_perm_edit	User is allowed to edit existing permission templates.
\.


--
-- Data for Name: perm_templ; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.perm_templ (id, name, descr) FROM stdin;
1	Administrator	Administrator template with full rights.
\.


--
-- Data for Name: perm_templ_items; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.perm_templ_items (id, templ_id, perm_id) FROM stdin;
1	1	53
\.


--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.records (id, domain_id, name, type, content, ttl, prio, change_date, disabled, ordername, auth) FROM stdin;
\.


--
-- Data for Name: records_zone_templ; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.records_zone_templ (domain_id, record_id, zone_templ_id) FROM stdin;
\.


--
-- Data for Name: supermasters; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.supermasters (ip, nameserver, account) FROM stdin;
\.


--
-- Data for Name: tsigkeys; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.tsigkeys (id, name, algorithm, secret) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.users (id, username, password, fullname, email, description, perm_templ, active, use_ldap) FROM stdin;
1	admin	POWERADMIN_ADMIN_PASSWORD	Administrator	admin@example.net	Administrator with full rights.	1	1	0
\.


--
-- Data for Name: zone_templ; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.zone_templ (id, name, descr, owner) FROM stdin;
\.


--
-- Data for Name: zone_templ_records; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.zone_templ_records (id, zone_templ_id, name, type, content, ttl, prio) FROM stdin;
\.


--
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: powerdns
--

COPY public.zones (id, domain_id, owner, comment, zone_templ_id) FROM stdin;
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: cryptokeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.cryptokeys_id_seq', 1, false);


--
-- Name: domainmetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.domainmetadata_id_seq', 1, false);


--
-- Name: domains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.domains_id_seq', 1, false);


--
-- Name: perm_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.perm_items_id_seq', 1, false);


--
-- Name: perm_templ_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.perm_templ_id_seq', 1, true);


--
-- Name: perm_templ_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.perm_templ_items_id_seq', 1, true);


--
-- Name: records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.records_id_seq', 1, false);


--
-- Name: tsigkeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.tsigkeys_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: zone_templ_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.zone_templ_id_seq', 1, false);


--
-- Name: zone_templ_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.zone_templ_records_id_seq', 1, false);


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: powerdns
--

SELECT pg_catalog.setval('public.zones_id_seq', 1, false);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: cryptokeys cryptokeys_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.cryptokeys
    ADD CONSTRAINT cryptokeys_pkey PRIMARY KEY (id);


--
-- Name: domainmetadata domainmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.domainmetadata
    ADD CONSTRAINT domainmetadata_pkey PRIMARY KEY (id);


--
-- Name: domains domains_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.domains
    ADD CONSTRAINT domains_pkey PRIMARY KEY (id);


--
-- Name: perm_items perm_items_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.perm_items
    ADD CONSTRAINT perm_items_pkey PRIMARY KEY (id);


--
-- Name: perm_templ_items perm_templ_items_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.perm_templ_items
    ADD CONSTRAINT perm_templ_items_pkey PRIMARY KEY (id);


--
-- Name: perm_templ perm_templ_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.perm_templ
    ADD CONSTRAINT perm_templ_pkey PRIMARY KEY (id);


--
-- Name: records records_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT records_pkey PRIMARY KEY (id);


--
-- Name: supermasters supermasters_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.supermasters
    ADD CONSTRAINT supermasters_pkey PRIMARY KEY (ip, nameserver);


--
-- Name: tsigkeys tsigkeys_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.tsigkeys
    ADD CONSTRAINT tsigkeys_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: zone_templ zone_templ_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.zone_templ
    ADD CONSTRAINT zone_templ_pkey PRIMARY KEY (id);


--
-- Name: zone_templ_records zone_templ_records_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.zone_templ_records
    ADD CONSTRAINT zone_templ_records_pkey PRIMARY KEY (id);


--
-- Name: zones zones_pkey; Type: CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);


--
-- Name: comments_domain_id_idx; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE INDEX comments_domain_id_idx ON public.comments USING btree (domain_id);


--
-- Name: comments_name_type_idx; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE INDEX comments_name_type_idx ON public.comments USING btree (name, type);


--
-- Name: comments_order_idx; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE INDEX comments_order_idx ON public.comments USING btree (domain_id, modified_at);


--
-- Name: domain_id; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE INDEX domain_id ON public.records USING btree (domain_id);


--
-- Name: domainidindex; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE INDEX domainidindex ON public.cryptokeys USING btree (domain_id);


--
-- Name: domainidmetaindex; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE INDEX domainidmetaindex ON public.domainmetadata USING btree (domain_id);


--
-- Name: name_index; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE UNIQUE INDEX name_index ON public.domains USING btree (name);


--
-- Name: namealgoindex; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE UNIQUE INDEX namealgoindex ON public.tsigkeys USING btree (name, algorithm);


--
-- Name: nametype_index; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE INDEX nametype_index ON public.records USING btree (name, type);


--
-- Name: rec_name_index; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE INDEX rec_name_index ON public.records USING btree (name);


--
-- Name: recordorder; Type: INDEX; Schema: public; Owner: powerdns
--

CREATE INDEX recordorder ON public.records USING btree (domain_id, ordername text_pattern_ops);


--
-- Name: cryptokeys cryptokeys_domain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.cryptokeys
    ADD CONSTRAINT cryptokeys_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES public.domains(id) ON DELETE CASCADE;


--
-- Name: records domain_exists; Type: FK CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT domain_exists FOREIGN KEY (domain_id) REFERENCES public.domains(id) ON DELETE CASCADE;


--
-- Name: comments domain_exists; Type: FK CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT domain_exists FOREIGN KEY (domain_id) REFERENCES public.domains(id) ON DELETE CASCADE;


--
-- Name: domainmetadata domainmetadata_domain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: powerdns
--

ALTER TABLE ONLY public.domainmetadata
    ADD CONSTRAINT domainmetadata_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES public.domains(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

