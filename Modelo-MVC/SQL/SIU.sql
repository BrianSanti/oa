DROP DATABASE IF EXISTS siu;
CREATE DATABASE siu;
USE siu;
## Julio Morataya 0901-16-24166
###############################   seguridad
#SEGURIDAD-----------------------------------------------------------------------------------------
create table if not exists LOGIN(
	pk_id_login 						int(10) not null primary key auto_increment,
    usuario_login 						varchar(45),
    contraseña_login 					varchar(45),
    nombreCompleto_login				varchar(100),
    estado_login						int(2)
);
create table if not exists MODULO(
	pk_id_modulo 						int(10)not null auto_increment,
    nombre_modulo 						varchar(30)not null,
    descripcion_modulo 					varchar(50)not null,
    estado_modulo 						int(1)not null,
    primary key(pk_id_modulo),
    key(pk_id_modulo)
);
create table if not exists APLICACION(
	pk_id_aplicacion 					int(10)not null auto_increment,
    fk_id_modulo 						int(10)not null,
    nombre_aplicacion 					varchar(40)not null,
    descripcion_aplicacion 				varchar(45)not null,
    estado_aplicacion 					int(1)not null,
    primary key(pk_id_aplicacion),
    key(pk_id_aplicacion)
);
alter table APLICACION add constraint fk_aplicacion_modulo foreign key(fk_id_modulo) references MODULO(pk_id_modulo);

