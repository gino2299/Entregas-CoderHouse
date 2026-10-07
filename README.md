# RetailPro — Análisis de Ventas y Base de Datos

Proyecto desarrollado durante la formación en **Data Analytics – Coderhouse**.

RetailPro simula la gestión de ventas de una empresa que comercializa productos tecnológicos. El proyecto recorre todo el proceso de análisis: se diseña una base de datos relacional, se cargan los datos, se consultan con SQL y se visualizan en Power BI.

**Diseño → Base de datos → SQL → Consultas analíticas → Power BI**

---

## Objetivo

RetailPro necesita centralizar y analizar información de clientes, productos, categorías, ventas y territorios para responder preguntas como:

* ¿Cómo evolucionan las ventas mes a mes?
* ¿Qué productos facturan más?
* ¿Qué clientes compran de forma recurrente?
* ¿Cómo se distribuyen las ventas por territorio?

---

## Herramientas utilizadas

| Herramienta | Para qué se usó |
| --- | --- |
| **SQL** | Crear la base `Ventas_Tech_DB`, sus tablas y relaciones, cargar datos y hacer consultas de análisis (`JOIN`, `GROUP BY`, subconsultas, `CASE`, `UNION ALL`, funciones de agregación). |
| **Power BI** | Armar el dashboard a partir de los datos de la base. |
| **GitHub** | Guardar las entregas y mantener el historial del proyecto. |

---

## Estructura del repositorio

```text
Entregas-CoderHouse/
├── Brief_retailpro_preentrega1.docx   # Definición inicial del proyecto
├── Ventas_Tech_DB.sql                 # Creación y carga de la base de datos
├── m4_consultas_negocio.sql           # Consultas de análisis de negocio
├── m5_consultas_joins.sql             # Consultas con JOIN
├── Seminare_Gino_Checkpoint2.pbix     # Dashboard en Power BI
└── README.md
```

---

## Modelo de datos

```text
categorias ──► productos ──► ventas ◄── cliente ◄── territorios
```

Cada flecha va de la tabla "origen" (clave primaria) a la tabla que la referencia (clave foránea).

| Tabla | Descripción | Relación (clave foránea) |
| --- | --- | --- |
| `categorias` | Categorías de productos | — |
| `productos` | Productos comercializados | `id_categoria` → `categorias` |
| `territorios` | Información geográfica (provincia, localidad) | — |
| `cliente` | Datos de los clientes | `id_territorio` → `territorios` |
| `ventas` | Operaciones de venta | `id_cliente` → `cliente`, `id_producto` → `productos` |

---

## Cómo ejecutar el proyecto

### Requisitos

* **Microsoft SQL Server** y **SQL Server Management Studio (SSMS)**
* **Power BI Desktop** (solo para abrir el dashboard)
* **Git** (solo si querés clonar el repositorio)

### Paso a paso

1. **Descargar el proyecto.**

   ```bash
   git clone https://github.com/gino2299/Entregas-CoderHouse.git
   cd Entregas-CoderHouse
   ```

2. **Crear y cargar la base de datos.** Abrí `Ventas_Tech_DB.sql` en SSMS y ejecutá el script completo. Crea la base `Ventas_Tech_DB`, las tablas, las relaciones y los datos.

3. **Ejecutar las consultas de negocio.** Abrí `m4_consultas_negocio.sql` y ejecutá las consultas.

4. **Ejecutar las consultas con JOIN.** Abrí `m5_consultas_joins.sql` y ejecutá las consultas.

> ⚠️ **Importante:** el paso 2 tiene que hacerse primero. Los scripts `m4` y `m5` usan `USE Ventas_Tech_DB;` y fallan si la base todavía no existe. En ambos conviene ejecutar una consulta a la vez (seleccionarla y apretar *Execute*) para ver el resultado de cada análisis.

---

## Scripts SQL

### `Ventas_Tech_DB.sql`
Crea la base de datos, las tablas, las claves primarias y foráneas, y carga los datos. Termina con consultas de verificación.

### `m4_consultas_negocio.sql`
Consultas pensadas para el negocio: resumen mensual (facturación y cantidad de pedidos), ranking de productos, clientes recurrentes y comparación de cada mes contra el promedio.

```sql
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;
```

### `m5_consultas_joins.sql`
Combina las tablas con `INNER JOIN` y `LEFT JOIN` (por ejemplo, para encontrar clientes o productos sin ventas). Esta consulta junta ventas, clientes, productos, categorías y territorios en una sola vista:

```sql
SELECT
    v.fecha_venta,
    v.id_cliente,
    p.nombre_producto,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta,
    cat.nombre_categoria,
    c.ciudad,
    t.provincia,
    t.localidad
FROM ventas v
INNER JOIN cliente c      ON v.id_cliente = c.id_cliente
INNER JOIN productos p    ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
INNER JOIN territorios t  ON c.id_territorio = t.id_territorio
ORDER BY v.fecha_venta;
```

---

## Dashboard en Power BI

El archivo `Seminare_Gino_Checkpoint2.pbix` contiene el dashboard del proyecto.

![Vista previa del dashboard](img/dashboard.png)

Para abrirlo:

1. Instalá **Power BI Desktop**.
2. Abrí el archivo `.pbix`.
3. Verificá la conexión con la base `Ventas_Tech_DB` y, si hace falta, actualizá los datos con **Actualizar**.

---

## Análisis que permite el proyecto

* **Ventas:** facturación, cantidad de pedidos, evolución mensual, ticket promedio.
* **Productos:** unidades vendidas, facturación y ranking.
* **Clientes:** clientes recurrentes, gasto acumulado, clientes sin compras.
* **Categorías:** facturación por categoría.
* **Territorios:** distribución geográfica de clientes y ventas.

---

## Autor

**Gino Seminare** — Data Analytics, Coderhouse.
