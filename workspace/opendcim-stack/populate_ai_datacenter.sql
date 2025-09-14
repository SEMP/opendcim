-- OpenDCIM Demo Data Population Script for AI Data Center
-- This script creates realistic data for demonstrating DCIM capabilities
-- for AI/ML workloads in academic evaluation

-- 1. Create Data Center (ignore if exists)
INSERT IGNORE INTO fac_DataCenter (
    Name, SquareFootage, DeliveryAddress, countryCode, Administrator,
    MaxkW, DrawingFileName, EntryLogging, ContainerID, MapX, MapY, U1Position
) VALUES (
    'AI Research Center Madrid', 15000, 'Calle Alcalá 123, Madrid', 'ES', 'admin',
    5000, '', 1, 1, 0, 0, 'Default'
);

-- 2. Create Manufacturers (ignore duplicates)
INSERT IGNORE INTO fac_Manufacturer (Name) VALUES
('NVIDIA'),
('Dell Technologies'),
('HPE'),
('Supermicro'),
('Cisco'),
('Mellanox'),
('Intel'),
('AMD'),
('Schneider Electric'),
('Vertiv');

-- 3. Create Device Templates for AI Hardware

-- GPU Server Template (NVIDIA DGX A100)
INSERT INTO fac_DeviceTemplate (
    ManufacturerID, Model, Height, Weight, Wattage, DeviceType,
    PSCount, NumPorts, Notes, FrontPictureFile, RearPictureFile, ChassisSlots, RearChassisSlots
) VALUES (
    1, 'DGX A100', 6, 124, 6500, 'Server',
    4, 8, '8x NVIDIA A100 80GB GPUs, 2x AMD EPYC 7742 CPUs', '', '', 0, 0
);

-- GPU Server Template (NVIDIA DGX H100)
INSERT INTO fac_DeviceTemplate (
    ManufacturerID, Model, Height, Weight, Wattage, DeviceType,
    PSCount, NumPorts, Notes, FrontPictureFile, RearPictureFile, ChassisSlots, RearChassisSlots
) VALUES (
    1, 'DGX H100', 6, 124, 10200, 'Server',
    4, 8, '8x NVIDIA H100 80GB GPUs, 2x Intel Xeon Scalable CPUs', '', '', 0, 0
);

-- High-Performance Storage
INSERT INTO fac_DeviceTemplate (
    ManufacturerID, Model, Height, Weight, Wattage, DeviceType,
    PSCount, NumPorts, Notes, FrontPictureFile, RearPictureFile, ChassisSlots, RearChassisSlots
) VALUES (
    2, 'PowerScale F710', 2, 35, 450, 'Storage Array',
    2, 4, 'All-flash NVMe storage for AI datasets', '', '', 0, 0
);

-- InfiniBand Switch
INSERT INTO fac_DeviceTemplate (
    ManufacturerID, Model, Height, Weight, Wattage, DeviceType,
    PSCount, NumPorts, Notes, FrontPictureFile, RearPictureFile, ChassisSlots, RearChassisSlots
) VALUES (
    6, 'MSN4700-WS', 1, 15, 319, 'Switch',
    2, 32, '32-port 200Gb/s InfiniBand switch', '', '', 0, 0
);

-- Management Server
INSERT INTO fac_DeviceTemplate (
    ManufacturerID, Model, Height, Weight, Wattage, DeviceType,
    PSCount, NumPorts, Notes, FrontPictureFile, RearPictureFile, ChassisSlots, RearChassisSlots
) VALUES (
    2, 'PowerEdge R750', 2, 24, 800, 'Server',
    2, 8, 'Management and orchestration server', '', '', 0, 0
);

-- 4. Create Cabinet Rows
INSERT INTO fac_CabRow (Name, DataCenterID) VALUES
('AI Compute Row A', 1),
('AI Compute Row B', 1),
('Storage Row', 1),
('Network Row', 1);

