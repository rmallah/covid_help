--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9 (Ubuntu 11.9-1.pgdg18.04+1)
-- Dumped by pg_dump version 12.3 (Debian 12.3-1.pgdg80+1)

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
-- Name: general; Type: SCHEMA; Schema: -; Owner: covidhelp_user
--

CREATE SCHEMA general;


ALTER SCHEMA general OWNER TO covidhelp_user;

SET default_tablespace = '';

--
-- Name: message_log; Type: TABLE; Schema: general; Owner: covidhelp_user
--

CREATE TABLE general.message_log (
    id integer NOT NULL,
    gateway_id character varying(255) NOT NULL,
    server_generated integer NOT NULL,
    generated integer DEFAULT date_part('epoch'::text, now()) NOT NULL,
    message_type character varying(20) NOT NULL,
    value text,
    text_value text,
    sender_id integer NOT NULL,
    message_id integer NOT NULL
);


ALTER TABLE general.message_log OWNER TO covidhelp_user;

--
-- Name: message_log_id_seq; Type: SEQUENCE; Schema: general; Owner: covidhelp_user
--

CREATE SEQUENCE general.message_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.message_log_id_seq OWNER TO covidhelp_user;

--
-- Name: message_log_id_seq; Type: SEQUENCE OWNED BY; Schema: general; Owner: covidhelp_user
--

ALTER SEQUENCE general.message_log_id_seq OWNED BY general.message_log.id;


--
-- Name: message_master; Type: TABLE; Schema: general; Owner: covidhelp_user
--

CREATE TABLE general.message_master (
    id integer NOT NULL,
    message text NOT NULL,
    message_signature character varying(255) NOT NULL,
    generated integer DEFAULT date_part('epoch'::text, now()) NOT NULL,
    first_reported integer NOT NULL,
    last_reported integer NOT NULL,
    report_count integer NOT NULL,
    message_type character varying(20) NOT NULL,
    votes integer DEFAULT 0 NOT NULL,
    verified_at timestamp(0) without time zone,
    last_updated timestamp(0) without time zone
);


ALTER TABLE general.message_master OWNER TO covidhelp_user;

--
-- Name: message_master_id_seq; Type: SEQUENCE; Schema: general; Owner: covidhelp_user
--

CREATE SEQUENCE general.message_master_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.message_master_id_seq OWNER TO covidhelp_user;

--
-- Name: message_master_id_seq; Type: SEQUENCE OWNED BY; Schema: general; Owner: covidhelp_user
--

ALTER SEQUENCE general.message_master_id_seq OWNED BY general.message_master.id;


--
-- Name: sender_master; Type: TABLE; Schema: general; Owner: covidhelp_user
--

CREATE TABLE general.sender_master (
    id integer NOT NULL,
    mobile character varying(20),
    generated integer DEFAULT date_part('epoch'::text, now()) NOT NULL
);


ALTER TABLE general.sender_master OWNER TO covidhelp_user;

--
-- Name: sender_master_id_seq; Type: SEQUENCE; Schema: general; Owner: covidhelp_user
--

CREATE SEQUENCE general.sender_master_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.sender_master_id_seq OWNER TO covidhelp_user;

--
-- Name: sender_master_id_seq; Type: SEQUENCE OWNED BY; Schema: general; Owner: covidhelp_user
--

ALTER SEQUENCE general.sender_master_id_seq OWNED BY general.sender_master.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: covidhelp_user
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.categories OWNER TO covidhelp_user;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: covidhelp_user
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO covidhelp_user;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: covidhelp_user
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: category_messages; Type: TABLE; Schema: public; Owner: covidhelp_user
--

