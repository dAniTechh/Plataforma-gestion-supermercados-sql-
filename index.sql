create database Supermercado;

use Supermercado
CREATE TABLE
    Empresas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        direccion TEXT,
        telefono VARCHAR(15)
    );

CREATE TABLE
    GruposCategorias (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL
    );

CREATE TABLE
    Categorias (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        id_grupo_categoria INT,
        FOREIGN KEY (id_grupo_categoria) REFERENCES GruposCategorias (id)
    );

CREATE TABLE
    Productos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        id_empresa INT,
        id_categoria INT,
        precio DECIMAL(10, 2),
        FOREIGN KEY (id_empresa) REFERENCES Empresas (id),
        FOREIGN KEY (id_categoria) REFERENCES Categorias (id)
    );

CREATE TABLE
    CategoriasNutricionales (
        id INT AUTO_INCREMENT PRIMARY KEY,
        descripcion VARCHAR(255) NOT NULL
    );

CREATE TABLE
    ProductoCategoriaNutricional (
        id_producto INT,
        id_categoria_nutricional INT,
        PRIMARY KEY (id_producto, id_categoria_nutricional),
        FOREIGN KEY (id_producto) REFERENCES Productos (id),
        FOREIGN KEY (id_categoria_nutricional) REFERENCES CategoriasNutricionales (id)
    );

CREATE TABLE
    Supermercados (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255),
        direccion TEXT,
        ciudad VARCHAR(100),
        provincia VARCHAR(100)
    );

CREATE TABLE
    Almacenes (id INT AUTO_INCREMENT PRIMARY KEY, direccion TEXT);

CREATE TABLE
    UbicacionProductos (
        id_producto INT,
        id_supermercado INT,
        id_almacen INT,
        stock INT NOT NULL,
        PRIMARY KEY (id_producto, id_supermercado, id_almacen),
        FOREIGN KEY (id_producto) REFERENCES Productos (id),
        FOREIGN KEY (id_supermercado) REFERENCES Supermercados (id),
        FOREIGN KEY (id_almacen) REFERENCES Almacenes (id)
    );

CREATE TABLE
    EmpresasTransporte (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL
    );

CREATE TABLE
    AlmacenTransporte (
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_transporte INT,
        id_almacen INT,
        FOREIGN KEY (id_almacen) REFERENCES Almacenes (id),
        FOREIGN KEY (id_transporte) REFERENCES EmpresasTransporte (id)
    );

CREATE TABLE
    Trabajadores (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        dni VARCHAR(9) UNIQUE NOT NULL,
        nss VARCHAR(15) UNIQUE NOT NULL,
        id_supermercado INT,
        FOREIGN KEY (id_supermercado) REFERENCES Supermercados (id)
    );

CREATE TABLE
    CategoriasLaborales (
        id INT AUTO_INCREMENT PRIMARY KEY,
        descripcion VARCHAR(100) NOT NULL
    );

CREATE TABLE
    TrabajadorCategoria (
        id_trabajador INT,
        id_categoria_laboral INT,
        PRIMARY KEY (id_trabajador, id_categoria_laboral),
        FOREIGN KEY (id_trabajador) REFERENCES Trabajadores (id),
        FOREIGN KEY (id_categoria_laboral) REFERENCES CategoriasLaborales (id)
    );

CREATE TABLE
    JerarquiaLaboral (
        id INT AUTO_INCREMENT PRIMARY KEY,
        descripcion VARCHAR(100) NOT NULL
    );

CREATE TABLE
    TrabajadorJerarquia (
        id_trabajador INT,
        id_jerarquia INT,
        PRIMARY KEY (id_trabajador, id_jerarquia),
        FOREIGN KEY (id_trabajador) REFERENCES Trabajadores (id),
        FOREIGN KEY (id_jerarquia) REFERENCES JerarquiaLaboral (id)
    );

CREATE TABLE
    Contratos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_trabajador INT,
        fecha_inicio DATE NOT NULL,
        fecha_fin DATE,
        FOREIGN KEY (id_trabajador) REFERENCES Trabajadores (id)
    );