create table if not exists PERFIL(
	pk_id_perfil						int(10) not null primary key auto_increment,
    nombre_perfil						varchar(50),
    descripcion_perfil					varchar(100),
    estado_perfil						int(2)
);
create table if not exists PERMISO(
	pk_id_permiso						int(10) not null primary key auto_increment,
    insertar_permiso					boolean,
    modificar_permiso					boolean,
    eliminar_permiso					boolean,
    consultar_permiso					boolean,
    imprimir_permiso					boolean
);
create table if not exists APLICACION_PERFIL(
	pk_id_aplicacion_perfil				int(10) not null primary key auto_increment,
    fk_idaplicacion_aplicacion_perfil	int(10),
    fk_idperfil_aplicacion_perfil		int(10),
    fk_idpermiso_aplicacion_perfil		int(10)
);
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_aplicacion foreign key (fk_idaplicacion_aplicacion_perfil) references APLICACION(pk_id_aplicacion)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_perfil foreign key (fk_idperfil_aplicacion_perfil) references PERFIL(pk_id_perfil)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_permiso foreign key (fk_idpermiso_aplicacion_perfil) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists PERFIL_USUARIO(
	pk_id_perfil_usuario				int(10) not null primary key auto_increment,
    fk_idusuario_perfil_usuario			int(10),
    fk_idperfil_perfil_usuario			int(10)
);
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_login foreign key(fk_idusuario_perfil_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_perfil foreign key (fk_idperfil_perfil_usuario) references PERFIL(pk_id_perfil) on delete restrict on update cascade;

create table if not exists APLICACION_USUARIO(
	pk_id_aplicacion_usuario			int(10) not null primary key auto_increment,
    fk_idlogin_aplicacion_usuario		int(10),
    fk_idaplicacion_aplicacion_usuario	int(10),
    fk_idpermiso_aplicacion_usuario		int(10)
);
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_login foreign key(fk_idlogin_aplicacion_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_aplicacion foreign key (fk_idaplicacion_aplicacion_usuario) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_permiso foreign key(fk_idpermiso_aplicacion_usuario) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists BITACORA(
	pk_id_bitacora						int(10) not null primary key auto_increment, #pk
    fk_idusuario_bitacora				int(10),
    fk_idaplicacion_bitacora			int(10),
    fechahora_bitacora					varchar(50),
    direccionhost_bitacora				varchar(20),
    nombrehost_bitacora					varchar(20),
    accion_bitacora						varchar(250)
);
CREATE TABLE IF NOT EXISTS DETALLE_BITACORA (
    pk_id_detalle_bitacora 				INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_idbitacora_detalle_bitacora 		INT(10),
    querryantigua_detalle_bitacora 		VARCHAR(50),
    querrynueva_detalle_bitacora 		VARCHAR(50)
);
alter table BITACORA add constraint fk_login_bitacora foreign key (fk_idusuario_bitacora) references LOGIN (pk_id_login) on delete restrict on update cascade;
alter table BITACORA add constraint fk_aplicacion_bitacora foreign key (fk_idaplicacion_bitacora) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table DETALLE_BITACORA add constraint fk_bitacora_detallebitacora foreign key(fk_idbitacora_detalle_bitacora) references BITACORA(pk_id_bitacora) on delete restrict on update cascade;

-- -----------------------------------------------------
-- Table `educativo`.`Alumnos`
-- -----------------------------------------------------
CREATE TABLE alumnos
 (
  carnet_alumno VARCHAR(15),
  nombre_alumno VARCHAR(45),
  direccion_alumno VARCHAR(45),
  telefono_alumno VARCHAR(45),
  email_alumno VARCHAR(20),
  estatus_alumno VARCHAR(1),
  PRIMARY KEY (carnet_alumno)
) ENGINE = InnoDB DEFAULT CHARSET=latin1;

-- -----------------------------------------------------
-- Table `educativo`.`Maestros`
-- -----------------------------------------------------
CREATE TABLE maestros
(
  codigo_maestro VARCHAR(5),
  nombre_maestro VARCHAR(45),
  direccion_maestro VARCHAR(45),
  telefono_maetro VARCHAR(45),
  email_maestro VARCHAR(20),
  estatus_maestro VARCHAR(1),
  PRIMARY KEY (codigo_maestro)
 ) ENGINE = InnoDB DEFAULT CHARSET=latin1;
-- -----------------------------------------------------
-- Table `educativo`.`Facultades`
-- -----------------------------------------------------
CREATE TABLE facultades
(
  codigo_facultad VARCHAR(5),
  nombre_facultad VARCHAR(45),
  estatus_facultad VARCHAR(1),
  PRIMARY KEY (codigo_facultad)
) ENGINE = InnoDB DEFAULT CHARSET=latin1;
-- -----------------------------------------------------
-- Table `educativo`.`Carreras`
-- -----------------------------------------------------
CREATE TABLE carreras
(
  codigo_carrera VARCHAR(5),
  nombre_carrera VARCHAR(45),
  codigo_facultad VARCHAR(5),
  estatus_carrera VARCHAR(1),
  PRIMARY KEY (codigo_carrera),
  FOREIGN KEY (codigo_facultad) REFERENCES facultades(codigo_facultad)
) ENGINE = InnoDB DEFAULT CHARSET=latin1;
-- -----------------------------------------------------
-- Table `educativo`.`Cursos`
-- -----------------------------------------------------
CREATE TABLE cursos
(
  codigo_curso VARCHAR(5),
  nombre_curso VARCHAR(45),
  estatus_curso VARCHAR(1),
  PRIMARY KEY (codigo_curso)
 ) ENGINE = InnoDB DEFAULT CHARSET=latin1;
-- -----------------------------------------------------
-- Table `educativo`.`Secciones`
-- -----------------------------------------------------
CREATE TABLE secciones
(
  codigo_seccion VARCHAR(5),
  nombre_seccion VARCHAR(45),
  estatus_seccion VARCHAR(1),
  PRIMARY KEY (codigo_seccion)
 ) ENGINE = InnoDB DEFAULT CHARSET=latin1;
-- -----------------------------------------------------
-- Table `educativo`.`Sedes`
-- -----------------------------------------------------
CREATE TABLE sedes
(
  codigo_sede VARCHAR(5),
  nombre_sede VARCHAR(45),
  estatus_sede VARCHAR(1),
  PRIMARY KEY (codigo_sede)
) ENGINE = InnoDB DEFAULT CHARSET=latin1;
-- -----------------------------------------------------
-- Table `educativo`.`Aulas`
-- -----------------------------------------------------
CREATE TABLE aulas
(
  codigo_aula VARCHAR(5),
  nombre_aula VARCHAR(45),
  estatus_aula VARCHAR(1),
  PRIMARY KEY (codigo_aula)
) ENGINE = InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE jornadas
(
	codigo_jornada VARCHAR(5),
    nombre_jornada VARCHAR(45),
    estatus_jornada VARCHAR(1),
    PRIMARY KEY (codigo_jornada)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
-- -----------------------------------------------------
-- Table `educativo`.`Asignacion_cursos_alumnos`
-- -----------------------------------------------------
CREATE TABLE asignacioncursosalumnos
(
  codigo_carrera VARCHAR(5),
  codigo_sede VARCHAR(5),
  codigo_jornada VARCHAR(5),
  codigo_seccion VARCHAR(5),
  codigo_aula VARCHAR(5),
  codigo_curso VARCHAR(5),
  carnet_alumno VARCHAR(15),
  nota_asignacioncursoalumnos FLOAT(10,2), 
  PRIMARY KEY (codigo_carrera, codigo_sede, codigo_jornada, codigo_seccion, codigo_aula, codigo_curso, carnet_alumno),
  FOREIGN KEY (codigo_carrera) REFERENCES carreras(codigo_carrera),
  FOREIGN KEY (codigo_sede) REFERENCES sedes(codigo_sede),
  FOREIGN KEY (codigo_jornada) REFERENCES jornadas(codigo_jornada),
  FOREIGN KEY (codigo_seccion) REFERENCES secciones(codigo_seccion),
  FOREIGN KEY (codigo_aula) REFERENCES aulas(codigo_aula),
  FOREIGN KEY (codigo_curso) REFERENCES cursos(codigo_curso),
  FOREIGN KEY (carnet_alumno) REFERENCES alumnos(carnet_alumno)
  ) ENGINE = InnoDB DEFAULT CHARSET=latin1;
-- -----------------------------------------------------
-- Table `educativo`.`Asignacion_cursos_maestros`
-- -----------------------------------------------------
CREATE TABLE asignacioncursosmastros
(
  codigo_carrera VARCHAR(5),
  codigo_sede VARCHAR(5),
  codigo_jornada VARCHAR(5),
  codigo_seccion VARCHAR(5),
  codigo_aula VARCHAR(5),
  codigo_curso VARCHAR(5),
  codigo_maestro VARCHAR(5),
  PRIMARY KEY (codigo_carrera, codigo_sede, codigo_jornada, codigo_seccion, codigo_aula, codigo_curso),
  FOREIGN KEY (codigo_carrera) REFERENCES carreras(codigo_carrera),
  FOREIGN KEY (codigo_sede) REFERENCES sedes(codigo_sede),
  FOREIGN KEY (codigo_jornada) REFERENCES jornadas(codigo_jornada),
  FOREIGN KEY (codigo_seccion) REFERENCES secciones(codigo_seccion),
  FOREIGN KEY (codigo_aula) REFERENCES aulas(codigo_aula),
  FOREIGN KEY (codigo_curso) REFERENCES cursos(codigo_curso),
  FOREIGN KEY (codigo_maestro) REFERENCES maestros(codigo_maestro)
  ) ENGINE = InnoDB DEFAULT CHARSET=latin1;

#######################################################################################
############################## datos seguridad

INSERT INTO `login` 
VALUES (1,'sistema','bi0PL96rbxVRPKJQsLJJAg==','Usuario de prueba',1),
(6,'admin','T+4Ai6O3CR0kJYxCgXy2jA==','Administrador',1),
(7,'morataya','5g2jpUc7tYd0Q0iop9+lfA==','Julio Morataya',1);

INSERT INTO `modulo` 
VALUES (1,'Seguridad','Aplicaciones de seguridad',1),
(2,'Consultas','Consultas Inteligentes',1),
(3,'Reporteador','Aplicaciones de Reporteador',1),
(4,'SIU','Sistema IU',1);

INSERT INTO `aplicacion`
 VALUES (1,1,'Login','Ventana de Ingreso',1),
(2,1,'Mantenimiento Usuario','Mantenimientos de usuario',1),
(3,1,'Mantenimiento Aplicacion','ABC de las Aplicaciones',1),
(4,1,'Mantenimiento Perfil','ABC de perfiles',1),
(5,1,'Asignacion de Aplicaciones a Perfil','Asignacion Aplicacion y perfil',1),
(6,1,'Asignacaion de Aplicaciones','Asignacion especificas a un usuario',1),
(7,1,'Consulta Aplicacion','Mantenimiento de Aplicaciones',1),
(8,1,'Agregar Modulo','Mantenimientos de Modulos',1),
(9,1,'Consultar Perfil','Consultas de perfiles disponibles',1),
(10,1,'Permisos','Asignar permisos a perfiles y aplicaciones',1),
(11,1,'Cambio de Contraseña','Cambia las contraseñas',1),
(12,1,'Reporte De Bitacora','Reporte de bitacora',1),
(301,4,'Mantenimiento Centros','Mantenimientos de Centros de pasaporte',1),
(302,4,'Mantenimiento Tipo Pasaporte','Mantenimiento Tipos de pasaportes',1),
(303,4,'Mantenimiento Motivo','Mantenimiento tipo de motivo de gestion',1),
(304,4,'Proceso Citas','Proceso para la emision de citas',1),
(305,4,'Nueva cita','Proceso para una nueva cita',1),
(306,4,'Verificar Cita','Proceso para la verifiacacion de Citas',1),
(307,4,'Modificar Cita','Proceso para la modificacion de citas',1),
(308,4,'Proceso Verificacion de datos','Para nuevos y renovacion de pasaporte',1),
(309,4,'Proceso Primer pasaporte','Proceso para renovar o nuevo pasaporte',1),
(310,4,'Impresion de pasaporte','Impresion de pasaporte',1),
(311,4,'Reporte De Citas','Reporte De Citas',1),
(312,4,'Reporte De Pasaportes','Reporte De Pasaportes',1);

INSERT INTO `perfil` 
VALUES (1,'Admin','Administracion del programa',1),
(2,'Sistema','Administrador del sistema',1),
(3,'Digitador','Digitador para Cuentas',0),
(4,'Consultor','Unicamente consultas ',0),
(5,'Reportes','Ingreso y consultas de reportes',1),
(6,'Pruebas','pruebas',0),(7,'Administrador','Administrador del MRP',0),
(8,'Digitador Pasaporte','Creador de Citas y Pasaportes',1);

INSERT INTO `perfil_usuario` 
VALUES (1,1,1),(6,7,2),(7,7,1),
(8,7,5),(9,1,2),(10,7,3),(11,1,5),(12,1,8);

INSERT INTO `aplicacion_usuario` VALUES (13,1,302,24),(14,1,303,25),
(15,1,304,26),(16,1,305,27),(17,1,306,28),(18,1,307,29),(19,1,308,30),
(20,1,309,31),(21,1,310,32),(22,1,301,43),(24,1,311,47),(25,1,312,48),
(26,1,12,49),(27,7,1,50),(28,7,2,51),(29,7,3,52),(30,7,4,53),(31,7,5,54),
(32,7,6,55),(33,7,7,56),(34,7,8,57),(35,7,9,58),(36,7,10,59),(37,7,11,60),
(38,7,12,61),(39,7,301,62),(40,7,302,63),(41,7,303,64),(42,7,304,65),(43,7,305,66),
(44,7,306,67),(45,7,307,68),(46,7,308,69),(47,7,309,70),(48,7,310,71),(49,7,311,72),
(50,7,312,73),(52,1,1,75),(53,1,2,76),(54,1,3,77),(55,1,4,78),(56,1,5,79),(57,1,6,80),
(58,1,7,81),(59,1,8,82),(60,1,9,83),(61,1,10,84),(62,1,11,85);

INSERT INTO `permiso` 
VALUES (1,1,1,1,1,1),(2,1,1,1,1,1),(3,1,1,1,0,0),(4,1,1,1,1,1),(5,1,1,1,1,1),
(6,1,1,1,1,1),(7,1,1,1,1,1),(8,1,0,1,0,0),(9,1,1,0,0,0),(10,1,1,0,0,0),(11,1,1,1,1,1),
(12,0,0,0,1,0),(13,0,0,0,1,0),(14,0,0,0,0,0),(15,1,0,0,1,0),(16,0,0,0,0,0),(17,1,1,0,0,0),
(18,1,1,1,1,1),(19,0,1,0,0,0),(20,1,1,0,0,0),(21,1,1,1,0,0),(22,1,1,1,1,1),(23,1,1,1,1,1),
(24,1,1,1,1,1),(25,1,1,1,1,1),(26,1,1,1,1,1),(27,0,0,0,0,0),(28,0,0,0,0,0),(29,0,0,0,0,0),
(30,0,0,0,0,0),(31,1,1,1,1,1),(32,1,1,1,1,1),(33,1,1,1,1,1),(34,1,1,1,1,1),(35,1,1,1,1,1),
(36,1,1,1,1,1),(37,1,1,1,1,1),(38,1,1,1,1,1),(39,1,1,1,1,1),(40,1,1,1,1,1),(41,1,1,1,1,1),
(42,1,1,1,1,1),(43,1,1,1,1,1),(44,0,0,0,0,0),(45,1,1,1,1,1),(46,1,1,1,1,1),(47,0,0,0,0,0),
(48,0,0,0,0,0),(49,0,0,0,0,0),(50,0,0,0,0,0),(51,1,1,1,1,1),(52,1,1,1,1,1),(53,1,1,1,1,1),
(54,1,1,1,1,1),(55,0,0,0,0,0),(56,0,0,0,0,0),(57,0,0,0,0,0),(58,0,0,0,0,0),(59,0,0,0,0,0),
(60,0,0,0,0,0),(61,0,0,0,0,0),(62,0,0,0,0,0),(63,0,0,0,0,0),(64,0,0,0,0,0),(65,0,0,0,0,0),
(66,0,0,0,0,0),(67,0,0,0,0,0),(68,0,0,0,0,0),(69,0,0,0,0,0),(70,0,0,0,0,0),(71,0,0,0,0,0),
(72,0,0,0,0,0),(73,0,0,0,0,0),(74,0,0,0,0,0),(75,0,0,0,0,0),(76,0,0,0,0,0),(77,0,0,0,0,0),
(78,0,0,0,0,0),(79,0,0,0,0,0),(80,0,0,0,0,0),(81,0,0,0,0,0),(82,0,0,0,0,0),(83,0,0,0,0,0),
(84,0,0,0,0,0),(85,0,0,0,0,0);

INSERT INTO `aplicacion_perfil` 
VALUES (1,1,1,1),(2,4,1,2),(3,5,1,3),(4,2,1,4),(5,3,1,5),(6,6,1,6),
(7,8,1,7),(8,2,3,8),(9,3,3,9),(10,4,3,11),(11,2,4,12),(12,8,4,13),
(13,8,5,15),(14,8,7,21),(15,301,8,33),(16,302,8,34),(17,303,8,35),
(18,304,8,36),(19,305,8,37),(20,306,8,38),(21,307,8,39),(22,308,8,40),
(23,309,8,41),(24,310,8,42),(25,311,8,45),(26,312,8,46);