-- 5. Create Cabinets for AI Infrastructure
INSERT INTO fac_Cabinet (
    DataCenterID, Location, LocationSortable, AssignedTo, ZoneID, CabRowID,
    CabinetHeight, Model, MaxKW, MaxWeight, InstallationDate,
    MapX1, MapX2, MapY1, MapY2, FrontEdge, Notes
) VALUES
-- AI Compute Cabinets
(1, 'A-01', 'A-001', 0, 0, 1, 42, 'ER8000', 25, 2000, CURDATE(), 100, 150, 100, 300, 'Top', 'GPU Training Cluster'),
(1, 'A-02', 'A-002', 0, 0, 1, 42, 'ER8000', 25, 2000, CURDATE(), 160, 210, 100, 300, 'Top', 'GPU Training Cluster'),
(1, 'A-03', 'A-003', 0, 0, 1, 42, 'ER8000', 25, 2000, CURDATE(), 220, 270, 100, 300, 'Top', 'GPU Training Cluster'),
(1, 'A-04', 'A-004', 0, 0, 1, 42, 'ER8000', 25, 2000, CURDATE(), 280, 330, 100, 300, 'Top', 'GPU Training Cluster'),
(1, 'B-01', 'B-001', 0, 0, 2, 42, 'ER8000', 25, 2000, CURDATE(), 100, 150, 350, 550, 'Top', 'GPU Inference Cluster'),
(1, 'B-02', 'B-002', 0, 0, 2, 42, 'ER8000', 25, 2000, CURDATE(), 160, 210, 350, 550, 'Top', 'GPU Inference Cluster'),
-- Storage Cabinets
(1, 'S-01', 'S-001', 0, 0, 3, 42, 'ER7000', 15, 1800, CURDATE(), 400, 450, 100, 300, 'Top', 'High-Performance Storage'),
(1, 'S-02', 'S-002', 0, 0, 3, 42, 'ER7000', 15, 1800, CURDATE(), 460, 510, 100, 300, 'Top', 'Dataset Storage'),
-- Network Cabinet
(1, 'N-01', 'N-001', 0, 0, 4, 42, 'ER6000', 10, 1000, CURDATE(), 550, 600, 100, 300, 'Top', 'Core Networking');

-- 6. Create Departments and People
INSERT INTO fac_Department (Name, ExecSponsor) VALUES
('AI Research', 'Dr. María García'),
('ML Engineering', 'Dr. Carlos Rodríguez'),
('Data Science', 'Dr. Ana Martínez'),
('DevOps', 'Ing. Luis Fernández');

INSERT INTO fac_People (UserID, LastName, FirstName, Phone1, Email, Department) VALUES
('mgarcia', 'García', 'María', '+34-91-1234567', 'm.garcia@airesearch.es', 1),
('crodriguez', 'Rodríguez', 'Carlos', '+34-91-1234568', 'c.rodriguez@airesearch.es', 2),
('amartinez', 'Martínez', 'Ana', '+34-91-1234569', 'a.martinez@airesearch.es', 3),
('lfernandez', 'Fernández', 'Luis', '+34-91-1234570', 'l.fernandez@airesearch.es', 4);

