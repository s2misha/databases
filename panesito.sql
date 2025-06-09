create database bd_collaborax;
use bd_collaborax;

create table archivos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(255) NOT NULL,
  ruta varchar(255) NOT NULL,
  deleted_at TIMESTAMP DEFAULT NULL
);

create table roles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(255) NOT NULL,
  descripcion varchar(255) NOT NULL,
  activo tinyint(1) NOT NULL,
  deleted_at TIMESTAMP DEFAULT NULL
);

create table usuarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  correo varchar(255) UNIQUE NOT NULL,
  correo_personal varchar(255) UNIQUE NOT NULL,
  clave varchar(255) NOT NULL,
  rol_id INT NOT NULL,
  activo TINYINT(1) NOT NULL DEFAULT 1,
  en_linea tinyint(1) NOT NULL,
  ultima_conexion TIMESTAMP NULL,
  foto INT NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  clave_mostrar varchar(255) NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (rol_id) REFERENCES roles(id),
  FOREIGN KEY (foto) REFERENCES archivos(id)
);



create table plan_servicios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(255),
  beneficios TEXT,
  costo_soles double NOT NULL,
  cant_usuarios INT NULL,
  deleted_at TIMESTAMP DEFAULT NULL
);

create table empresas(
  id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  plan_servicio_id INT NOT NULL,
  nombre varchar(255) NOT NULL,
  descripcion varchar(255) NULL,
  ruc varchar(255) NOT NULL,
  telefono varchar (255) NOT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  FOREIGN KEY (plan_servicio_id) REFERENCES plan_servicios(id)
);

create table trabajadores (
  id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  empresa_id INT NOT NULL,
  nombres varchar(255) NOT NULL,
  apellido_paterno varchar(255) NOT NULL,
  apellido_materno varchar(255) NOT NULL,
  doc_identidad varchar(8) NULL,
  fecha_nacimiento TIMESTAMP NULL,
  telefono varchar (255) NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

create table areas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  empresa_id INT NOT NULL,
  nombre varchar(255) NOT NULL,
  descripcion varchar(255) NULL,
  codigo varchar(255) NOT NULL,
  color varchar(255) NULL,
  activo tinyint(1) NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT current_timestamp NOT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

create table equipos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  coordinador_id INT NOT NULL,
  area_id INT NOT NULL,
  nombre varchar(255) NOT NULL,
  descripcion varchar(255) NULL,
  fecha_creacion TIMESTAMP DEFAULT current_timestamp NOT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,  
  FOREIGN KEY (coordinador_id) REFERENCES trabajadores(id),
  FOREIGN KEY (area_id) REFERENCES areas(id)
);

create table miembros_equipo (
  id INT PRIMARY KEY AUTO_INCREMENT,
  equipo_id INT NOT NULL,
  trabajador_id INT NOT NULL,
  fecha_union TIMESTAMP DEFAULT current_timestamp NOT NULL,
  activo tinyint(1) NOT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (equipo_id) REFERENCES equipos(id),
  FOREIGN KEY (trabajador_id) REFERENCES trabajadores(id)
);

create table estados (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(255) NOT NULL,
  descripcion varchar(255) NULL,
  deleted_at TIMESTAMP DEFAULT NULL
);

create table metas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  equipo_id INT NOT NULL,
  estado_id INT NOT NULL,
  nombre varchar(255) NOT NULL,
  descripcion varchar(255) NULL,
  fecha_creacion TIMESTAMP DEFAULT current_timestamp NOT NULL,
  fecha_entrega TIMESTAMP NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (equipo_id) REFERENCES equipos(id),
  FOREIGN KEY (estado_id) REFERENCES estados(id)
);

create table tareas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  meta_id INT NOT NULL,
  estado_id INT NOT NULL,
  nombre varchar(255) NOT NULL,
  descripcion varchar(255) NULL,
  fecha_creacion TIMESTAMP DEFAULT current_timestamp NOT NULL,
  fecha_entrega TIMESTAMP NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (meta_id) REFERENCES metas(id),
  FOREIGN KEY (estado_id) REFERENCES estados(id)
);

create table modalidades (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(255) NOT NULL,
  descripcion varchar(255) NULL,
  deleted_at TIMESTAMP DEFAULT NULL
);

create table reuniones (
  id INT PRIMARY KEY AUTO_INCREMENT,
  equipo_id INT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NULL,
  duracion int NOT NULL,
  descripcion varchar(255) NULL,
  asunto varchar(255) NOT NULL,
  modalidad_id INT NOT NULL,
  sala varchar(255) NULL,
  estado varchar(255) NOT NULL default 'PROGRAMADA',
  observacion varchar(255) NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (equipo_id) REFERENCES equipos(id),
  FOREIGN KEY (modalidad_id) REFERENCES modalidades(id)
);

create table areas_coordinador (
  id INT PRIMARY KEY AUTO_INCREMENT,
  area_id INT NOT NULL,
  trabajador_id INT NOT NULL,
  fecha_inicio TIMESTAMP NOT NULL,
  fecha_fin TIMESTAMP NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (area_id) REFERENCES areas(id),
  FOREIGN KEY (trabajador_id) REFERENCES trabajadores(id)
);

create table invitaciones (
  id INT PRIMARY KEY AUTO_INCREMENT,
  equipo_id INT NOT NULL,
  trabajador_id INT NOT NULL,
  fecha_invitacion TIMESTAMP DEFAULT current_timestamp,
  fecha_expiracion TIMESTAMP NULL,
  fecha_respuesta TIMESTAMP NULL,
  estado varchar(255) NOT NULL DEFAULT 'PENDIENTE',
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (equipo_id) REFERENCES equipos(id),
  FOREIGN KEY (trabajador_id) REFERENCES trabajadores(id)
);

create table mensajes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  remitente_id INT NOT NULL,
  destinatario_id INT NOT NULL,
  contenido TEXT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  leido tinyint(1) NOT NULL,
  archivo_id INT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (remitente_id) REFERENCES trabajadores(id),
  FOREIGN KEY (destinatario_id) REFERENCES trabajadores(id),
  FOREIGN KEY (archivo_id) REFERENCES archivos(id)
);