CREATE TABLE
    Nominas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_trabajador INT,
        mes VARCHAR(20) NOT NULL,
        salario DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (id_trabajador) REFERENCES Trabajadores (id)
    );

CREATE TABLE
    CampañasPublicitarias (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        descripcion TEXT,
        fecha DATE,
        costo DECIMAL(10, 2)
    );

CREATE TABLE
    CampañaSupermercado (
        id_campaña INT,
        id_supermercado INT,
        PRIMARY KEY (id_campaña, id_supermercado),
        FOREIGN KEY (id_campaña) REFERENCES CampañasPublicitarias (id),
        FOREIGN KEY (id_supermercado) REFERENCES Supermercados (id)
    );

CREATE TABLE
    Clientes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        dni VARCHAR(9) UNIQUE NOT NULL
    );

CREATE TABLE
    ContabilidadSupermercados (
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_supermercado INT,
        fecha DATE NOT NULL,
        ingresos DECIMAL(10, 2),
        gastos DECIMAL(10, 2),
        FOREIGN KEY (id_supermercado) REFERENCES Supermercados (id)
    );

CREATE TABLE
    PedidosOnline (
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_supermercado INT,
        id_cliente INT NOT NULL,
        fecha_pedido DATE NOT NULL,
        FOREIGN KEY (id_supermercado) REFERENCES Supermercados (id)
    );

CREATE TABLE
    PedidoProducto (
        id_pedido INT,
        id_producto INT,
        cantidad INT NOT NULL,
        precio DECIMAL(10, 2) NOT NULL,
        PRIMARY KEY (id_pedido, id_producto),
        FOREIGN KEY (id_pedido) REFERENCES PedidosOnline (id),
        FOREIGN KEY (id_producto) REFERENCES Productos (id)
    );

INSERT INTO
    Empresas (nombre, direccion, telefono)
VALUES
    ('Empresa A', 'Calle Falsa 123', '911234567'),
    (
        'Empresa B',
        'Avenida Siempre Viva 742',
        '922345678'
    ),
    ('Empresa C', 'Calle Gran Vía 45', '933456789');

INSERT INTO
    GruposCategorias (nombre)
VALUES
    ('Alimentos'),
    ('Limpieza'),
    ('Higiene');

INSERT INTO
    Categorias (nombre, id_grupo_categoria)
VALUES
    ('Lácteos', 1),
    ('Carnes', 1),
    ('Detergentes', 2),
    ('Verduras', 1);

INSERT INTO
    ContabilidadSupermercados (id_supermercado, fecha, ingresos, gastos)
VALUES
    (2, '2024-01-31', 50000.00, 30000.00),
    (1, '2024-01-31', 60000.00, 40000.00),
    (3, '2024-01-31', 70000.00, 50000.00),
    (4, '2024-01-28', 150000.00, 3230000.00);

INSERT INTO
    Productos (nombre, id_empresa, id_categoria, precio)
VALUES
    ('Leche', 1, 1, 1.20),
    ('Jabón', 2, 3, 3.50),
    ('Carne de Res', 1, 2, 8.99),
    ('Lechuga', 3, 4, 0.99);

INSERT INTO
    CategoriasNutricionales (descripcion)
VALUES
    ('Bajo en grasa'),
    ('Alto en proteínas'),
    ('Bajo en sodio');

INSERT INTO
    ProductoCategoriaNutricional (id_producto, id_categoria_nutricional)
VALUES
    (1, 1),
    (2, 3),
    (3, 2),
    (4, 1);

INSERT INTO
    Supermercados (nombre, direccion, ciudad, provincia)
VALUES
    (
        'Supermercado Moncloa',
        'Calle Mayor 1',
        'Madrid',
        'Madrid'
    ),
    (
        'Supermercado Badajoz',
        'Calle Extremadura 10',
        'Badajoz',
        'Extremadura'
    ),
    (
        'Supermercado Cáceres',
        'Plaza Mayor 5',
        'Cáceres',
        'Extremadura'
    ),
    (
        'Supermercado Móstoles',
        'Avenida del Sur 12',
        'Móstoles',
        'Madrid'
    ),
    (
        'Supermercado Sevilla',
        'Calle Feria 21',
        'Sevilla',
        'Andalucía'
    );