-- 7. Create AI Training Servers (DGX A100)
INSERT INTO fac_Device (
    Label, SerialNo, AssetTag, PrimaryIP, Owner, Cabinet, Position, Height,
    Ports, TemplateID, NominalWatts, PowerSupplyCount, DeviceType,
    InstallDate, Status, Notes
) VALUES
-- Cabinet A-01 - Training Cluster Alpha
('AI-TRAIN-01', 'DGX-A100-001', 'AT-001', '10.1.1.101', 1, 1, 1, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'LLM Training - GPT Models'),
('AI-TRAIN-02', 'DGX-A100-002', 'AT-002', '10.1.1.102', 1, 1, 8, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'LLM Training - BERT Models'),
('AI-TRAIN-03', 'DGX-A100-003', 'AT-003', '10.1.1.103', 1, 1, 15, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Computer Vision Training'),
('AI-TRAIN-04', 'DGX-A100-004', 'AT-004', '10.1.1.104', 1, 1, 22, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Multimodal AI Training'),
('AI-TRAIN-05', 'DGX-A100-005', 'AT-005', '10.1.1.105', 1, 1, 29, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Reinforcement Learning'),
('AI-TRAIN-06', 'DGX-A100-006', 'AT-006', '10.1.1.106', 1, 1, 36, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Research Workloads'),

-- Cabinet A-02 - Training Cluster Beta
('AI-TRAIN-07', 'DGX-A100-007', 'AT-007', '10.1.1.107', 2, 2, 1, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'NLP Model Development'),
('AI-TRAIN-08', 'DGX-A100-008', 'AT-008', '10.1.1.108', 2, 2, 8, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Image Generation Models'),
('AI-TRAIN-09', 'DGX-A100-009', 'AT-009', '10.1.1.109', 2, 2, 15, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Speech Recognition'),
('AI-TRAIN-10', 'DGX-A100-010', 'AT-010', '10.1.1.110', 2, 2, 22, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Recommendation Systems'),
('AI-TRAIN-11', 'DGX-A100-011', 'AT-011', '10.1.1.111', 2, 2, 29, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Time Series Analysis'),
('AI-TRAIN-12', 'DGX-A100-012', 'AT-012', '10.1.1.112', 2, 2, 36, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Autonomous Driving AI');

-- 8. Create H100 Inference Servers
INSERT INTO fac_Device (
    Label, SerialNo, AssetTag, PrimaryIP, Owner, Cabinet, Position, Height,
    Ports, TemplateID, NominalWatts, PowerSupplyCount, DeviceType,
    InstallDate, Status, Notes
) VALUES
-- Cabinet B-01 - Inference Cluster
('AI-INFER-01', 'DGX-H100-001', 'AI-001', '10.1.2.101', 3, 5, 1, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Real-time Inference - ChatBot'),
('AI-INFER-02', 'DGX-H100-002', 'AI-002', '10.1.2.102', 3, 5, 8, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Real-time Inference - Vision'),
('AI-INFER-03', 'DGX-H100-003', 'AI-003', '10.1.2.103', 3, 5, 15, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Batch Inference - Analytics'),
('AI-INFER-04', 'DGX-H100-004', 'AI-004', '10.1.2.104', 3, 5, 22, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Model Serving - API'),
('AI-INFER-05', 'DGX-H100-005', 'AI-005', '10.1.2.105', 3, 5, 29, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Edge AI Gateway'),
('AI-INFER-06', 'DGX-H100-006', 'AI-006', '10.1.2.106', 3, 5, 36, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Multi-tenant Inference');

-- 9. Create Storage Systems
INSERT INTO fac_Device (
    Label, SerialNo, AssetTag, PrimaryIP, Owner, Cabinet, Position, Height,
    Ports, TemplateID, NominalWatts, PowerSupplyCount, DeviceType,
    InstallDate, Status, Notes
) VALUES
-- High-Performance Storage
('AI-STORAGE-01', 'PS-F710-001', 'AS-001', '10.1.3.101', 4, 7, 1, 2, 4, 3, 450, 2, 'Storage Array', CURDATE(), 'Production', 'Training Datasets - 500TB NVMe'),
('AI-STORAGE-02', 'PS-F710-002', 'AS-002', '10.1.3.102', 4, 7, 4, 2, 4, 3, 450, 2, 'Storage Array', CURDATE(), 'Production', 'Model Checkpoints - 200TB NVMe'),
('AI-STORAGE-03', 'PS-F710-003', 'AS-003', '10.1.3.103', 4, 7, 7, 2, 4, 3, 450, 2, 'Storage Array', CURDATE(), 'Production', 'Inference Cache - 100TB NVMe'),
-- Dataset Archive Storage
('AI-ARCHIVE-01', 'PS-F710-004', 'AS-004', '10.1.3.201', 4, 8, 1, 2, 4, 3, 450, 2, 'Storage Array', CURDATE(), 'Production', 'Raw Datasets - 1PB Capacity'),
('AI-ARCHIVE-02', 'PS-F710-005', 'AS-005', '10.1.3.202', 4, 8, 4, 2, 4, 3, 450, 2, 'Storage Array', CURDATE(), 'Production', 'Backup & Archive - 500TB');

-- 10. Create Network Infrastructure
INSERT INTO fac_Device (
    Label, SerialNo, AssetTag, PrimaryIP, Owner, Cabinet, Position, Height,
    Ports, TemplateID, NominalWatts, PowerSupplyCount, DeviceType,
    InstallDate, Status, Notes
) VALUES
-- InfiniBand Core Switches
('IB-CORE-01', 'MSN4700-001', 'IB-001', '10.1.4.101', 4, 9, 1, 1, 32, 4, 319, 2, 'Switch', CURDATE(), 'Production', 'InfiniBand 200Gb Core Switch'),
('IB-CORE-02', 'MSN4700-002', 'IB-002', '10.1.4.102', 4, 9, 3, 1, 32, 4, 319, 2, 'Switch', CURDATE(), 'Production', 'InfiniBand 200Gb Core Switch'),
-- Management Servers
('MGT-MASTER-01', 'PE-R750-001', 'MG-001', '10.1.4.201', 4, 9, 5, 2, 8, 5, 800, 2, 'Server', CURDATE(), 'Production', 'Kubernetes Master Node'),
('MGT-MASTER-02', 'PE-R750-002', 'MG-002', '10.1.4.202', 4, 9, 8, 2, 8, 5, 800, 2, 'Server', CURDATE(), 'Production', 'Kubernetes Master Node'),
('MGT-MONITOR-01', 'PE-R750-003', 'MG-003', '10.1.4.203', 4, 9, 11, 2, 8, 5, 800, 2, 'Server', CURDATE(), 'Production', 'Monitoring & Logging Server');

-- 11. Update Configuration for Dashboard Display
INSERT INTO fac_Config (Parameter, Value, UnitOfMeasure, ValType, DefaultVal) VALUES
('DCIMVersion', '23.04', '', 'string', '23.04'),
('FacilityName', 'AI Research Center Madrid', '', 'string', 'Your Facility'),
('DefaultPanelVoltage', '230', 'Volts', 'int', '120'),
('PowerRed', '80', '%', 'int', '80'),
('PowerYellow', '60', '%', 'int', '60'),
('TempRed', '80', '°C', 'int', '80'),
('TempYellow', '60', '°C', 'int', '60'),
('WeightRed', '80', '%', 'int', '80'),
('WeightYellow', '60', '%', 'int', '60')
ON DUPLICATE KEY UPDATE Value=VALUES(Value);

-- 12. Create some power connections to show power tracking
INSERT INTO fac_PowerDistribution (
    Label, CabinetID, PowerType, Voltage, Amperage, Description
) VALUES
('PDU-A01-001', 1, 'Three Phase Delta', 400, 63, 'Primary PDU for AI Training Cabinet A-01'),
('PDU-A02-001', 2, 'Three Phase Delta', 400, 63, 'Primary PDU for AI Training Cabinet A-02'),
('PDU-B01-001', 5, 'Three Phase Delta', 400, 63, 'Primary PDU for AI Inference Cabinet B-01'),
('PDU-S01-001', 7, 'Single Phase', 230, 32, 'PDU for Storage Cabinet S-01');

-- 13. Add some VM inventory for virtualization tracking
INSERT INTO fac_VMInventory (
    DeviceID, vmID, vmName, vmState, Owner, PrimaryContact,
    LastUpdated, vmNotes
) VALUES
(23, 'vm-k8s-master-01', 'k8s-master-01', 'on', 4, 4, NOW(), 'Kubernetes Master Node Primary'),
(23, 'vm-prometheus-01', 'prometheus-monitoring', 'on', 4, 4, NOW(), 'Prometheus Monitoring Stack'),
(23, 'vm-grafana-01', 'grafana-dashboard', 'on', 4, 4, NOW(), 'Grafana Dashboards'),
(24, 'vm-k8s-master-02', 'k8s-master-02', 'on', 4, 4, NOW(), 'Kubernetes Master Node Secondary'),
(24, 'vm-jupyter-hub', 'jupyterhub-ai', 'on', 2, 2, NOW(), 'JupyterHub for AI Research'),
(25, 'vm-mlflow-01', 'mlflow-tracking', 'on', 2, 2, NOW(), 'MLflow Model Registry');

-- 14. Add device tags for categorization
INSERT INTO fac_Tags (TagName, TagColor) VALUES
('AI-Training', 'FF0000'),
('AI-Inference', '00FF00'),
('High-Performance', '0000FF'),
('GPU-Compute', 'FF8800'),
('Critical', 'FF0000'),
('Research', '8800FF');

-- Associate tags with devices
INSERT INTO fac_DeviceTags (DeviceID, TagID) VALUES
-- Tag training servers
(1, 1), (1, 4), (1, 5),  -- AI-TRAIN-01
(2, 1), (2, 4), (2, 5),  -- AI-TRAIN-02
(3, 1), (3, 4), (3, 6),  -- AI-TRAIN-03
(13, 2), (13, 4), (13, 5), -- AI-INFER-01
(14, 2), (14, 4), (14, 5), -- AI-INFER-02
(17, 3), (17, 5),        -- AI-STORAGE-01
(18, 3), (18, 5);        -- AI-STORAGE-02

-- 15. Add some sensor readings for environmental monitoring
INSERT INTO fac_SensorTemplate (
    ManufacturerID, Name, SNMPVersion, TemperatureOID, HumidityOID,
    TempMultiplier, HumidityMultiplier, mUnits
) VALUES
(9, 'NetBotz Environmental Monitor', '2c', '1.3.6.1.4.1.5528.100.4.1.1.1.4', '1.3.6.1.4.1.5528.100.4.1.1.1.6', 1, 1, 'english');

-- Summary statistics will be automatically calculated by OpenDCIM
-- This gives us a realistic AI data center with:
-- - 18 GPU servers (12 training + 6 inference)
-- - 5 storage arrays with high-performance NVMe
-- - Network infrastructure with InfiniBand
-- - Management and monitoring servers
-- - Proper power distribution
-- - Environmental monitoring
-- - Device categorization with tags