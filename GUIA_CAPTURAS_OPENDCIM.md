# Guía de Capturas de Pantalla - OpenDCIM para Análisis Académico

## Objetivo

Esta guía proporciona instrucciones detalladas para generar capturas de pantalla de OpenDCIM que demuestren las capacidades evaluadas en el análisis comparativo académico contra Schneider EcoStruxure IT.

## Preparación del Entorno

### 1. Navegación en OpenDCIM

**URLs Principales Verificadas**:
- **Dashboard**: http://localhost:8080/ (página principal)
- **Búsqueda de Dispositivos**: http://localhost:8080/search.php
- **Dispositivo Específico**: http://localhost:8080/devices.php?DeviceID=X (donde X = 1,2,3...)
- **Gestión de Cabinets**: http://localhost:8080/cabinets.php?cabinetid=X
- **Data Center**: http://localhost:8080/datacenter.php?dc=1
- **Energía**: http://localhost:8080/power_panel.php
- **Personal**: http://localhost:8080/people_depts.php
- **Virtualización**: Accesible desde el menú principal
- **Configuración**: http://localhost:8080/config.php

**Nota Importante**: `devices.php` sin parámetros muestra un formulario de edición. Para ver dispositivos usa `search.php` o `devices.php?DeviceID=X`.

### 2. Población de Datos Demo

Antes de generar las capturas, ejecutar el script de población de datos:

```bash
cd workspace/opendcim-stack
./populate_demo_data.sh
```

Este script creará:
- **1 Centro de Datos**: "AI Research Center Madrid"
- **18 Servidores GPU**: DGX A100 y H100 para entrenamiento e inferencia
- **5 Arrays de Almacenamiento**: Sistemas NVMe de alto rendimiento
- **Infraestructura de Red**: Switches InfiniBand y servidores de gestión
- **4 Departamentos**: Con personal asignado
- **9 Gabinetes**: Organizados por función (entrenamiento, inferencia, almacenamiento)

### 2. Verificación del Estado

Confirmar que los contenedores están funcionando:
```bash
docker compose ps
```

Acceder a OpenDCIM: http://localhost:8080

## Capturas de Pantalla Requeridas

### 1. Dashboard Principal - Métricas Generales

**Objetivo**: Demostrar capacidades básicas de inventario y métricas

**URL**: http://localhost:8080/
**Elementos a mostrar**:
- Conteo de dispositivos físicos
- Conteo de servidores
- Utilización de espacio (rack units)
- Consumo de energía estimado
- Máquinas virtuales
- Ratio de virtualización

**Punto de comparación**: Criterio #7 - Análisis de Capacidad y Planificación

### 2. Inventario de Dispositivos por Categoría

**Objetivo**: Mostrar capacidades de gestión de activos especializados

**URL**: http://localhost:8080/search.php
**Búsqueda a realizar**:
- Buscar "Server" en Device Type
- O usar filtro avanzado para dispositivos GPU
- Alternativamente ir directo a un dispositivo: http://localhost:8080/devices.php?DeviceID=1

**Elementos a destacar**:
- Lista de servidores AI-TRAIN-SRV-01 a AI-TRAIN-SRV-08 (DGX A100)
- Servidores AI-INFER-SRV-01 a AI-INFER-SRV-04 (DGX H100)
- Consumo energético por dispositivo (6.5kW, 10.2kW)
- Estados operacionales
- Ubicación en gabinetes

**Punto de comparación**: Criterio #1 - Integración con Sistemas de Monitoreo de Clusters IA

### 3. Vista de Data Center - Layout Físico

**Objetivo**: Demostrar capacidades de visualización espacial

**URL**: http://localhost:8080/datacenter.php?dc=1
**Elementos a mostrar**:
- Distribución de gabinetes por filas
- Códigos de colores por función:
  - Rojo: Entrenamiento (A-01 a A-04)
  - Verde: Inferencia (B-01, B-02)
  - Azul: Almacenamiento (S-01, S-02)
  - Amarillo: Red (N-01)

**Punto de comparación**: Criterio #7 - Análisis de Capacidad y Planificación

### 4. Detalle de Gabinete - Utilización de Espacio

**Objetivo**: Mostrar gestión detallada de espacio y power

**URL**: http://localhost:8080/cabinets.php?cabinetid=1 (Gabinete A-01)
**Elementos a destacar**:
- 6 servidores DGX A100 instalados
- Utilización de 36U de 42U disponibles (85.7%)
- Consumo total de energía: ~39kW
- Distribución de dispositivos por altura
- Gestión de cables frontales/traseros

**Punto de comparación**: Criterio #6 - Monitoreo de Cooling Inteligente (limitado en OpenDCIM)

### 5. Vista de Dispositivo Individual

**Objetivo**: Demostrar nivel de detalle por activo

**URL**: http://localhost:8080/devices.php?DeviceID=1 (AI-TRAIN-SRV-01)
**Elementos a mostrar**:
- Especificaciones técnicas completas
- Información de garantía y mantenimiento
- Puertos de red configurados
- Tags asignados ("AI-Training", "GPU-Compute", "Critical")
- Notas operacionales ("LLM Training - GPT Models")
- Historial de auditoría

**Punto de comparación**: Criterio #5 - Seguridad de Datos Sensibles (básico en OpenDCIM)

### 6. Reportes de Energía