INSERT INTO
    Almacenes (direccion)
VALUES
    ('Almacén Central Madrid'),
    ('Almacén Sur Móstoles'),
    ('Villaverde Alto'),
    ('Almacén Sevilla');

INSERT INTO
    UbicacionProductos (id_producto, id_supermercado, id_almacen, stock)
VALUES
    (1, 1, 1, 100),
    (2, 2, 2, 50),
    (3, 3, 3, 200),
    (4, 1, 1, 150);

INSERT INTO
    EmpresasTransporte (nombre)
VALUES
    ('Transporte Villaverde'),
    ('Transporte Madrid');

INSERT INTO
    AlmacenTransporte (id_almacen, id_transporte)
VALUES
    (1, 1),
    (2, 2),
    (3, 1);

INSERT INTO
    Trabajadores (nombre, dni, nss, id_supermercado)
VALUES
    ('Juan Pérez', '1234C', 'SS123456', 1),
    ('María López', '5678D', 'SS789012', 2),
    ('Carlos Gómez', '9101E', 'SS345678', 3),
    ('Ana Torres', '1121F', 'SS901234', 4),
    ('Ramiro Ronaldo', '3461F', 'SS901237', 5);

INSERT INTO
    Clientes (nombre, dni)
VALUES
    ('Juan Pérez', '1234C'),
    ('María González', '5678D');

INSERT INTO
    CategoriasLaborales (descripcion)
VALUES
    ('Cajero'),
    ('Reponedor'),
    ('Gerente');

INSERT INTO
    TrabajadorCategoria (id_trabajador, id_categoria_laboral)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 1);

INSERT INTO
    JerarquiaLaboral (descripcion)
VALUES
    ('Empleado'),
    ('Supervisor'),
    ('Director');

INSERT INTO
    TrabajadorJerarquia (id_trabajador, id_jerarquia)
VALUES
    (1, 1),
    (2, 1),
    (3, 3),
    (4, 2),
    (5, 2);

INSERT INTO
    Contratos (id_trabajador, fecha_inicio, fecha_fin)
VALUES
    (1, '2023-01-01', '2024-01-01'),
    (2, '2023-05-01', '2024-05-01'),
    (3, '2023-07-01', '2024-07-01'),
    (4, '2023-03-01', '2024-03-01');

INSERT INTO
    Nominas (id_trabajador, mes, salario)
VALUES
    (1, 'Enero', 1200.00),
    (2, 'Enero', 1000.00),
    (3, 'Enero', 2500.00),
    (4, 'Enero', 1500.00);

INSERT INTO
    CampañasPublicitarias (nombre, descripcion, fecha, costo)
VALUES
    (
        'Campaña Verano 2024',
        'Descuentos en productos frescos',
        '2024-06-01',
        5000.00
    ),
    (
        'Campaña Navidad 2024',
        'Ofertas especiales para Navidad',
        '2024-12-01',
        10000.00
    );

INSERT INTO
    CampañaSupermercado (id_campaña, id_supermercado)
VALUES
    (1, 1),
    (1, 3),
    (1, 4),
    (2, 5),
    (1, 5),
    (2, 2);

INSERT INTO
    PedidosOnline (id_supermercado, id_cliente, fecha_pedido)
VALUES
    (1, 1, '2024-02-02'),
    (3, 2, '2024-02-02'),
    (1, 3, '2024-02-03'),
    (2, 4, '2024-02-03');

INSERT INTO
    PedidoProducto (id_pedido, id_producto, cantidad, precio)
VALUES
    (1, 1, 2, 2.40),
    (1, 1, 3, 3.60),
    (1, 3, 2, 17.98),
    (2, 2, 1, 3.50),
    (2, 1, 10, 12.00),
    (2, 3, 5, 44.95),
    (2, 4, 20, 19.80),
    (2, 3, 1, 8.99);

