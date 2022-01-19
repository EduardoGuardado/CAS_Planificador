CREATE DATABASE AccesosUsuario;
    USE AccesosUsuario;
    CREATE TABLE roles
        (
            idRol INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            rol   VARCHAR(10)
        )
        ENGINE=INNODB
    ;
    
    CREATE TABLE usuarios
        (
            idUsuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            nombre    VARCHAR(35),
            apellido  VARCHAR(35),
            correo    VARCHAR(50),
            telefono  VARCHAR(9),
            usuario   VARCHAR(20),
            clave     VARCHAR(12),
            idRol     INT,
            FOREIGN KEY (idRol) REFERENCES roles(idRol)
        )
        ENGINE=INNODB
    ;

    CREATE TABLE grados
        (
            idGrado INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            nivel  VARCHAR(10),
            tipo   SET('basica','bachillerato'),
            seccion SET('A','B','C','D')
        )
        ENGINE=INNODB
    ;

    CREATE TABLE materias
        (
            idMateria INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            materia    VARCHAR(35),
            tipo      SET('basica','extracurricular'),
            idGrado   INT,
            FOREIGN KEY (idGrado) REFERENCES grados(idGrado)
        )
        ENGINE=INNODB
    ;

    CREATE TABLE unidades(
        idUnidad INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        etapa VARCHAR(10)
    )ENGINE=INNODB;

    CREATE TABLE detalleUnidades(
        idDetalleUnidad INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        idMateria INT,
        idUnidad INT,
        tituloUnidad VARCHAR(50),
        FOREIGN KEY (idMateria) REFERENCES materias(idMateria),
        FOREIGN KEY (idUnidad) REFERENCES unidades(idUnidad)
    )ENGINE=InnoDB;

    CREATE TABLE contenidos(
        idContenido INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        idDetalleUnidad INT,
        tema VARCHAR(50)
        FOREIGN KEY (idDetalleUnidad) REFERENCES detalleUnidades(idDetalleUnidad)
    )ENGINE=InnoDB;

    CREATE TABLE profesores(
        idProfesor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        idUsuario INT,
        idMateria INT,
        idGrado INT,
        FOREIGN KEY (idUsuario) REFERENCES usuarios(idUsuario),
        FOREIGN KEY (idMateria) REFERENCES materias(idMateria),
        FOREIGN KEY (idGrado) REFERENCES grados(idGrado)
    )ENGINE=InnoDB;

    CREATE TABLE recursos
        (
            idRecurso INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            idContenido INT,
            recurso VARCHAR(100),
            tipo ENUM('enlace','archivo'),
            FOREIGN KEY (idContenido) REFERENCES contenidos(idContenido)
        )
        ENGINE=INNODB
    ;
    
    CREATE TABLE planificaciones
        (
            idPlanificacion INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            idProfesor INT,
            idMateria INT,
            fecha DATE,
            FOREIGN KEY (idProfesor) REFERENCES profesores(idProfesor),
            FOREIGN KEY (idMateria) REFERENCES materias(idMateria)
        )
        ENGINE=INNODB
    ;
    
    CREATE TABLE plandetalles
        (
            idPlandetalle INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            idPlanificacion INT,
            desde DATE,
            hasta DATE,
            idContenido INT,
            ejecutado SET('sí','no'),
            FOREIGN KEY (idPlanificacion) REFERENCES planificaciones(idPlanificacion),
            FOREIGN KEY (idContenido) REFERENCES contenidos(idContenido)
        )
        ENGINE=INNODB
    ;
    
    CREATE TABLE programas
        (
            idPrograma INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            idMateria  INT                                    ,
            nivel      VARCHAR(20)                            ,
            FOREIGN KEY (idMateria) REFERENCES materias(idMateria)
        )
        ENGINE=INNODB
    ;
    
    CREATE TABLE programaDetalle
        (
            idProgramadetalle INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            idPrograma        INT                                    ,
            unidad            VARCHAR(20)                            ,
            numeroContenido   DOUBLE(2,2)                              ,
            contenido VARCHAR(20)                                    ,
            FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma)
        )
        ENGINE=INNODB
    ;
    
    INSERT INTO roles(rol) values ('Director'),('Profesor');
    
    INSERT INTO usuarios(nombre, apellido, correo, telefono, usuario, clave, idRol) values ('Eduardo', 'Guardado', 'eduardo@mail.com', '76546134', 'Ed', '123456', 2),('Urrutia', 'Ramos', 'urrutia@mail.com', '78654321', 'Ut', '123456', 1);

    INSERT INTO grados(nivel, tipo, seccion) values ('Primero', 'basica', 'A'),('Segundo', 'basica', 'A'),('Tercero', 'basica', 'A');

    INSERT INTO materias (materia, tipo, idGrado) values ('Lenguaje','basica',1),('Matemática','basica',1),('Ciencias','basica',1),('Sociales','basica',1);

    INSERT INTO unidades(etapa) values ('Unidad 1: '),('Unidad 2: '),('Unidad 3: '),('Unidad 4: '),('Unidad 5: '),('Unidad 6: '),('Unidad 7: ');

    INSERT INTO detalleUnidades(idMateria, idUnidad, tituloUnidad) values (1,1,'Las Vocales'),(1,2,'Mayúsculas y minúsculas'),(2,1,'Los números'),(2,1,'aprendiendo a contar');

   -- INSERT INTO planificaciones(idUsuario, idMateria, anio, nivel) VALUES (4,4,STR_TO_DATE('01/01/2021','%d/%m/%Y'),'Sexto Grado')