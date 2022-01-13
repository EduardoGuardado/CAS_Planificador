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
    
    CREATE TABLE planificaciones
        (
            idPlanificacion INT PRIMARY KEY NOT NULL AUTO_INCREMENT ,
            idUsuario       INT                                     ,
            idMateria       INT                                     ,
            anio            DATE                                    ,
            nivel           VARCHAR(20)                             ,
            FOREIGN KEY (idUsuario) REFERENCES usuarios(idUsuario)  ,
            FOREIGN KEY (idMateria) REFERENCES materias(idMateria)
        )
        ENGINE=INNODB
    ;
    
    CREATE TABLE plandetalles
        (
            idPlandetalle   INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            idPlanificacion INT                                    ,
            desde           DATE                                   ,
            hasta           DATE                                   ,
            unidad          VARCHAR(22)                            ,
            contenido       VARCHAR(22)                            ,
            ejecutado ENUM('si','no')                              ,
            FOREIGN KEY (idPlanificacion) REFERENCES planificaciones(idPlanificacion)
        )
        ENGINE=INNODB
    ;
    
    CREATE TABLE recursos
        (
            idRecurso     INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            idPlandetalle INT                                    ,
            tipo ENUM('enlace','archivo')
        )
        ENGINE=INNODB
    ;
    
    CREATE TABLE recursoDetalle
        (
            idRecursoDetalle INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
            idRecurso        INT                                    ,
            recurso          VARCHAR(20)                            ,
            FOREIGN KEY (idRecurso) REFERENCES recursos(idRecurso)
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
    
    INSERT INTO roles
        (rol
        )
        values
        ('Director'
        )
        ,
        ('Profesor'
        )
    ;
    
    INSERT INTO usuarios
        (nombre     ,
            usuario ,
            clave   ,
            idRol
        )
        values
        ('Eduardo'   ,
            'Ed'     ,
            '123456' ,
            2
        )
        ,
        ('Urrutia'   ,
            'Ut'     ,
            '123456' ,
            1
        )
    ;

    INSERT INTO planificaciones(idUsuario, idMateria, anio, nivel) VALUES (4,4,STR_TO_DATE('01/01/2021','%d/%m/%Y'),'Sexto Grado')