INSERT INTO
    ContabilidadSupermercados (id_supermercado, fecha, ingresos, gastos)
VALUES
    (4, '2024-01-31', 150000.00, 3230000.00);

INSERT INTO
    PedidoProducto (id_pedido, id_producto, cantidad, precio)
VALUES
    (1, 1, 2, 2.40),
    (1, 3, 1, 8.99);

-- 1. Productos y precios del pedido realizado el día 2 de febrero por el cliente con DNI 1234C
SELECT
    p.nombre AS Producto,
    pp.precio,
    pp.cantidad
FROM
    PedidosOnline po
    JOIN PedidoProducto pp ON po.id = pp.id_pedido
    JOIN Productos p ON pp.id_producto = p.id
WHERE
    po.id_cliente = (
        SELECT
            id
        FROM
            Clientes
        WHERE
            dni = '1234C'
    )
    AND po.fecha_pedido = '2024-02-02';

-- 2. Empresas de transporte que trabajan con el almacén de Villaverde Alto
SELECT
    et.nombre AS EmpresaTransporte
FROM
    EmpresasTransporte et
    JOIN AlmacenTransporte at ON et.id = at.id_transporte
    JOIN Almacenes a ON at.id_almacen = a.id
WHERE
    a.direccion LIKE '%Villaverde%';

-- 3. Trabajadores que son jefes de equipo en el supermercado de Moncloa
SELECT
    t.nombre
FROM
    Trabajadores t
    JOIN TrabajadorJerarquia tj ON t.id = tj.id_trabajador
    JOIN JerarquiaLaboral jl ON tj.id_jerarquia = jl.id
WHERE
    jl.descripcion IN ('Supervisor', 'Director');

-- 4. Informe de ingresos y gastos de enero del supermercado de Móstoles
SELECT
    cs.id_supermercado,
    s.nombre AS supermercado,
    cs.fecha,
    cs.ingresos,
    cs.gastos
FROM
    ContabilidadSupermercados cs
    JOIN Supermercados s ON cs.id_supermercado = s.id
WHERE
    cs.id_supermercado = 4
    AND MONTH (cs.fecha) = 1;

-- 5. Ingresos y gastos globales de la cadena de supermercados en 2024
SELECT
    SUM(ingresos) AS TotalIngresos,
    SUM(gastos) AS TotalGastos
FROM
    ContabilidadSupermercados
WHERE
    YEAR (fecha) = 2024;

-- 6. Listado de campañas publicitarias de los supermercados de Andalucía
SELECT
    cs.id_campaña,
    cs.id_supermercado,
    s.nombre AS supermercado,
    cp.nombre AS campaña
FROM
    CampañaSupermercado cs
    JOIN Supermercados s ON cs.id_supermercado = s.id
    JOIN CampañasPublicitarias cp ON cs.id_campaña = cp.id
WHERE
    s.provincia = 'Andalucía';

-- 7. Categorías de productos que se venden mejor a nivel nacional
SELECT
    c.nombre AS Categoria,
    SUM(pp.cantidad) AS Total_Vendido
FROM
    PedidoProducto pp
    JOIN Productos p ON pp.id_producto = p.id
    JOIN Categorias c ON p.id_categoria = c.id
GROUP BY
    c.id
ORDER BY
    Total_Vendido DESC;

-- 8. Total de trabajadores en cada categoría laboral de la provincia de Extremadura
SELECT
    cl.descripcion AS CategoriaLaboral,
    COUNT(t.id) AS TotalTrabajadores
FROM
    Trabajadores t
    JOIN TrabajadorCategoria tc ON t.id = tc.id_trabajador
    JOIN CategoriasLaborales cl ON tc.id_categoria_laboral = cl.id
WHERE
    t.id_supermercado IN (
        SELECT
            id
        FROM
            Supermercados
        WHERE
            provincia = 'Extremadura'
    )
GROUP BY
    cl.descripcion;