**Objetivo**: Mostrar capacidades básicas de eficiencia energética

**URL**: http://localhost:8080/power_panel.php
**Elementos a mostrar**:
- Distribución de energía por gabinete
- PDUs instalados
- Capacidades vs. consumo actual
- Métricas básicas de utilización

**Limitación a destacar**: OpenDCIM no calcula PUE automáticamente

**Punto de comparación**: Criterio #3 - Optimización Energética (limitado comparado con EcoStruxure IT)

### 7. Gestión de Personal y Departamentos

**Objetivo**: Demostrar capacidades de gestión organizacional

**URL**: http://localhost:8080/people_depts.php
**Elementos a mostrar**:
- 4 departamentos creados (AI Research, ML Engineering, Data Science, DevOps)
- Personal asignado con contactos
- Responsabilidades por activos
- Estructura organizacional

**Punto de comparación**: Criterio #12 - Facilidad de Implementación y Uso

### 8. Inventario de Virtualización

**Objetivo**: Mostrar seguimiento de VMs en infraestructura

**URL**: http://localhost:8080/virtualization.php
**Elementos a mostrar**:
- VMs de Kubernetes (k8s-master-01, k8s-master-02)
- Servicios de monitoreo (prometheus-monitoring, grafana-dashboard)
- Servicios de ML (jupyterhub-ai, mlflow-tracking)
- Estados operacionales

**Punto de comparación**: Criterio #8 - Integración con Orquestadores (básico en OpenDCIM)

### 9. Sistema de Tags y Categorización

**Objetivo**: Demostrar organización por categorías funcionales

**URL**: http://localhost:8080/tags.php
**Elementos a mostrar**:
- Tags creados: AI-Training, AI-Inference, High-Performance, GPU-Compute, Critical, Research
- Código de colores por categoría
- Dispositivos asociados a cada tag
- Filtrado por categorías

**Punto de comparación**: Criterio #9 - Alertas y Notificaciones Inteligentes (básico)

### 10. Interface de Configuración

**Objetivo**: Mostrar flexibilidad y opciones de customización

**URL**: http://localhost:8080/config.php
**Elementos a mostrar**:
- Parámetros configurables
- Unidades de medida
- Valores por defecto
- Opciones de integración básicas

**Punto de comparación**: Criterio #11 - Costo Total de Propiedad (ventaja: open source)

## Capturas Adicionales para Contrastar Limitaciones

### 11. Ausencia de Capacidades Predictivas

**Captura**: Dashboard principal sin métricas predictivas
**Objetivo**: Demostrar la ausencia de IA/ML nativo
**Contraste**: EcoStruxure IT incluye Asset Advisor con predicción de fallos

### 12. Reportes Básicos vs. Inteligentes

**Captura**: Reportes estándar sin análisis automático
**Objetivo**: Mostrar limitaciones en business intelligence
**Contraste**: EcoStruxure IT ofrece reporting automatizado y compliance

### 13. Configuración Manual vs. Automatización

**Captura**: Formularios de configuración manual
**Objetivo**: Destacar requerimiento de configuración manual extensiva
**Contraste**: EcoStruxure IT ofrece auto-discovery y configuración asistida

## Puntos Clave para el Análisis

### Fortalezas de OpenDCIM Demostradas:

1. **Inventario Completo**: Tracking detallado de todos los activos
2. **Flexibilidad**: Soporte para hardware diverso y configuraciones personalizadas
3. **Organización**: Sistema de tags y categorización funcional
4. **Costo**: Solución completamente gratuita y open source
5. **Transparencia**: Acceso completo a datos y configuración

### Limitaciones Evidenciadas:

1. **Ausencia de IA**: No hay capacidades predictivas o de machine learning
2. **Métricas Manuales**: PUE y métricas de eficiencia requieren cálculo manual
3. **Alertas Básicas**: Sistema de notificaciones simple sin inteligencia contextual
4. **Integraciones Limitadas**: APIs básicas requieren desarrollo personalizado
5. **UX Básica**: Interface funcional pero sin optimización de experiencia de usuario

## Secuencia de Capturas Recomendada

1. **Contexto General** (Capturas 1-3): Mostrar capacidades básicas funcionales
2. **Detalle Técnico** (Capturas 4-6): Demostrar profundidad de información
3. **Gestión Operacional** (Capturas 7-10): Mostrar aspectos organizacionales
4. **Limitaciones** (Capturas 11-13): Contrastar con capacidades de EcoStruxure IT

## Configuración de Captura

### Resolución Recomendada: 1920x1080
### Formato: PNG para calidad académica
### Elementos a incluir en cada captura:
- URL visible en barra de navegación
- Timestamp del sistema
- Datos representativos del centro de datos de IA
- Interfaz completa sin elementos cortados

## Documentación Complementaria

Para cada captura, incluir:
1. **Descripción técnica**: Qué se está mostrando
2. **Relevancia académica**: Cómo se relaciona con los criterios de evaluación
3. **Comparación implícita**: Qué capacidad equivalente ofrece EcoStruxure IT
4. **Limitaciones identificadas**: Qué no se puede hacer con OpenDCIM

Este enfoque proporcionará evidencia visual completa para sustentar el análisis comparativo académico, demostrando tanto las capacidades como las limitaciones de OpenDCIM en el contexto de centros de datos orientados a IA.