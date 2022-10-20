CREATE DATABASE db_wk
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Pessoa 
create table pessoa
(
	idpessoa bigserial not null,
	flnatureza int2 not null,
	dsdocumento varchar(20) not null,
	nmprimeiro varchar(100) not null,
	nmsegundo varchar(100) not null,
	dtregistro date null,
	constraint pessoa_pk primary key (idpessoa)
);

-- Endereco da Pessoa
create table endereco (
	idendereco bigserial not null,
	idpessoa int8 not null,
	dscep varchar(15) null,
	constraint endereco_pk primary key (idendereco),
	constraint endereco_fk_pessoa foreign key (idpessoa) references pessoa (idpessoa) on delete cascade
);

create index endereco_idpessoa on endereco (idpessoa);

-- Endereco Integracao
create table endereco_integracao (
	idendereco bigint not null,
	dsuf varchar(50) null,
	nmcidade varchar(100) null,
	nmbairro varchar(50) null,
	nmlogradouro varchar(100) null,
	dscomplemento varchar(100) null,
	constraint enderecointegracao_pk primary key (idendereco),
	constraint enderecointegracao_fk_endereco foreign key (idendereco) references endereco (idendereco) on delete cascade
);

