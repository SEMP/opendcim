# OpenDCIM Demo Data Scripts

## Descripción

Esta carpeta contiene scripts para poblar OpenDCIM con datos de demostración realistas para un centro de datos orientado a Inteligencia Artificial.

## Scripts Funcionales

### `populate_demo_data.sh`
Script principal para poblar OpenDCIM con datos de demostración.

**Uso:**
```bash
cd workspace/opendcim-stack
./scripts/populate_demo_data.sh
```

**Requisitos:**
- Contenedores OpenDCIM ejecutándose (`docker compose up -d`)
- Acceso a base de datos MariaDB

### `final_demo_data.sql`
Script SQL funcional que crea la infraestructura de demostración.

**Contiene:**
- 1 Centro de datos: AI Research Center Madrid (5MW)
- 16 Servidores GPU: DGX A100 (entrenamiento) + DGX H100 (inferencia) + Dell R750 (gestión)
- 4 Gabinetes organizados por función
- 10 Máquinas virtuales para Kubernetes y monitoreo
- 6 Tags de categorización
- 3 Departamentos organizacionales

## Scripts Deprecados

La carpeta `deprecated/` contiene versiones anteriores que fallaron debido a:

### `populate_ai_datacenter.sql`
- **Problema**: Campos requeridos faltantes (ChassisSlots, ZoneID)
- **Error**: `Field 'ChassisSlots' doesn't have a default value`

### `simple_demo_data.sql`
- **Problema**: Nombre de campo incorrecto en fac_People
- **Error**: `Unknown column 'Department' in 'INSERT INTO'`

### `minimal_demo_data.sql`
- **Problema**: Estructura de tabla fac_Tags incorrecta
- **Error**: `Unknown column 'TagName' in 'INSERT INTO'`

## Estructura de Datos Creada

```
AI Research Center Madrid
├── AI-TRAIN-01 (Cabinet)
│   ├── AI-TRAIN-SRV-01 (DGX A100) - LLM Training: GPT Models
│   ├── AI-TRAIN-SRV-02 (DGX A100) - LLM Training: BERT Models
│   ├── AI-TRAIN-SRV-03 (DGX A100) - Computer Vision Training
│   └── AI-TRAIN-SRV-04 (DGX A100) - Multimodal AI Training
├── AI-TRAIN-02 (Cabinet)
│   ├── AI-TRAIN-SRV-05 (DGX A100) - Reinforcement Learning
│   ├── AI-TRAIN-SRV-06 (DGX A100) - Research Workloads
│   ├── AI-TRAIN-SRV-07 (DGX A100) - NLP Model Development
│   └── AI-TRAIN-SRV-08 (DGX A100) - Time Series Analysis
├── AI-INFER-01 (Cabinet)
│   ├── AI-INFER-SRV-01 (DGX H100) - Real-time Inference: ChatBot API
│   ├── AI-INFER-SRV-02 (DGX H100) - Real-time Inference: Computer Vision
│   ├── AI-INFER-SRV-03 (DGX H100) - Batch Inference: Analytics
│   └── AI-INFER-SRV-04 (DGX H100) - Model Serving Platform
└── MGT-01 (Cabinet)
    ├── K8S-MASTER-01 (Dell R750) - Kubernetes Master Node 1
    ├── K8S-MASTER-02 (Dell R750) - Kubernetes Master Node 2
    ├── MONITOR-SRV-01 (Dell R750) - Prometheus + Grafana Monitoring
    └── STORAGE-SRV-01 (Dell R750) - MinIO Object Storage
```

## Métricas de Demostración

- **Consumo de energía total**: 96kW
  - Training servers: 52kW (8 × 6.5kW)
  - Inference servers: 40.8kW (4 × 10.2kW)
  - Management servers: 3.2kW (4 × 0.8kW)
- **Utilización de espacio**: 84 rack units utilizados
- **Máquinas virtuales**: 10 VMs para servicios de infraestructura
- **Categorización**: 6 tags para organización funcional

## Propósito Académico

Estos datos permiten generar capturas de pantalla realistas para:

1. **Análisis comparativo** OpenDCIM vs Schneider EcoStruxure IT
2. **Demostración de capacidades** DCIM para centros de datos de IA
3. **Evaluación de criterios** específicos para infraestructuras ML/AI
4. **Documentación académica** de implementaciones DCIM

## Mantenimiento

Para actualizar o modificar los datos de demostración:

1. Editar `final_demo_data.sql` con los cambios necesarios
2. Probar en entorno de desarrollo
3. Actualizar este README si cambia la estructura
4. Mantener compatibilidad con las capturas de pantalla existentes