CREATE TABLE public.category_messages (
    id bigint NOT NULL,
    message_id bigint NOT NULL,
    category_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.category_messages OWNER TO covidhelp_user;

--
-- Name: category_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: covidhelp_user
--

CREATE SEQUENCE public.category_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_messages_id_seq OWNER TO covidhelp_user;

--
-- Name: category_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: covidhelp_user
--

ALTER SEQUENCE public.category_messages_id_seq OWNED BY public.category_messages.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: covidhelp_user
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    message_id bigint NOT NULL,
    text character varying(255) NOT NULL,
    commentor character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.comments OWNER TO covidhelp_user;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: covidhelp_user
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO covidhelp_user;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: covidhelp_user
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: covidhelp_user
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO covidhelp_user;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: covidhelp_user
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO covidhelp_user;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: covidhelp_user
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: covidhelp_user
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO covidhelp_user;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: covidhelp_user
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO covidhelp_user;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: covidhelp_user
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: covidhelp_user
--

CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_resets OWNER TO covidhelp_user;

--
-- Name: users; Type: TABLE; Schema: public; Owner: covidhelp_user
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO covidhelp_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: covidhelp_user
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO covidhelp_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: covidhelp_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: message_log id; Type: DEFAULT; Schema: general; Owner: covidhelp_user
--

ALTER TABLE ONLY general.message_log ALTER COLUMN id SET DEFAULT nextval('general.message_log_id_seq'::regclass);


--
-- Name: message_master id; Type: DEFAULT; Schema: general; Owner: covidhelp_user
--

ALTER TABLE ONLY general.message_master ALTER COLUMN id SET DEFAULT nextval('general.message_master_id_seq'::regclass);


--
-- Name: sender_master id; Type: DEFAULT; Schema: general; Owner: covidhelp_user
--

ALTER TABLE ONLY general.sender_master ALTER COLUMN id SET DEFAULT nextval('general.sender_master_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: category_messages id; Type: DEFAULT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.category_messages ALTER COLUMN id SET DEFAULT nextval('public.category_messages_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: message_log message_log_pkey; Type: CONSTRAINT; Schema: general; Owner: covidhelp_user
--

ALTER TABLE ONLY general.message_log
    ADD CONSTRAINT message_log_pkey PRIMARY KEY (id);


--
-- Name: message_master message_master_pkey; Type: CONSTRAINT; Schema: general; Owner: covidhelp_user
--

ALTER TABLE ONLY general.message_master
    ADD CONSTRAINT message_master_pkey PRIMARY KEY (id);


--
-- Name: sender_master sender_master_mobile_key; Type: CONSTRAINT; Schema: general; Owner: covidhelp_user
--

ALTER TABLE ONLY general.sender_master
    ADD CONSTRAINT sender_master_mobile_key UNIQUE (mobile);


--
-- Name: sender_master sender_master_pkey; Type: CONSTRAINT; Schema: general; Owner: covidhelp_user
--

ALTER TABLE ONLY general.sender_master
    ADD CONSTRAINT sender_master_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: category_messages category_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.category_messages
    ADD CONSTRAINT category_messages_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: message_log_message_id; Type: INDEX; Schema: general; Owner: covidhelp_user
--

CREATE INDEX message_log_message_id ON general.message_log USING btree (message_id);


--
-- Name: message_log_sender_id; Type: INDEX; Schema: general; Owner: covidhelp_user
--

CREATE INDEX message_log_sender_id ON general.message_log USING btree (sender_id);


--
-- Name: message_master_sig; Type: INDEX; Schema: general; Owner: covidhelp_user
--

CREATE INDEX message_master_sig ON general.message_master USING btree (message_signature);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: covidhelp_user
--

CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);


--
-- Name: message_log message_log_message_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: covidhelp_user
--

ALTER TABLE ONLY general.message_log
    ADD CONSTRAINT message_log_message_id_fkey FOREIGN KEY (message_id) REFERENCES general.message_master(id);


--
-- Name: message_log message_log_sender_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: covidhelp_user
--

ALTER TABLE ONLY general.message_log
    ADD CONSTRAINT message_log_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES general.sender_master(id);


--
-- Name: comments comments_message_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: covidhelp_user
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_message_id_foreign FOREIGN KEY (message_id) REFERENCES general.message_master(id);


--
-- PostgreSQL database dump complete
--

