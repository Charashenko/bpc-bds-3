--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

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
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: add_last_change(); Type: FUNCTION; Schema: public; Owner: doma
--

CREATE FUNCTION public.add_last_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	if NEW.contact_type <> OLD.contact_type then
		update contact
		set last_change = current_timestamp
		where contact.contact_type = NEW.contact_type;
	end if;
	return NEW;
end
$$;


ALTER FUNCTION public.add_last_change() OWNER TO doma;

--
-- Name: add_thesis(character varying, character varying, integer); Type: PROCEDURE; Schema: public; Owner: doma
--

CREATE PROCEDURE public.add_thesis(thesis_name character varying, type_of_thesis character varying, author_id integer)
    LANGUAGE sql
    AS $$
insert into thesis (name, thesis_type, person_id) values (thesis_name, type_of_thesis, author_id);
$$;


ALTER PROCEDURE public.add_thesis(thesis_name character varying, type_of_thesis character varying, author_id integer) OWNER TO doma;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.address (
    address_id integer NOT NULL,
    state character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    street character varying(50) NOT NULL,
    house_number integer NOT NULL,
    postal_code integer NOT NULL
);


ALTER TABLE public.address OWNER TO doma;

--
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.address_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_address_id_seq OWNER TO doma;

--
-- Name: address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.address_address_id_seq OWNED BY public.address.address_id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO chara;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO chara;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO chara;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO chara;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO chara;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO chara;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO chara;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO chara;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO chara;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO chara;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO chara;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO chara;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: contact; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.contact (
    contact_id integer NOT NULL,
    person_id integer NOT NULL,
    contact_type character varying(20) NOT NULL,
    value character varying(50) NOT NULL,
    last_change timestamp without time zone
);


ALTER TABLE public.contact OWNER TO doma;

--
-- Name: contact_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.contact_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_contact_id_seq OWNER TO doma;

--
-- Name: contact_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.contact_contact_id_seq OWNED BY public.contact.contact_id;


--
-- Name: department; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.department (
    department_id integer NOT NULL,
    name character varying(50) NOT NULL,
    decription character varying(255)
);


ALTER TABLE public.department OWNER TO doma;

--
-- Name: department_department_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.department_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.department_department_id_seq OWNER TO doma;

--
-- Name: department_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.department_department_id_seq OWNED BY public.department.department_id;


--
-- Name: department_has_person; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.department_has_person (
    id integer NOT NULL,
    department_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.department_has_person OWNER TO doma;

--
-- Name: department_has_person_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.department_has_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.department_has_person_id_seq OWNER TO doma;

--
-- Name: department_has_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.department_has_person_id_seq OWNED BY public.department_has_person.id;


--
-- Name: department_has_program; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.department_has_program (
    id integer NOT NULL,
    department_id integer NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.department_has_program OWNER TO doma;

--
-- Name: department_has_program_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.department_has_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.department_has_program_id_seq OWNER TO doma;

--
-- Name: department_has_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.department_has_program_id_seq OWNED BY public.department_has_program.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO chara;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO chara;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO chara;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO chara;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO chara;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO chara;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO chara;

--
-- Name: faculty; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.faculty (
    faculty_id integer NOT NULL,
    name character varying(50) NOT NULL,
    address_id integer NOT NULL
);


ALTER TABLE public.faculty OWNER TO doma;

--
-- Name: faculty_faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.faculty_faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.faculty_faculty_id_seq OWNER TO doma;

--
-- Name: faculty_faculty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.faculty_faculty_id_seq OWNED BY public.faculty.faculty_id;


--
-- Name: faculty_has_department; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.faculty_has_department (
    id integer NOT NULL,
    faculty_id integer NOT NULL,
    department_id integer NOT NULL
);


ALTER TABLE public.faculty_has_department OWNER TO doma;

--
-- Name: faculty_has_department_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.faculty_has_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.faculty_has_department_id_seq OWNER TO doma;

--
-- Name: faculty_has_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.faculty_has_department_id_seq OWNED BY public.faculty_has_department.id;


--
-- Name: faculty_has_person; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.faculty_has_person (
    id integer NOT NULL,
    faculty_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.faculty_has_person OWNER TO doma;

--
-- Name: faculty_has_person_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.faculty_has_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.faculty_has_person_id_seq OWNER TO doma;

--
-- Name: faculty_has_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.faculty_has_person_id_seq OWNED BY public.faculty_has_person.id;


--
-- Name: person; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.person (
    person_id integer NOT NULL,
    name character varying(20) NOT NULL,
    surname character varying(20) NOT NULL,
    birthdate date NOT NULL,
    email character varying(50) NOT NULL,
    passwd character varying(255) NOT NULL,
    additional_note character varying(255)
);


ALTER TABLE public.person OWNER TO doma;

--
-- Name: mat_view_num_of_people_on_engineering_faculties; Type: MATERIALIZED VIEW; Schema: public; Owner: doma
--

CREATE MATERIALIZED VIEW public.mat_view_num_of_people_on_engineering_faculties AS
 SELECT f.name AS faculty,
    count(p.name) AS count_of_people
   FROM ((public.faculty f
     JOIN public.faculty_has_person fhp ON ((fhp.faculty_id = f.faculty_id)))
     JOIN public.person p ON ((p.person_id = fhp.person_id)))
  WHERE ((f.name)::text ~~ '%engineering'::text)
  GROUP BY f.name
  WITH NO DATA;


ALTER TABLE public.mat_view_num_of_people_on_engineering_faculties OWNER TO doma;

--
-- Name: person_has_address; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.person_has_address (
    id integer NOT NULL,
    person_id integer NOT NULL,
    address_id integer NOT NULL,
    address_type character varying(50)
);


ALTER TABLE public.person_has_address OWNER TO doma;

--
-- Name: person_has_address_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.person_has_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_has_address_id_seq OWNER TO doma;

--
-- Name: person_has_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.person_has_address_id_seq OWNED BY public.person_has_address.id;


--
-- Name: person_has_role; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.person_has_role (
    id integer NOT NULL,
    person_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.person_has_role OWNER TO doma;

--
-- Name: person_has_role_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.person_has_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_has_role_id_seq OWNER TO doma;

--
-- Name: person_has_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.person_has_role_id_seq OWNED BY public.person_has_role.id;


--
-- Name: person_has_subject; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.person_has_subject (
    id integer NOT NULL,
    person_id integer NOT NULL,
    subject_id integer NOT NULL
);


ALTER TABLE public.person_has_subject OWNER TO doma;

--
-- Name: person_has_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.person_has_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_has_subject_id_seq OWNER TO doma;

--
-- Name: person_has_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.person_has_subject_id_seq OWNED BY public.person_has_subject.id;


--
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.person_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_person_id_seq OWNER TO doma;

--
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.person_person_id_seq OWNED BY public.person.person_id;


--
-- Name: program_has_person; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.program_has_person (
    id integer NOT NULL,
    program_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.program_has_person OWNER TO doma;

--
-- Name: program_has_person_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.program_has_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_has_person_id_seq OWNER TO doma;

--
-- Name: program_has_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.program_has_person_id_seq OWNED BY public.program_has_person.id;


--
-- Name: program_has_subject; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.program_has_subject (
    id integer NOT NULL,
    program_id integer NOT NULL,
    subject_id integer NOT NULL
);


ALTER TABLE public.program_has_subject OWNER TO doma;

--
-- Name: program_has_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.program_has_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_has_subject_id_seq OWNER TO doma;

--
-- Name: program_has_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.program_has_subject_id_seq OWNED BY public.program_has_subject.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    role_type character varying(20) NOT NULL
);


ALTER TABLE public.role OWNER TO doma;

--
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_role_id_seq OWNER TO doma;

--
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;


--
-- Name: study_program; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.study_program (
    program_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.study_program OWNER TO doma;

--
-- Name: study_program_program_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.study_program_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.study_program_program_id_seq OWNER TO doma;

--
-- Name: study_program_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.study_program_program_id_seq OWNED BY public.study_program.program_id;


--
-- Name: subject; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.subject (
    subject_id integer NOT NULL,
    name character varying(50) NOT NULL,
    department_id integer NOT NULL,
    description character varying(255),
    prerequisites character varying(255),
    semester smallint NOT NULL,
    review smallint,
    additional_info character varying(255)
);


ALTER TABLE public.subject OWNER TO doma;

--
-- Name: subject_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.subject_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subject_subject_id_seq OWNER TO doma;

--
-- Name: subject_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.subject_subject_id_seq OWNED BY public.subject.subject_id;


--
-- Name: thesis; Type: TABLE; Schema: public; Owner: doma
--

CREATE TABLE public.thesis (
    thesis_id integer NOT NULL,
    name character varying(100) NOT NULL,
    thesis_type character varying(20) NOT NULL,
    description character varying(255),
    person_id integer NOT NULL
);


ALTER TABLE public.thesis OWNER TO doma;

--
-- Name: thesis_thesis_id_seq; Type: SEQUENCE; Schema: public; Owner: doma
--

CREATE SEQUENCE public.thesis_thesis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.thesis_thesis_id_seq OWNER TO doma;

--
-- Name: thesis_thesis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doma
--

ALTER SEQUENCE public.thesis_thesis_id_seq OWNED BY public.thesis.thesis_id;


--
-- Name: view_num_of_people_on_engineering_faculties; Type: VIEW; Schema: public; Owner: doma
--

CREATE VIEW public.view_num_of_people_on_engineering_faculties AS
 SELECT f.name AS faculty,
    count(p.name) AS count_of_people
   FROM ((public.faculty f
     JOIN public.faculty_has_person fhp ON ((fhp.faculty_id = f.faculty_id)))
     JOIN public.person p ON ((p.person_id = fhp.person_id)))
  WHERE ((f.name)::text ~~ '%engineering'::text)
  GROUP BY f.name;


ALTER TABLE public.view_num_of_people_on_engineering_faculties OWNER TO doma;

--
-- Name: web_person; Type: TABLE; Schema: public; Owner: chara
--

CREATE TABLE public.web_person (
    id bigint NOT NULL
);


ALTER TABLE public.web_person OWNER TO chara;

--
-- Name: web_person_id_seq; Type: SEQUENCE; Schema: public; Owner: chara
--

CREATE SEQUENCE public.web_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_person_id_seq OWNER TO chara;

--
-- Name: web_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chara
--

ALTER SEQUENCE public.web_person_id_seq OWNED BY public.web_person.id;


--
-- Name: address address_id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.address ALTER COLUMN address_id SET DEFAULT nextval('public.address_address_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: contact contact_id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.contact ALTER COLUMN contact_id SET DEFAULT nextval('public.contact_contact_id_seq'::regclass);


--
-- Name: department department_id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department ALTER COLUMN department_id SET DEFAULT nextval('public.department_department_id_seq'::regclass);


--
-- Name: department_has_person id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department_has_person ALTER COLUMN id SET DEFAULT nextval('public.department_has_person_id_seq'::regclass);


--
-- Name: department_has_program id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department_has_program ALTER COLUMN id SET DEFAULT nextval('public.department_has_program_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: faculty faculty_id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty ALTER COLUMN faculty_id SET DEFAULT nextval('public.faculty_faculty_id_seq'::regclass);


--
-- Name: faculty_has_department id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty_has_department ALTER COLUMN id SET DEFAULT nextval('public.faculty_has_department_id_seq'::regclass);


--
-- Name: faculty_has_person id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty_has_person ALTER COLUMN id SET DEFAULT nextval('public.faculty_has_person_id_seq'::regclass);


--
-- Name: person person_id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person ALTER COLUMN person_id SET DEFAULT nextval('public.person_person_id_seq'::regclass);


--
-- Name: person_has_address id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_address ALTER COLUMN id SET DEFAULT nextval('public.person_has_address_id_seq'::regclass);


--
-- Name: person_has_role id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_role ALTER COLUMN id SET DEFAULT nextval('public.person_has_role_id_seq'::regclass);


--
-- Name: person_has_subject id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_subject ALTER COLUMN id SET DEFAULT nextval('public.person_has_subject_id_seq'::regclass);


--
-- Name: program_has_person id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.program_has_person ALTER COLUMN id SET DEFAULT nextval('public.program_has_person_id_seq'::regclass);


--
-- Name: program_has_subject id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.program_has_subject ALTER COLUMN id SET DEFAULT nextval('public.program_has_subject_id_seq'::regclass);


--
-- Name: role role_id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- Name: study_program program_id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.study_program ALTER COLUMN program_id SET DEFAULT nextval('public.study_program_program_id_seq'::regclass);


--
-- Name: subject subject_id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.subject ALTER COLUMN subject_id SET DEFAULT nextval('public.subject_subject_id_seq'::regclass);


--
-- Name: thesis thesis_id; Type: DEFAULT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.thesis ALTER COLUMN thesis_id SET DEFAULT nextval('public.thesis_thesis_id_seq'::regclass);


--
-- Name: web_person id; Type: DEFAULT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.web_person ALTER COLUMN id SET DEFAULT nextval('public.web_person_id_seq'::regclass);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.address (address_id, state, city, street, house_number, postal_code) FROM stdin;
1	France	Fremont	Virginia Walk	153	90966
2	Vanuatu	Santa Ana	Camdale  Pass	145	37178
3	Peru	Rochester	Aspen Rue	185	69092
4	Austria	Omaha	Earl Rise Road	170	15265
5	Azerbaijan	Rochester	Bayberry Drive	333	16707
6	Palau	Las Vegas	Bond Street	414	38701
7	Comoros	Jersey City	Cavendish Alley	107	85839
8	Chad	Moreno Valley	Bective  Vale	115	25165
9	Djibouti	Fremont	Balfe   Boulevard	499	84982
10	Canada	Sacramento	Arthur  Way	286	20294
11	Armenia	Oklahoma City	Bell    Tunnel	345	38966
12	Angola	Scottsdale	Apothecary   Avenue	72	20988
13	Saint Vincent and the Grenadines	Colorado Springs	Gate   Walk	222	62941
14	Micronesia	Tokyo	Church Route	440	13554
15	Côte d’Ivoire	Jacksonville	North Vale	3	25070
16	Sri Lanka	Berlin	Erindale Route	365	73550
17	Burkina Faso	Garland	Rivervalley Way	421	68103
18	Libya	Tulsa	South Vale	77	29517
19	Spain	San Jose	Meadow Rue	239	57978
20	Central African Republic	Lisbon	Under  Alley	221	92601
21	Vatican City	Bellevue	Clifton  Street	249	31525
22	Kyrgyzstan	Moreno Valley	Catherine  Way	38	23721
23	Iran	Atlanta	Clarks  Boulevard	276	39883
24	Senegal	Pittsburgh	Carolina  Pass	333	65234
25	Qatar	Long Beach	Camelot   Vale	122	74157
26	Djibouti	Fremont	Aspen Vale	132	71056
27	Seychelles	Columbus	Catherine  Tunnel	343	46480
28	Antigua and Barbuda	Detroit	Lincoln Alley	87	97841
29	Pakistan	Glendale	Abbotswell  Boulevard	264	78319
30	Romania	Saint Paul	Gautrey  Drive	123	25136
31	Ireland	St. Louis	Parkfield  Boulevard	281	50245
32	United Kingdom	London	Belmont Park Avenue	123	95518
33	Iraq	Nashville	Kinglake  Street	293	84089
34	Romania	Honolulu	Oxford Grove	403	46680
35	Zimbabwe	Colorado Springs	Railroad Alley	422	70102
36	Guinea	Salt Lake City	Belgrave  Crossroad	215	44187
37	Swaziland	Portland	Geffrye   Crossroad	380	81327
38	Finland	Hayward	Bekesbourne   Avenue	7	29106
39	Belarus	Toledo	Chatsworth  Rue	333	42334
40	Norway	San Francisco	Vine  Alley	45	80385
41	Ecuador	Boston	Castile  Hill	169	22859
42	South Africa	San Jose	Gatonby   Way	156	78364
43	Turkey	Springfield	Bell    Route	356	99284
44	Côte d’Ivoire	Los Angeles	Camden  Lane	164	78540
45	Lebanon	Oklahoma City	Monroe Drive	434	16540
46	United Arab Emirates	Baltimore	Thrale   Avenue	261	59283
47	Montenegro	Laredo	Lake Grove	460	65322
48	Suriname	Denver	Berry  Tunnel	65	31688
49	Colombia	Bridgeport	Abourne   Avenue	139	42205
50	Norway	Orlando	Chantry   Walk	455	84691
51	Poland	Saint Paul	Bellenden   Walk	369	55873
52	Vietnam	Tokyo	Adderley   Hill	53	58781
53	Tunisia	Seattle	Rail Vale	280	26881
54	Sao Tome and Principe	Valetta	Charnwood   Street	382	29828
55	Sudan	Seattle	Bayberry Route	241	15906
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add address	1	add_address
2	Can change address	1	change_address
3	Can delete address	1	delete_address
4	Can view address	1	view_address
5	Can add contact	2	add_contact
6	Can change contact	2	change_contact
7	Can delete contact	2	delete_contact
8	Can view contact	2	view_contact
9	Can add department	3	add_department
10	Can change department	3	change_department
11	Can delete department	3	delete_department
12	Can view department	3	view_department
13	Can add department has person	4	add_departmenthasperson
14	Can change department has person	4	change_departmenthasperson
15	Can delete department has person	4	delete_departmenthasperson
16	Can view department has person	4	view_departmenthasperson
17	Can add department has program	5	add_departmenthasprogram
18	Can change department has program	5	change_departmenthasprogram
19	Can delete department has program	5	delete_departmenthasprogram
20	Can view department has program	5	view_departmenthasprogram
21	Can add faculty	6	add_faculty
22	Can change faculty	6	change_faculty
23	Can delete faculty	6	delete_faculty
24	Can view faculty	6	view_faculty
25	Can add faculty has department	7	add_facultyhasdepartment
26	Can change faculty has department	7	change_facultyhasdepartment
27	Can delete faculty has department	7	delete_facultyhasdepartment
28	Can view faculty has department	7	view_facultyhasdepartment
29	Can add faculty has person	8	add_facultyhasperson
30	Can change faculty has person	8	change_facultyhasperson
31	Can delete faculty has person	8	delete_facultyhasperson
32	Can view faculty has person	8	view_facultyhasperson
33	Can add person	9	add_person
34	Can change person	9	change_person
35	Can delete person	9	delete_person
36	Can view person	9	view_person
37	Can add person has address	10	add_personhasaddress
38	Can change person has address	10	change_personhasaddress
39	Can delete person has address	10	delete_personhasaddress
40	Can view person has address	10	view_personhasaddress
41	Can add person has subject	11	add_personhassubject
42	Can change person has subject	11	change_personhassubject
43	Can delete person has subject	11	delete_personhassubject
44	Can view person has subject	11	view_personhassubject
45	Can add program has person	12	add_programhasperson
46	Can change program has person	12	change_programhasperson
47	Can delete program has person	12	delete_programhasperson
48	Can view program has person	12	view_programhasperson
49	Can add program has subject	13	add_programhassubject
50	Can change program has subject	13	change_programhassubject
51	Can delete program has subject	13	delete_programhassubject
52	Can view program has subject	13	view_programhassubject
53	Can add role	14	add_role
54	Can change role	14	change_role
55	Can delete role	14	delete_role
56	Can view role	14	view_role
57	Can add study program	15	add_studyprogram
58	Can change study program	15	change_studyprogram
59	Can delete study program	15	delete_studyprogram
60	Can view study program	15	view_studyprogram
61	Can add subject	16	add_subject
62	Can change subject	16	change_subject
63	Can delete subject	16	delete_subject
64	Can view subject	16	view_subject
65	Can add thesis	17	add_thesis
66	Can change thesis	17	change_thesis
67	Can delete thesis	17	delete_thesis
68	Can view thesis	17	view_thesis
69	Can add person has role	18	add_personhasrole
70	Can change person has role	18	change_personhasrole
71	Can delete person has role	18	delete_personhasrole
72	Can view person has role	18	view_personhasrole
73	Can add log entry	19	add_logentry
74	Can change log entry	19	change_logentry
75	Can delete log entry	19	delete_logentry
76	Can view log entry	19	view_logentry
77	Can add permission	20	add_permission
78	Can change permission	20	change_permission
79	Can delete permission	20	delete_permission
80	Can view permission	20	view_permission
81	Can add group	21	add_group
82	Can change group	21	change_group
83	Can delete group	21	delete_group
84	Can view group	21	view_group
85	Can add user	22	add_user
86	Can change user	22	change_user
87	Can delete user	22	delete_user
88	Can view user	22	view_user
89	Can add content type	23	add_contenttype
90	Can change content type	23	change_contenttype
91	Can delete content type	23	delete_contenttype
92	Can view content type	23	view_contenttype
93	Can add session	24	add_session
94	Can change session	24	change_session
95	Can delete session	24	delete_session
96	Can view session	24	view_session
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$320000$qRjcy8ry3qSt6T6tgybinc$5j0vpGxozzzM4pPgWgZEz6xNM8m81CNGOF/5iogGtw0=	2021-12-18 16:17:48.172406+01	t	admin				t	t	2021-12-07 15:44:16.119517+01
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.contact (contact_id, person_id, contact_type, value, last_change) FROM stdin;
1	1	mobile	2-826-508-2062	2021-12-06 20:49:51.929659
2	2	fax	07987-374	2021-12-06 20:49:51.932134
3	3	mobile	4-444-868-5336	2021-12-06 20:49:51.93421
4	4	twitter	Buster78	2021-12-06 20:49:51.936216
5	5	mobile	4-081-472-0776	2021-12-06 20:49:51.938282
6	6	mobile	7-362-012-3338	2021-12-06 20:49:51.940455
7	7	mobile	2-771-033-4487	2021-12-06 20:49:51.942607
8	8	mobile	2-835-611-2247	2021-12-06 20:49:51.944513
9	9	mobile	1-008-780-5527	\N
10	10	mobile	5-612-368-5337	\N
11	11	mobile	8-077-431-1013	\N
12	12	mobile	3-560-154-4735	\N
13	13	mobile	4-363-473-3514	\N
14	14	mobile	2-180-845-4316	\N
15	15	mobile	1-244-252-1744	\N
16	16	mobile	2-540-083-6542	\N
17	17	mobile	8-250-058-7383	\N
18	18	mobile	6-147-847-1328	\N
19	19	mobile	7-735-736-0541	\N
20	20	mobile	7-228-145-1014	\N
21	21	mobile	8-725-287-8418	\N
22	22	mobile	8-476-465-1238	\N
23	23	mobile	5-315-033-5127	\N
24	24	mobile	2-842-216-2500	\N
25	25	mobile	8-360-387-4771	\N
26	26	mobile	0-284-583-5785	\N
27	27	mobile	0-172-244-3067	\N
28	28	mobile	5-367-883-6530	\N
29	29	mobile	1-823-646-7011	\N
30	30	mobile	2-251-162-0373	\N
31	31	mobile	1-646-604-1122	\N
32	32	mobile	0-880-870-6155	\N
33	33	mobile	4-142-665-3502	\N
34	34	mobile	7-657-866-3707	\N
35	35	mobile	0-162-174-0656	\N
36	36	mobile	5-232-436-5651	\N
37	37	mobile	7-124-072-8764	\N
38	38	mobile	5-124-456-8525	\N
39	39	mobile	0-034-623-5222	\N
40	40	mobile	7-358-676-7670	\N
41	41	mobile	0-518-881-7708	\N
42	42	mobile	1-011-508-5142	\N
43	43	mobile	3-288-478-2746	\N
44	44	mobile	0-862-724-4441	\N
45	45	mobile	7-147-515-7064	\N
46	46	mobile	7-280-042-7423	\N
47	47	mobile	3-013-216-1586	\N
48	48	mobile	1-363-526-5840	\N
49	49	mobile	4-033-710-2588	\N
50	50	mobile	4-745-173-0804	\N
51	51	mobile	1-143-578-1828	\N
52	52	mobile	3-400-834-1336	\N
53	53	mobile	1-878-817-2840	\N
54	54	mobile	8-817-451-2406	\N
55	55	mobile	4-484-188-5651	\N
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.department (department_id, name, decription) FROM stdin;
1	Department of telecommunications	\N
2	Department of IT infrastructure	\N
3	Department of mathematics	\N
4	Department of physical engineering	\N
5	Department of energetics	\N
6	Department of foreign languages	\N
7	Department of materials science	\N
8	Department of physical and applied chemistry	\N
9	Archeologic department	\N
10	Department of drawing and graphics	\N
11	Department of photography	\N
12	Department of 3D technology	\N
\.


--
-- Data for Name: department_has_person; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.department_has_person (id, department_id, person_id) FROM stdin;
1	1	13
2	2	14
3	3	15
4	4	16
5	5	17
6	6	18
7	7	19
8	8	20
9	9	21
10	10	22
11	11	23
12	12	24
13	1	25
14	2	26
15	3	27
16	4	28
17	5	29
18	6	30
19	7	31
20	8	32
21	9	33
22	10	34
23	11	35
24	12	36
25	1	37
26	2	38
27	3	39
28	4	40
29	5	41
30	6	42
31	7	43
32	8	44
33	9	45
34	10	46
35	11	47
36	12	48
37	1	49
38	2	50
39	3	51
40	4	52
41	5	53
42	6	54
43	7	55
57	7	1
58	3	62
\.


--
-- Data for Name: department_has_program; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.department_has_program (id, department_id, program_id) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	5
6	6	1
7	7	2
8	8	3
9	9	4
10	10	5
11	11	1
12	12	2
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	web	address
2	web	contact
3	web	department
4	web	departmenthasperson
5	web	departmenthasprogram
6	web	faculty
7	web	facultyhasdepartment
8	web	facultyhasperson
9	web	person
10	web	personhasaddress
11	web	personhassubject
12	web	programhasperson
13	web	programhassubject
14	web	role
15	web	studyprogram
16	web	subject
17	web	thesis
18	web	personhasrole
19	admin	logentry
20	auth	permission
21	auth	group
22	auth	user
23	contenttypes	contenttype
24	sessions	session
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-12-06 21:02:37.82565+01
2	auth	0001_initial	2021-12-06 21:02:38.021862+01
3	admin	0001_initial	2021-12-06 21:02:38.081091+01
4	admin	0002_logentry_remove_auto_add	2021-12-06 21:02:38.09612+01
5	admin	0003_logentry_add_action_flag_choices	2021-12-06 21:02:38.120694+01
6	contenttypes	0002_remove_content_type_name	2021-12-06 21:02:38.160008+01
7	auth	0002_alter_permission_name_max_length	2021-12-06 21:02:38.18841+01
8	auth	0003_alter_user_email_max_length	2021-12-06 21:02:38.211618+01
9	auth	0004_alter_user_username_opts	2021-12-06 21:02:38.237808+01
10	auth	0005_alter_user_last_login_null	2021-12-06 21:02:38.25845+01
11	auth	0006_require_contenttypes_0002	2021-12-06 21:02:38.265503+01
12	auth	0007_alter_validators_add_error_messages	2021-12-06 21:02:38.292238+01
13	auth	0008_alter_user_username_max_length	2021-12-06 21:02:38.336336+01
14	auth	0009_alter_user_last_name_max_length	2021-12-06 21:02:38.361044+01
15	auth	0010_alter_group_name_max_length	2021-12-06 21:02:38.404895+01
16	auth	0011_update_proxy_permissions	2021-12-06 21:02:38.429106+01
17	auth	0012_alter_user_first_name_max_length	2021-12-06 21:02:38.464788+01
18	sessions	0001_initial	2021-12-06 21:02:38.504689+01
19	web	0001_initial	2021-12-06 21:02:38.526255+01
20	web	0002_auto_20211130_1025	2021-12-06 21:02:38.564817+01
21	web	0003_alter_person_table	2021-12-06 21:02:38.570927+01
22	web	0004_auto_20211204_2048	2021-12-06 21:02:38.58411+01
23	web	0005_address_contact_department_departmenthasperson_departmenthasprogram_faculty_facultyhasdepartment_fac	2021-12-06 21:02:38.601285+01
24	web	0006_alter_personhasrole_options	2021-12-06 21:02:38.607476+01
25	web	0007_alter_facultyhasperson_options	2021-12-13 21:24:08.620319+01
26	web	0008_alter_facultyhasperson_options	2021-12-13 21:24:08.636557+01
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
9rbrejkziq1fx77yvs14l1mi8m71l7nm	eyJ1c3JfaWQiOlsyLCJSeWFuIixbInN5c2FkbWluIiwic3R1ZGVudCJdXX0:1muKce:COEW_C1FKsEp7QCA0Cn7pGy0YXSqzGvTbAq5bjJ9anI	2021-12-20 21:30:04.641431+01
4i7x3qc5q7ovv4hqcl74dd97mfi72vnd	e30:1mygQA:L_eyAZBV92iKlB-t-9-ySODM8GFKIqbZpZRyNiRMG8Q	2022-01-01 21:35:10.357291+01
omdc4ncnnk36jfuw2fjfjx3y4vkiil8s	eyJ1c3JfaW5mbyI6WzMwLCJKb2huIixbInN0dWRlbnQiXV19:1mv6wZ:KY8ysaWjSldfPelkzbH4EhY0vxKmXWw8hYa3KENxxG0	2021-12-23 01:05:51.208201+01
w3qp61rfawekktthkaazkx7b2piobrrd	eyJ1c3JfaW5mbyI6WzIsIlJ5YW4iLFsic3lzYWRtaW4iLCJzdHVkZW50Il1dfQ:1mwVAz:x0D_ByL4SBXTExOQurMnhvq3PahPn6B7FHOoHNKwh7U	2021-12-26 21:10:29.813415+01
w1a4grw62kkscj92mar2r4uu0pmnylbi	eyJ1c3JJbmZvIjpbMiwiUnlhbiIsWyJzeXNhZG1pbiJdXX0:1myD4e:o01lQobFqgzEXz3Qf7up-glWDzKMgxhPew3-2TR0bbc	2021-12-31 14:15:00.107029+01
fhb29epe7ib6e4ruvlt51milm30ku0zx	.eJyNjrsOgzAUQ__lzgglhBDSsXuXrgihm1ehj0QiyYCq_ntBZWi3bpZ9bPkJA-Y0DjnaeZgMHIBC8e0p1Dfrt8Bc0V9CqYNP86TKDSn3NJanYOz9uLM_AyPGcW03FRItXa05oVhRpSUTxilj27rhjJlWWUcd4Y4JjpRZFI5IwSmKhhOp2nU0x8_FrirgvKCHooO4RDSPadUQUzbWJ-j7HfUu_AG_3gsmVQY:1mufkN:v12bGwhIQuuG6sQlYsHw5DLf2HvJq7Tn9sp2Qt2NJQ4	2021-12-21 20:03:27.545045+01
22s62ehqnwp0fc9h9sw0gpzta1o1l4sy	.eJyrViotLorPzEvLV7KKNtJRCqpMzFPSiVYqrixOTMnNBLKViktKU1LzSpRiY3VAij2JU1sLAF6XHmI:1mwsKh:VWH_QEB4QU7IZjsUXrJGTA6dXmqxkXbnFtx6mxDFvwA	2021-12-27 21:54:03.554991+01
fvpcb1t9bdqn6h2c32ye5nz3h9y2xy17	eyJ1c3JJbmZvIjpbMiwiUnlhbiIsWyJzeXNhZG1pbiIsImhlYWQgb2YgZGVwYXJ0bWVudCIsImd1YXJhbnRvciJdXX0:1mx9EV:0-4kRfIj7YvKVxDAO0aDoVa2AvPRnbPIA01_4NL4cRI	2021-12-28 15:56:47.518622+01
\.


--
-- Data for Name: faculty; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.faculty (faculty_id, name, address_id) FROM stdin;
1	Faculty of electrical engineering	1
2	Faculty of computer science	2
3	Faculty of history	5
4	Faculty of chemistry	7
5	Faculty of art	12
6	Faculty of mechanical engineering	17
\.


--
-- Data for Name: faculty_has_department; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.faculty_has_department (id, faculty_id, department_id) FROM stdin;
1	1	1
2	2	2
3	3	9
4	4	8
5	5	10
6	6	4
\.


--
-- Data for Name: faculty_has_person; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.faculty_has_person (id, faculty_id, person_id) FROM stdin;
2	2	2
3	3	3
4	4	4
5	5	5
6	6	6
7	1	7
8	2	8
9	3	9
10	4	10
11	5	11
12	6	12
13	1	13
14	2	14
15	3	15
16	4	16
17	5	17
18	6	18
19	1	19
20	2	20
21	3	21
22	4	22
23	5	23
24	6	24
25	1	25
26	2	26
27	3	27
28	4	28
29	5	29
30	6	30
31	1	31
32	2	32
33	3	33
34	4	34
35	5	35
36	6	36
37	1	37
38	2	38
39	3	39
40	4	40
41	5	41
42	6	42
43	1	43
44	2	44
45	3	45
46	4	46
47	5	47
48	6	48
49	1	49
50	2	50
51	3	51
52	4	52
53	5	53
54	6	54
55	1	55
88	4	1
89	1	62
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.person (person_id, name, surname, birthdate, email, passwd, additional_note) FROM stdin;
30	John	Bishop	1996-04-25	John_Bishop1320982090@womeona.net	$2b$12$9.CnTX68FiOBXBG8iD/JbuDdGmxSvTKW0BpHR4rS1wOQabBOaztF6	None
3	Fred	Jones	1998-01-28	Fred_Jones362999224@naiker.biz	$2b$12$oNvkmtHNQMk8MSfcjqYvqe/4.CvMD1sMGVrUQHEhhZqwCTaZAaEiK	\N
4	Ramon	Woods	1993-07-05	Ramon_Woods701622638@vetan.org	$2b$12$H6QE3pArp6ZoQrtK70hKBOwf0dxj8LLeQEVwz7m.d2Q1CBMA0dryS	\N
5	Tyson	Vangness	1997-05-27	Tyson_Vangness1856458352@sheye.org	$2b$12$g5kC7aBZeHV2HnEf0N2gKekc03QgkJsB6lnW8hEaguRqlsIAEn8yu	\N
6	Bob	Crawford	2001-10-27	Bob_Crawford1279852887@nanoff.biz	$2b$12$XQlFbCym2Ou7WO4pSz2I2Obibdb/X.LZJ7yG/kbS7gOr4m2cxqPn6	\N
7	Rufus	Clark	2000-02-05	Rufus_Clark124391231@vetan.org	$2b$12$ewrCz1za44nsY3VhxKFjquLW5/2WpwnUYqGFkGJwWG/Zaxn6uYYMy	\N
8	Wade	Payne	1981-12-05	Wade_Payne772693815@supunk.biz	$2b$12$u21beS5YVysN/1ogBB36q.sL.IYGLqIiy82.pdnMfC8LBpOVodRqe	\N
9	George	Lucas	1975-01-04	George_Lucas316934623@iatim.tech	$2b$12$TJQUzFoWuSgjMxis1N9TPeZJiNcLoNHhrUZJYPZVXfOO5QBGITKGW	\N
10	Aiden	Cooper	1975-11-20	Aiden_Cooper1390057682@hourpy.biz	$2b$12$yG9AcaOK8PIZEI.yAYEkRupdzvr6CwUM.rXd/BIjN7dtQyhRCc.jG	\N
11	Nate	Noon	1991-10-09	Nate_Noon486947198@muall.tech	$2b$12$26NhMuHnI92PqPa6WQSA/u1MourQRx0PYXrWhuZm94otJxi373rHK	\N
12	Joseph	Andrews	1976-03-14	Joseph_Andrews761708542@yahoo.com	$2b$12$PpP/LwY/j/8wUwJnxo41O.isYwk9JEqBT8mYzrY/tiilcznTyEaLO	\N
13	Bryon	Atkinson	1977-05-02	Bryon_Atkinson138529995@grannar.com	$2b$12$OIA1OVGOWeuMOyz9HM30AOixC9qO.nfDjBFFdRiUrGQIjkz0GjRXm	\N
14	Benjamin	Price	1970-11-30	Benjamin_Price538271930@fuliss.net	$2b$12$cSec4AY0A55jxgHYee7p3eY799SgHqar1Roww.ySF/8wtCx2WpOaq	\N
15	George	Gray	1998-12-19	George_Gray282218499@supunk.biz	$2b$12$2l/WAQPhVIx2M4tzDdcNEuataAMXQwGvpSlRK6Qxg6N1tE.Pjphx.	\N
16	Luke	Abbey	1982-08-19	Luke_Abbey1926073738@bretoux.com	$2b$12$CbF/4SY0VDZasGsGf.UUFeWaF6XlDOXQFamET/9eVZSlR9S5jNRtm	\N
17	Ryan	Veale	2001-10-15	Ryan_Veale2137267434@vetan.org	$2b$12$rYXFnZxh6JBhOS7owgFEsetqGZ4zHMzBq2AY/vFj1WkUlVBV5mShW	\N
18	Wade	Bristow	1977-10-24	Wade_Bristow200554096@naiker.biz	$2b$12$4PNpFRj3/n0OwFzempepK.0njk5rkqNfesk8xZg5lb6MLB3YRUkb6	\N
19	Aiden	Hall	1971-04-17	Aiden_Hall1877594525@muall.tech	$2b$12$XLen6.7VX4YXufx02VpjCut5.9HICyirdsEdrGsw31G7cSyFj1g.C	\N
46	Johnathan	Alldridge	1984-03-30	Johnathan_Alldridge1519286137@tonsy.org	$2b$12$8AKauIAAjWV200i.ap5Pt.bU5wUNWqr3vdncKM13oaJDYHaLgB7xm	None
21	Abdul	Tindall	1978-01-20	Abdul_Tindall782575410@bulaffy.com	$2b$12$vdrT5MTg7KIpqCOyigvNCu3/JjVQrFavVWljVTWrssmf2umZD5CfS	\N
22	Harvey	Richards	1998-01-15	Harvey_Richards1659380082@joiniaa.com	$2b$12$qF9WD5zFBin.TwkICxO89OcgsJrjn5spjO3dX6KgPo0nGsm5d/OZO	\N
23	Carl	Attwood	1981-12-20	Carl_Attwood688732872@naiker.biz	$2b$12$974A5Zfly2tbUq7nr3FF3ufwgLiBn/lp/EYDLW4fBftjHuOrYcgsW	\N
24	Brad	Wood	1985-08-28	Brad_Wood814417396@ubusive.com	$2b$12$0sLyFF56eK5/S6I9/t.8ouWDrkWMAC7FyR2rkz6ZbIMA51gqaeZL.	\N
25	Luke	Vincent	1976-10-26	Luke_Vincent1117664115@famism.biz	$2b$12$PIOB19Lh1qVwL9W2iIzsseL8poyQ9TOWJD8qB/fGkMIVw9ylmSUSK	\N
26	Percy	Andrews	1971-06-13	Percy_Andrews1044864817@zorer.org	$2b$12$c85Sw..jcvHLY8K4Rr8oGOUq.s2KCje4qpm5w.uyyuZNiy5KDRKHi	\N
27	Denis	Raven	2000-04-23	Denis_Raven1493431461@deons.tech	$2b$12$9BHFGIa7bGo6lN4KEYtL8Oy1gbKnyK1WZ.VPVyi1DvUjJaLqDEC/u	\N
28	Alan	Mason	1981-03-09	Alan_Mason25623827@acrit.org	$2b$12$KIFU2Uzy0p/FHSGbJ7UBF.YW4u.RNb2ipYNSpZV1293HzHGTfjMT6	\N
29	Nicholas	Lewis	1980-10-03	Nicholas_Lewis429650077@gembat.biz	$2b$12$zXigBN5ljxgkA6fVBwNfKuiorW7HANXQUgCUOJ2iygA/aWpTGVlVW	\N
31	William	Sherry	1990-04-06	William_Sherry547328070@twipet.com	$2b$12$I0zdhJF1mOWegThc2hb3/e.PbBjaBqMI9YyqVFM8PyaUByhPDL/We	\N
32	Daniel	Oldfield	2001-10-14	Daniel_Oldfield585588482@nanoff.biz	$2b$12$4s6NmXhWL.tVOhTORbq7s.orjB5fte11Jnh5hQ6FNzuSL4scprfKG	\N
33	Gil	Grady	1995-02-08	Gil_Grady851255681@elnee.tech	$2b$12$YjP5bLcDRT/RVmy.8RyZh.DJvAxURVbMCTcjTaT1fbzEmAF/EFW8O	\N
34	Chad	Malone	1997-02-20	Chad_Malone1270895326@extex.org	$2b$12$IDn2I/F600796MZMMdf5VOibWJe3h9XiBc54AzmG5Y1s6Kt/yVHL2	\N
35	Liam	Faulkner	1994-07-07	Liam_Faulkner746335306@twipet.com	$2b$12$gGoM3bkydN5lWJQCeeFCde1NN58mDFxZ/qekO2eA7kjUVw509KK2m	\N
36	Nathan	Seymour	1991-04-16	Nathan_Seymour825832003@grannar.com	$2b$12$vwZ4RS6Vflkk/E8/R2e97OcclPvuTglScKLhei1OPVQ2yx.vIfvci	\N
37	Bob	Warren	1971-07-31	Bob_Warren1503826486@typill.biz	$2b$12$ziv/1WOdt2EK/kxSMd0XneMTVcM7G8UVCn7ki25D03w0s.uSLQEVC	\N
38	Rick	Reese	1970-04-06	Rick_Reese1572709925@joiniaa.com	$2b$12$pVXZDdMaxa9xuJtkt76hlOIUd2qmva8OCIG9hIJv/q2snwW86yo8q	\N
39	Ronald	Styles	1982-06-01	Ronald_Styles260125551@fuliss.net	$2b$12$YVS5nxLMJTmCwikS47wdPeFp4N90uwEkcr6qBRZxZr.8YMWHCGLy6	\N
40	Peter	Pierce	1972-08-20	Peter_Pierce727859747@famism.biz	$2b$12$xs8gLX7IOvyiZKtUPN9cQ.SV13gRdngiqZOyTVEu.EwrdCAOTLgii	\N
41	Ron	Dyson	1996-10-26	Ron_Dyson385675309@brety.org	$2b$12$ToKok6UbXn90W7UJRm0rZ.BsAi.FHKYjjGaY/Y7NpIOXIS2U0iZRq	\N
42	Eduardo	Attwood	1989-01-08	Eduardo_Attwood601086599@gmail.com	$2b$12$0myhfk9peKZkQFyeOrhz3O9UjcjncdM0KTPO7h7XA9pIxHBQwdpXu	\N
43	Chester	Rixon	1973-07-16	Chester_Rixon1339338449@liret.org	$2b$12$LTHfSk.AB64lHJQZMSbqmuNVrU8i6jdel8ebNo46TMVRCR240UsWS	\N
44	Julius	Tobin	1999-07-31	Julius_Tobin492608468@famism.biz	$2b$12$haYBUo.OBcyEseukYzXxsuhpFP9tkq/JiEiXMncjsL7B.8KacfSna	\N
45	Russel	Bryson	1994-08-14	Russel_Bryson1612974992@tonsy.org	$2b$12$vyPCR3y08EozqEBTPr31kOJdu.NouUgeaEdPyqC4wEd4dvzrWM6xe	\N
20	Elijah	Canndas	1979-06-25	Elijah_Cann2142940593@nickia.com	$2b$12$Hyb//0tstIcnpS1fLfo9neYlONXkFT25DeXG0EfS4ZiU5P21EO0Ee	None
47	Chuck	Kelly	1997-06-24	Chuck_Kelly105646192@corti.com	$2b$12$7SMgOl3O5w7TGil6vcyiouemd.zKFoWalK567RraGof9HmT.USkOu	\N
48	Benjamin	Fleming	1986-02-17	Benjamin_Fleming2019060524@hourpy.biz	$2b$12$4P3E.kjHegJ9BMXilFfR8evdhiefLvj0UTI2CvZR9yDRD6ssi1gb6	\N
49	Barry	Nash	1970-12-15	Barry_Nash635413811@bungar.biz	$2b$12$vTdiTnWZA5hml0L4ZTsyJ.iM8YNRre9oAK6hSQVyRwBxsNzZfrCue	\N
50	Mark	Collins	1980-12-30	Mark_Collins255902477@eirey.tech	$2b$12$windu892hTqSjnBnBj9UreAjnV9bl.TCXffctV7UXJ5ihnHKtDFQG	\N
51	Alan	Stanley	1999-05-18	Alan_Stanley1432540354@twace.org	$2b$12$zHV5sRxFOF8CS00OpVrafupyS7BG6/IvuxMoyxsNeL3XsTv72Hbii	\N
52	Alan	Cooper	2001-12-18	Alan_Cooper442467911@corti.com	$2b$12$ANL6AFeibruUX/I9rxZoA.ECH6EEVXz.oglvqcUwYZU.JNJ7t26uW	\N
53	Bryon	Preston	1999-11-11	Bryon_Preston999633791@bauros.biz	$2b$12$WAM6NWEaZe1p7YWV0SmAfuIJkaA63rLCZ8VicyUAFE3X.GnJsM/Vu	\N
2	Ryan	Hooper	1988-11-09	rhooper@mail.com	$2b$12$23JDOVswgAkOi2dzzYZTvufSoGGY6rxg0siGFs7rFSFKGT3brDoPu	a test guy
54	Bart	Ross	1970-08-03	Bart_Ross967059599@deavo.com	$2b$12$JSzefWJtpYRLYQqqSGc4I.9GSHgwmN8J9CrMUNKzfvBB5rRsUmGsi	\N
57	Martin	Novák	1985-05-24	mnovak@seznam.cz	$2b$12$gjES4qXnSV7DztER3T/0H.0pI5OXI3fzAB36r6UShQj/KC6uMxd3W	\N
55	Daron	Taylor	1970-02-06	daron.taylor@gmail.com	$2b$12$kYjVvqHs0yP6OCeEpbjLQ.6Myg54WGiZn7wHCLUqDWqkQvTOfxCzW	None
1	Alan	Flack	1971-12-05	Alan_Flack1265254390@liret.org	$2b$12$V7DRdkPq7RHKFnJB7kPMduHmbyiXjDo4vdM.T4N22oZfwGWKfopfW	None
62	John	Doe	1981-02-18	johndoe@mail.com	$2b$12$jHfr0/BQHvxlocaM5P0Nye.SfsuCho/Dn2VhuJn1o16v25NaQWH7y	
\.


--
-- Data for Name: person_has_address; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.person_has_address (id, person_id, address_id, address_type) FROM stdin;
1	1	1	home address
2	2	2	home address
3	3	3	home address
4	4	4	home address
5	5	5	home address
6	6	6	home address
7	7	7	home address
8	8	8	home address
9	9	9	home address
10	10	10	home address
11	11	11	home address
12	12	12	home address
13	13	13	home address
14	14	14	home address
15	15	15	home address
16	16	16	home address
17	17	17	home address
18	18	18	home address
19	19	19	home address
20	20	20	home address
21	21	21	home address
22	22	22	home address
23	23	23	home address
24	24	24	home address
25	25	25	home address
26	26	26	home address
27	27	27	home address
28	28	28	home address
29	29	29	home address
30	30	30	home address
31	31	31	home address
32	32	32	home address
33	33	33	home address
34	34	34	home address
35	35	35	home address
36	36	36	home address
37	37	37	home address
38	38	38	home address
39	39	39	home address
40	40	40	home address
41	41	41	home address
42	42	42	home address
43	43	43	home address
44	44	44	home address
45	45	45	home address
46	46	46	home address
47	47	47	home address
48	48	48	home address
49	49	49	home address
50	50	50	home address
51	51	51	home address
52	52	52	home address
53	53	53	home address
54	54	54	home address
55	55	55	home address
\.


--
-- Data for Name: person_has_role; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.person_has_role (id, person_id, role_id) FROM stdin;
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	3
8	8	3
9	9	3
10	10	3
11	11	3
12	12	3
13	13	4
14	14	4
15	15	4
16	16	4
17	17	4
18	18	4
19	19	4
20	20	4
21	21	4
22	22	4
23	23	4
24	24	4
25	25	5
26	26	5
27	27	5
28	28	5
29	29	5
30	30	2
31	31	2
32	32	2
33	33	2
34	34	2
35	35	2
36	36	2
37	37	2
38	38	2
39	39	2
40	40	2
41	41	2
42	42	2
43	43	2
44	44	2
45	45	2
46	46	6
47	47	6
48	48	6
49	49	6
50	50	6
51	51	6
52	52	6
53	53	6
54	54	6
55	55	6
76	1	1
87	1	6
88	62	1
89	62	2
\.


--
-- Data for Name: person_has_subject; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.person_has_subject (id, person_id, subject_id) FROM stdin;
1	30	1
2	31	2
3	32	3
4	33	4
5	34	5
6	35	6
7	36	7
8	37	8
9	38	9
10	39	10
11	40	11
12	41	12
13	42	1
14	43	2
15	44	3
16	45	4
17	46	5
18	47	6
19	48	7
20	49	8
21	50	9
22	51	10
23	52	11
24	53	12
25	54	1
26	55	2
29	46	10
32	55	9
35	20	6
40	1	12
41	62	3
\.


--
-- Data for Name: program_has_person; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.program_has_person (id, program_id, person_id) FROM stdin;
1	1	25
2	2	26
3	3	27
4	4	28
5	5	29
6	5	30
7	1	31
8	2	32
9	3	33
10	4	34
11	5	35
12	1	36
13	2	37
14	3	38
15	4	39
16	5	40
17	1	41
18	2	42
19	3	43
20	4	44
21	5	45
22	1	46
23	2	47
24	3	48
25	4	49
26	5	50
27	1	51
28	2	52
29	3	53
30	4	54
31	5	55
34	3	20
39	1	62
\.


--
-- Data for Name: program_has_subject; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.program_has_subject (id, program_id, subject_id) FROM stdin;
1	1	1
2	2	7
3	3	2
4	4	11
5	5	6
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.role (role_id, role_type) FROM stdin;
1	sysadmin
2	student
3	dean
4	head of department
5	guarantor
6	professor
7	user
8	quest
\.


--
-- Data for Name: study_program; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.study_program (program_id, name, description) FROM stdin;
1	Technical Engineer	4 years
2	Network Operator	2 years
3	 Analytical Chemist	\N
4	Archeologist	\N
5	Graphic Editor	5 years
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.subject (subject_id, name, department_id, description, prerequisites, semester, review, additional_info) FROM stdin;
1	Analog Electronics	2	\N	Math I	1	3	\N
2	Analytical Chemistry I	8	\N	\N	2	3	\N
3	English Conversation	6	\N	\N	1	5	\N
4	Advanced 3D Modelling	12	\N	Graphic basics	1	4	\N
5	Photo Editing	11	\N	\N	1	3	\N
6	Graphic basics	10	\N	\N	2	1	\N
7	Network science	1	\N	\N	1	2	\N
8	Math I	3	\N	\N	1	4	\N
9	Aerodynamics I	4	\N	\N	2	2	\N
10	Applied Thermodynamics	5	\N	\N	1	4	\N
11	Archeology I	9	\N	\N	1	4	\N
12	Food Packaging	7	\N	\N	1	2	do not study!
\.


--
-- Data for Name: thesis; Type: TABLE DATA; Schema: public; Owner: doma
--

COPY public.thesis (thesis_id, name, thesis_type, description, person_id) FROM stdin;
1	Theory of differntial equations	master	\N	30
2	Tool for detecting security vulnerabilities	bachelor	\N	31
3	Advantages of directional photography	master	\N	32
4	Optimalization of food grade materials	bachelor	\N	33
5	Desing and implementation of critical parts of planes	doctoral	\N	34
6	Some random thesis name	bachelor	\N	20
\.


--
-- Data for Name: web_person; Type: TABLE DATA; Schema: public; Owner: chara
--

COPY public.web_person (id) FROM stdin;
\.


--
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.address_address_id_seq', 55, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 96, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: contact_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.contact_contact_id_seq', 55, true);


--
-- Name: department_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.department_department_id_seq', 12, true);


--
-- Name: department_has_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.department_has_person_id_seq', 58, true);


--
-- Name: department_has_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.department_has_program_id_seq', 12, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 24, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 26, true);


--
-- Name: faculty_faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.faculty_faculty_id_seq', 6, true);


--
-- Name: faculty_has_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.faculty_has_department_id_seq', 6, true);


--
-- Name: faculty_has_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.faculty_has_person_id_seq', 89, true);


--
-- Name: person_has_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.person_has_address_id_seq', 55, true);


--
-- Name: person_has_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.person_has_role_id_seq', 89, true);


--
-- Name: person_has_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.person_has_subject_id_seq', 41, true);


--
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.person_person_id_seq', 62, true);


--
-- Name: program_has_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.program_has_person_id_seq', 39, true);


--
-- Name: program_has_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.program_has_subject_id_seq', 5, true);


--
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.role_role_id_seq', 8, true);


--
-- Name: study_program_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.study_program_program_id_seq', 1, false);


--
-- Name: subject_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.subject_subject_id_seq', 12, true);


--
-- Name: thesis_thesis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doma
--

SELECT pg_catalog.setval('public.thesis_thesis_id_seq', 6, true);


--
-- Name: web_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chara
--

SELECT pg_catalog.setval('public.web_person_id_seq', 1, false);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (contact_id);


--
-- Name: department_has_person department_has_person_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department_has_person
    ADD CONSTRAINT department_has_person_pkey PRIMARY KEY (id);


--
-- Name: department_has_program department_has_program_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department_has_program
    ADD CONSTRAINT department_has_program_pkey PRIMARY KEY (id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: faculty_has_department faculty_has_department_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty_has_department
    ADD CONSTRAINT faculty_has_department_pkey PRIMARY KEY (id);


--
-- Name: faculty_has_person faculty_has_person_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty_has_person
    ADD CONSTRAINT faculty_has_person_pkey PRIMARY KEY (id);


--
-- Name: faculty faculty_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (faculty_id);


--
-- Name: person_has_address person_has_address_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_address
    ADD CONSTRAINT person_has_address_pkey PRIMARY KEY (id);


--
-- Name: person_has_role person_has_role_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_role
    ADD CONSTRAINT person_has_role_pkey PRIMARY KEY (id);


--
-- Name: person_has_subject person_has_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_subject
    ADD CONSTRAINT person_has_subject_pkey PRIMARY KEY (id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (person_id);


--
-- Name: program_has_person program_has_person_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.program_has_person
    ADD CONSTRAINT program_has_person_pkey PRIMARY KEY (id);


--
-- Name: program_has_subject program_has_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.program_has_subject
    ADD CONSTRAINT program_has_subject_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- Name: study_program study_program_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.study_program
    ADD CONSTRAINT study_program_pkey PRIMARY KEY (program_id);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (subject_id);


--
-- Name: thesis thesis_pkey; Type: CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.thesis
    ADD CONSTRAINT thesis_pkey PRIMARY KEY (thesis_id);


--
-- Name: web_person web_person_pkey; Type: CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.web_person
    ADD CONSTRAINT web_person_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: chara
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: state_idx; Type: INDEX; Schema: public; Owner: doma
--

CREATE INDEX state_idx ON public.address USING btree (state);


--
-- Name: contact last_contact_change; Type: TRIGGER; Schema: public; Owner: doma
--

CREATE TRIGGER last_contact_change AFTER UPDATE ON public.contact FOR EACH ROW EXECUTE FUNCTION public.add_last_change();


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contact contact_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT contact_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: department_has_person department_has_person_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department_has_person
    ADD CONSTRAINT department_has_person_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- Name: department_has_person department_has_person_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department_has_person
    ADD CONSTRAINT department_has_person_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: department_has_program department_has_program_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department_has_program
    ADD CONSTRAINT department_has_program_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- Name: department_has_program department_has_program_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.department_has_program
    ADD CONSTRAINT department_has_program_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.study_program(program_id);


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: chara
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: faculty faculty_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id);


--
-- Name: faculty_has_department faculty_has_department_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty_has_department
    ADD CONSTRAINT faculty_has_department_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- Name: faculty_has_department faculty_has_department_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty_has_department
    ADD CONSTRAINT faculty_has_department_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(faculty_id);


--
-- Name: faculty_has_person faculty_has_person_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty_has_person
    ADD CONSTRAINT faculty_has_person_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(faculty_id);


--
-- Name: faculty_has_person faculty_has_person_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.faculty_has_person
    ADD CONSTRAINT faculty_has_person_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_has_address person_has_address_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_address
    ADD CONSTRAINT person_has_address_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id);


--
-- Name: person_has_address person_has_address_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_address
    ADD CONSTRAINT person_has_address_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_has_role person_has_role_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_role
    ADD CONSTRAINT person_has_role_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_has_role person_has_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_role
    ADD CONSTRAINT person_has_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id);


--
-- Name: person_has_subject person_has_subject_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_subject
    ADD CONSTRAINT person_has_subject_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_has_subject person_has_subject_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.person_has_subject
    ADD CONSTRAINT person_has_subject_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(subject_id);


--
-- Name: program_has_person program_has_person_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.program_has_person
    ADD CONSTRAINT program_has_person_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id);


--
-- Name: program_has_person program_has_person_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.program_has_person
    ADD CONSTRAINT program_has_person_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.study_program(program_id);


--
-- Name: program_has_subject program_has_subject_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.program_has_subject
    ADD CONSTRAINT program_has_subject_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.study_program(program_id);


--
-- Name: program_has_subject program_has_subject_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.program_has_subject
    ADD CONSTRAINT program_has_subject_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(subject_id);


--
-- Name: subject subject_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- Name: thesis thesis_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doma
--

ALTER TABLE ONLY public.thesis
    ADD CONSTRAINT thesis_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO chara;


--
-- Name: TABLE address; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.address TO chara;


--
-- Name: SEQUENCE address_address_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.address_address_id_seq TO chara;


--
-- Name: TABLE contact; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.contact TO chara;


--
-- Name: SEQUENCE contact_contact_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.contact_contact_id_seq TO chara;


--
-- Name: TABLE department; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.department TO chara;


--
-- Name: SEQUENCE department_department_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.department_department_id_seq TO chara;


--
-- Name: TABLE department_has_person; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.department_has_person TO chara;


--
-- Name: SEQUENCE department_has_person_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.department_has_person_id_seq TO chara;


--
-- Name: TABLE department_has_program; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.department_has_program TO chara;


--
-- Name: SEQUENCE department_has_program_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.department_has_program_id_seq TO chara;


--
-- Name: TABLE faculty; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.faculty TO chara;


--
-- Name: SEQUENCE faculty_faculty_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.faculty_faculty_id_seq TO chara;


--
-- Name: TABLE faculty_has_department; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.faculty_has_department TO chara;


--
-- Name: SEQUENCE faculty_has_department_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.faculty_has_department_id_seq TO chara;


--
-- Name: TABLE faculty_has_person; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.faculty_has_person TO chara;


--
-- Name: SEQUENCE faculty_has_person_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.faculty_has_person_id_seq TO chara;


--
-- Name: TABLE person; Type: ACL; Schema: public; Owner: doma
--

GRANT INSERT,DELETE,UPDATE ON TABLE public.person TO teacher;
GRANT ALL ON TABLE public.person TO chara;


--
-- Name: COLUMN person.name; Type: ACL; Schema: public; Owner: doma
--

GRANT SELECT(name) ON TABLE public.person TO teacher;


--
-- Name: COLUMN person.surname; Type: ACL; Schema: public; Owner: doma
--

GRANT SELECT(surname) ON TABLE public.person TO teacher;


--
-- Name: COLUMN person.birthdate; Type: ACL; Schema: public; Owner: doma
--

GRANT SELECT(birthdate) ON TABLE public.person TO teacher;


--
-- Name: TABLE mat_view_num_of_people_on_engineering_faculties; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.mat_view_num_of_people_on_engineering_faculties TO chara;


--
-- Name: TABLE person_has_address; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.person_has_address TO chara;


--
-- Name: SEQUENCE person_has_address_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.person_has_address_id_seq TO chara;


--
-- Name: TABLE person_has_role; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.person_has_role TO chara;


--
-- Name: SEQUENCE person_has_role_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.person_has_role_id_seq TO chara;


--
-- Name: TABLE person_has_subject; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.person_has_subject TO chara;


--
-- Name: SEQUENCE person_has_subject_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.person_has_subject_id_seq TO chara;


--
-- Name: SEQUENCE person_person_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.person_person_id_seq TO chara;


--
-- Name: TABLE program_has_person; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.program_has_person TO chara;


--
-- Name: SEQUENCE program_has_person_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.program_has_person_id_seq TO chara;


--
-- Name: TABLE program_has_subject; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.program_has_subject TO chara;


--
-- Name: SEQUENCE program_has_subject_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.program_has_subject_id_seq TO chara;


--
-- Name: TABLE role; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.role TO chara;


--
-- Name: SEQUENCE role_role_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.role_role_id_seq TO chara;


--
-- Name: TABLE study_program; Type: ACL; Schema: public; Owner: doma
--

GRANT SELECT ON TABLE public.study_program TO student;
GRANT ALL ON TABLE public.study_program TO chara;


--
-- Name: SEQUENCE study_program_program_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.study_program_program_id_seq TO chara;


--
-- Name: TABLE subject; Type: ACL; Schema: public; Owner: doma
--

GRANT SELECT ON TABLE public.subject TO student;
GRANT ALL ON TABLE public.subject TO chara;


--
-- Name: SEQUENCE subject_subject_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.subject_subject_id_seq TO chara;


--
-- Name: TABLE thesis; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.thesis TO chara;


--
-- Name: SEQUENCE thesis_thesis_id_seq; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON SEQUENCE public.thesis_thesis_id_seq TO chara;


--
-- Name: TABLE view_num_of_people_on_engineering_faculties; Type: ACL; Schema: public; Owner: doma
--

GRANT ALL ON TABLE public.view_num_of_people_on_engineering_faculties TO chara;


--
-- Name: mat_view_num_of_people_on_engineering_faculties; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: doma
--

REFRESH MATERIALIZED VIEW public.mat_view_num_of_people_on_engineering_faculties;


--
-- PostgreSQL database dump complete
--

